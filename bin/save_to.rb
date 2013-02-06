require 'json'
require 'nokogiri'
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

  def write_txt(filename)
    begin
      CSV.open(filename,"w", "\t") do |file|
        file <<  [person[:id],person[:regdate],person[:first_name].capitalize,person[:last_name].capitalize,person[:email],person[:phone],person[:street],person[:city].capitalize,person[:state].upcase,person[:zipcode]]
      end
    rescue
      puts "Cannot write TXT file"
    end
  end

  def write_json(filename)
    begin
      puts @queue.to_json
    rescue
      puts "Cannot write to JSON"
    end
  end

  def write_xml(filename)    
    builder = Nokogiri::XML::Builder.new do |xml|
      xml.root {
        xml.event_attendees {
          @queue.each do |person|
            xml.attendee {
              xml.person_id person[:id]
              xml.registration_date person[:regdate]
              xml.first_name person[:first_name].capitalize
              xml.last_name person[:last_name].capitalize
              xml.email person[:email]
              xml.phone person[:phone]
              xml.address {
                xml.street person[:street]
                xml.city person[:city].capitalize
                xml.state person[:state].upcase
                xml.zipcode person[:zipcode]
              }
            }
          end
        }
      }
    end
    puts builder.to_xml  
      # puts @queue.to_xml(:root => 'attendee')
      # # my_xml  = @queue.each do |person|
      # #     end
    end
    
    def parse_user_input(input)
      warn "THIS IS A WARNING"
      filetype = input[-4..-1]
      if filetype == ".csv"
        write_csv(input)
      elsif filetype == "json"
        write_json(input)
      elsif filetype == ".txt"
        write_txt(input)
      elsif filetype == ".xml"
        write_xml(input)
      else
        puts "does not compute"
      end
    end     

  end