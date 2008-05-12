module IPhoneSMS
  
  class IPhoneData

    class << self
      
      def iphones
        @iphones ||= base_dir.children.map do |child|
          next unless child.directory?
          IPhoneData.new(child)
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
      @name ||= plist_from_file(path + "Info.plist")["Display Name"]
    end
    
    # dumps all of the raw backup data to the specified directory
    def dump_data(to)
      data.keys.each do |key|
        FileUtils.mkdir_p(to + File.dirname(key))
        File.open(to + key, "wb") do |out|
          out.write data[key].read
        end
      end
    end
    
    private
    
    def data
      @data ||= load_data_from_mdbackup_files
    end
    
    def load_data_from_mdbackup_files
      data = {}
      path.children.each do |file|
        next unless file.to_s =~ /\.mdbackup/
        puts "loading #{file}"
        file_data = plist_from_file(file)
        data[file_data["Path"]] = file_data["Data"]
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
    
  end
  
end