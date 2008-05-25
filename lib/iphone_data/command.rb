module IPhoneData

  Command = ::Main.create do
        
    examples <<-txt
      iphone_data sms
      iphone_data dump where/to/dump/the/files
    txt
    
    run { help! }
    
    mode "sms" do
      
      description "Dumps the iPhone's SMS transcripts to stdout"
      
      option("format", "f") do
        argument_optional
        description "Format in which to dump the sms messages, One of 'log' or 'mbox'. 'mbox' format is threaded."
        default "log"
        validate { |a| %w(log mbox).include? a }
        attribute # put it in local scope for run
      end
      
      run do
        IPhoneData::IPhone.iphones.first.sms_messages.each { |m| puts m.to_s(format.to_sym) }
      end
    end
    
    mode "dump" do

      description "Decode and dump the entire contents of the iPhone backup into the specified directory"

      argument("dir") do
        required
        description "Where to put the files (creates the directory if it doesn't exist)"
        attribute
      end
      
      run do 
        where = Pathname.new(File.expand_path(dir))
        phone = IPhoneData::IPhone.iphones.first
        puts "dumping #{phone.name.inspect} to #{where}"
        phone.dump_data(where)
      end
      
    end
    
    
  end
  
end
