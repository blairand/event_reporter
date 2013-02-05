require 'csv'

class FileInput(file)

  def initialize

    @people = []
    @list = []
    @queue = []
  end

 def parse_file(contents)
    contents.each do |row|
      person = {}
      person[:id] = row[0]
      person[:regidate] = row[:regdate]
      person[:first_name] = row[:first_name].downcase
      person[:last_name] = row[:last_name].downcase
      person[:email] = row[:email_address].downcase
      person[:phone] = row[:homephone]
      person[:street] = row[:street]
      person[:city] = row[:city]
      person[:state] = row[:state]
      person[:zipcode] = row[:zipcode]
      person[:phone] = row[:homephone]
      @people << person 
    end
    puts "Loaded #{people.count} Records..." 
    puts people.select{|key,value| key[:first_name]=="mary"}
  end

  def define_file_name(user_input)
    if user_input.nil?
      filename="event_attendees.csv"
    elsif user_input[-4..-1] == ".csv" && File.exist?(user_input)
      user_input
    else 
      puts "Bro that is not a CSV or i cannot find the file"
    end
  end
  # when 'load' then
  #     filename = define_file_name(parts[1])
  #     next if filename.nil?
  #     contents = CSV.open(filename, headers: true, header_converters: :symbol )
  #     puts "#{filename} loaded!"
  #     @people = parse_file(contents)
end