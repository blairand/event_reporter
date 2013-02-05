  #!/usr/bin/env ruby

require_relative '../lib/event_reporter/file_input_output'

  require 'csv'
  require 'sunlight'
  require 'erb'
  require 'date'


  Sunlight::Base.api_key = "e179a6973728c4dd3fb1204283aaccb5"

  def parse_file(contents)
    people = []
      contents.each do |row|
        person = {}
        person[:id] = row[0]
        person[:regidate] = row[:regdate]
        person[:first_name] = row[:first_name]
        person[:last_name] = row[:last_name]
        person[:email] = row[:email_address]
        person[:phone] = row[:homephone]
        person[:street] = row[:street]
        person[:city] = row[:city]
        person[:state] = row[:state]
        person[:zipcode] = row[:zipcode]
        person[:phone] = row[:homephone]
        people << person 
      end
      result = []
      people.collect do |person|
       result << person.select{||}[:first_name] = "John"
      end
      puts select{|key, hash| hash["client_id"] == "2180" }
    end

def define_file_name(user_input)
  if user_input.nil?
    filename="small_event_attendees.csv"
  elsif user_input[-4..-1] == ".csv" && File.exist?(user_input)
    user_input
  else 
    puts "Bro that is not a CSV or i cannot find the file"
  end
end

def queue(input, people)
  parts = input.split
  command = parts[0]
  case command
  # when 'help' then puts "\n Run 'queue count' to show number of items in queue. \n Run 'queue clear' to clear the items in the queue."
  when 'count' then puts people.count
  else
    puts "What would you like to queue?"
  end
end

  def run
    command = ""
    while command != "quit"
     printf "enter command: "
     input = gets.chomp.downcase
     parts = input.split
     command = parts[0]
     case command
     when 'quit' then puts "Goodbye!"
     when 'load' then
      filename = define_file_name(parts[1])
      next if filename.nil?
      contents = CSV.open(filename, headers: true, header_converters: :symbol )
      puts "#{filename} loaded!"
      @people = parse_file(contents)
     when 'queue' then queue(parts[1..-1].join(" "))
      # when 'queue count' then tweet(parts[1..-1].join(" "))
      # when 'dm' then dm(parts[1], parts[2..-1].join(" "))
      # when 'spam' then spam_my_followers(parts[1..-1].join(" "))
      # when 'elt' then everyones_last_tweet
      # when 'klout' then klout_score
      # when 'turl' then tweet(parts[1..-2].join(" ") + " " + shorten(parts[-1]))
    else
     puts "Sorry, I don't know how to #{command}."
   end

 end

end
run