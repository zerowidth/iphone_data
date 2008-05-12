module IPhoneData
  
  class IPhone

    class << self
      
      def iphones
        @iphones ||= base_dir.children.map do |child|
          next unless child.directory?
          new(child)
        end.compact
      end
      
      private
      
      def base_dir
        Pathname.new(File.expand_path("~/Library/Application Support/MobileSync/Backup/"))
      end
              
    end

    attr_reader :path
    
    def initialize(path)
      @path = path
    end
    
    def name
      @name ||= data["Info.plist"]["Display Name"]
    end
    
    def number
      @number ||= data["Info.plist"]["Phone Number"]
    end
    
    def sms_messages
      sms_message_groups.map do |group_id, group_name|
        sms_messages_for_group(group_id, group_name)
      end.flatten.sort
    end
    
    # dumps all of the raw backup data to the specified directory
    def dump_data(to)
      data.keys.each do |key|
        FileUtils.mkdir_p(to + File.dirname(key))
        File.open(to + key, "wb") do |out|
          case data[key]
          when IO
            out.write data[key].read # .mbackup file data
          when Hash
            out.write Plist::Emit.dump(data[key]) # Info.plist, etc.
          end
        end
      end
    end
    
    private
    
    def data
      @data ||= load_data_from_backup_files
    end
    
    def load_data_from_backup_files
      data = {}
      path.children.each do |file|
        next unless file.to_s =~ /\.(mdbackup|plist)/
        file_data = plist_from_file(file)
        if file_data["Path"] && file_data["Data"]
          data[file_data["Path"]] = file_data["Data"] # mdbackups
        else
          data[File.basename(file)] = file_data # straight plists
        end
      end
      data
    end
    
    def plist_from_file(file)
      case file.to_s
      when /\.plist/
        Plist::parse_xml(file)
      when /\.mdbackup/
        Plist::parse_xml(%x[plutil -convert xml1 -o - "#{file}"])
      end
    end
    
    def address_book
      @address_book ||= sqlite_database("Library/AddressBook/AddressBook.sqlitedb")
    end
    
    def sms_database
      @sms_database ||= sqlite_database("Library/SMS/sms.db")
    end
    
    def sqlite_database(path)
      db_file = Tempfile.new(File.basename(path), "/tmp")
      db_file.write data[path].read
      db_file.close
      db = SQLite3::Database.new(db_file.path, :type_translation => true)
    end
    
    def sms_message_groups
      sms_database.execute("select msg_group.ROWID as group_id, address from msg_group " + 
        "inner join group_member on msg_group.ROWID = group_member.group_id").map do |row|
        [row[0], name_for_number(row[1])]
      end
    end
    
    def name_for_number(number)
      alternate = number[0].chr == "1" ? number[1..-1] : "1" + number
      names_by_phone_number[number] || names_by_phone_number[alternate] || number
    end
    
    def names_by_phone_number
      @names_by_phone_number ||= address_book.execute("select p.first, p.last, mv.value from ABPerson p " + 
        "join ABMultiValue mv on p.ROWID = mv.record_id where property = 3;").inject({}) do |numbers, row|
        number = row[2].gsub(/\D/,"")
        numbers[number] = [row[0], row[1]].compact.join(" ")
        numbers
      end
    end
    
    def sms_messages_for_group(group_id, group_name)
      messages = sms_database.execute("select ROWID, flags, date, text, address " + 
        "from message where group_id = #{group_id} " + 
        "order by date asc").map do |row|
        SMSMessage.new(self, group_name, *row)
      end
      threadify(messages)
    end
    
    # associate messages into a thread. assumes the messages are only between two people, and there cannot
    # be any variation in from/to address names (i ignore the numbers, since sometimes they change slightly)
    def threadify(messages)
      last_id = {}
      messages.map do |message|
        last_id[message.from[0]] = message.message_id
        message.in_reply_to = last_id[message.to[0]]
        message
      end
    end
    
  end
  
end
