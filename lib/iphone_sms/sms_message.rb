module IPhoneSMS
  
  class SMSMessage
    
    attr_reader :to, :from, :date, :text
    attr_accessor :in_reply_to
    
    def initialize(iphone, group_name, msg_id, flags, date, text, address)
      @date = convert_iphone_date(date)
      @text = text
      @message_id = msg_id
      
      phone = [iphone.name, iphone.number]
      message = [group_name, address]
      @from, @to = case flags
      when 0, 2
        [message, phone]
      when 3
        [phone, message]
      else
        raise "uh oh, don't know how to handle the sms message flag #{flags}, file a bug and/or patch!"
      end
    end
    
    def message_id
      "<iphone_data-#{@message_id}@#{from[1]}>" # mutt doesn't like short message_id prefixes before the @
    end
    
    def to_s(format = :log)
      case format
      when :log
        "#{date} [#{to[0]} -> #{from[0]}] #{text.inspect}"
      when :mbox
        [ "From #{from[1]}  #{date.strftime('%a %b %d %H:%M:%S %Y')}", # mbox message header (?)
          "From: #{format_address(from)}",
          "To: #{format_address(to)}",
          "Date: #{date.rfc2822}",
          "Message-ID: #{message_id}",
          in_reply_to ? "In-Reply-To: #{in_reply_to}" : nil,
          "",
          text,
          "\n" # puts won't put a second trailing newline. force it.
        ].compact.join("\n")
      else
        raise "unrecognized format #{format.inspect}"
      end
    end
    
    def <=>(other)
      if date == other.date
        to_s <=> other.to_s # compare everything else if the dates match
      else
        date <=> other.date
      end
    end
    
    include Comparable
    
    private
    
    def format_address(address)
      "#{address[0].inspect} <#{address[1]}>"
    end
    
    def convert_iphone_date(date)
      (Time.gm(1970, 1, 1) + date).localtime
    end
    
  end
  
end
