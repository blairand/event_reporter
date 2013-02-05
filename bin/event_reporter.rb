
  require 'csv'
  require 'date'

class EventReporter

    def initialize
    @people = []
    @list = []
    @queue = []
    @contents = CSV.open('event_attendees.csv', headers: true, header_converters: :symbol )
  end


 def parse_file
    @contents.each do |row|
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
    puts "Loaded #{@people.count} Records..." 
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



def queue(input)
    parts = input.split
    command = parts[0]
    case command
  # when 'help' then puts "\n Run 'queue count' to show number of items in queue. \n Run 'queue clear' to clear the items in the queue."
    when 'count' then puts @queue.count
    when 'clear' then puts "Queue Cleared..."
    when 'print' then puts 'puts queue print'
    when 'save' then puts 'puts queue save'
    when 'print' then puts 'puts print by last name'
    else
      puts "What would you like to queue?"
    end
end

def find_first_name(input)
  @queue = @people.select{|key,value| key[:first_name]==input}
  puts "Found #{@queue.count} records"
end

def find_last_name(input)
@queue = @people.select{|key,value| key[:last_name]==input}
  puts "Found #{@queue.count} records"
end

def find_by_city(input)
  @queue = @people.select{|key,value| key[:city]==input}
  puts "Found #{@queue.count} records"
end

def find_by_state(input)
@queue = @people.select{|key,value| key[:state]==input}
  puts "Found #{@queue.count} records"
end

def find_by_zip(input)
@queue = @people.select{|key,value| key[:zipcode]==input}
  puts "Found #{@queue.count} records"
end

def find(input)
  parts = input.split
  command = parts[0]
  case command
  # when 'help' then puts "\n Run 'queue count' to show number of items in queue. \n Run 'queue clear' to clear the items in the queue."
  when 'first_name' then find_first_name(parts[1..-1].join(" ")) #find first_name mary
  when 'last_name' then find_last_name(parts[1..-1].join(" ")) #find last_name anderson
  when 'phone' then puts "puts phone"
  when 'city' then find_by_city(parts[1..-1].join(" "))
  when 'state' then find_by_state(parts[1..-1].join(" "))
  when 'zipcode' then find_by_zip(parts[1..-1].join(" "))
  else
    puts "What would you like to find?"
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
    when 'load' then parse_file
    when 'find' then find(parts[1..-1].join(" "))
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
end