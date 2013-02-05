class SaveTo
    def initialize(input,queue)
      @input = input
      @queue = queue
      if @input == "event_attendees.csv" || @input == "save"
        puts "Saving to default_file.csv"    
        @filename = 'default_file.csv'
        write_csv(@filename)
      else
        parse_user_input(@input)
      end
    end
    
    def write_csv(filename)
      CSV.open(filename, "wb") do |file|
          file << %w"id regdate first_name last_name email_address homephone street city state zipcode"         
          @queue.each do |person|
            file << [person[:id],person[:regdate],person[:first_name].capitalize,person[:last_name].capitalize,person[:email],person[:phone],person[:street],person[:city].capitalize,person[:state].upcase,person[:zipcode]]           
          end          
      end
      puts "Queue Saved to #{filename}"
    end
    
    def parse_user_input(input)
      filetype = input[-4..-1]
      if filetype == ".csv"
        write_csv(input)
      elsif filetype == "json"
        puts "write_json(input)"
      elsif filetype == ".xml"
        puts "write_xml(input)"
      else
        puts "does not compute"
      end
    end     

end