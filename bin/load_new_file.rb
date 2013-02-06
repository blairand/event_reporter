require 'csv'
require 'date'

class LoadNewFile

  def initialize(user_input)
    @people = []
    @contents =" "
    @filename = ""
    if user_input[-4..-1] == ".csv" && File.exist?(user_input)
      @filename = user_input
    elsif user_input == "load"
      puts"Loading Default File"
      @filename="event_attendees.csv"
    else 
      puts "Bro, that is not a CSV or i cannot find the file...\n \n Loading Default File."
      @filename="event_attendees.csv"
    end
    @contents = CSV.open(@filename, headers: true, header_converters: :symbol )
    parse_file(@filename)
  end

  def clean_zipcode(zipcode)
    zipcode.to_s.rjust(5,"0")[0..4]
  end

  def clean_phone(dirty_phone)
    phone = dirty_phone.scan(/[0-9]/).join 
    if phone.length  == 10
      "(#{phone[0..2]})#{phone[3..5]}-#{phone[6..9]}"
    elsif phone.length ==11 && phone[0]==1
      "(#{phone[1..3]})#{phone[4..6]}-#{phone[7..10]}"
    else
      "(000)000-0000" 
    end
  end

  def clean_city(dirty_city)
    dirty_city.to_s.downcase
  end

  def clean_state(dirty_state)
    dirty_state.to_s.downcase
  end

  def clean_reg_date
    puts "puts clean reg date"
  end

  def clean_street(dirty_street)
    dirty_street.to_s.downcase
  end

  def clean_email(dirty_email)
    dirty_email.downcase
  end

  def clean_last_name(dirty_last_name)
    dirty_last_name.to_s.downcase
  end

  def clean_first_name(dirty_first_name)
    dirty_first_name.to_s.downcase
  end


  def parse_file(filename)
    @people = []
    @contents.each do |row|
      person = {}
      person[:id] = row[0]
      person[:regdate] = row[:regdate]
      person[:first_name] = clean_first_name(row[:first_name])
      person[:last_name] = clean_last_name(row[:last_name])
      person[:email] = clean_email(row[:email_address])
      person[:phone] = clean_phone(row[:homephone])
      person[:street] = clean_street(row[:street])
      person[:city] = clean_city(row[:city])
      person[:state] = clean_state(row[:state])
      person[:zipcode] = clean_zipcode(row[:zipcode])
      @people << person 
    end
    puts "Loaded #{@people.count} Records from '#{filename}'..." 
  end

  def returner
    @people
  end
end
