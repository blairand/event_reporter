require_relative 'save_to'

require 'csv'
require 'date'

class EventReporter

  def initialize
    @people = []
    @list = []
    @queue = []
    @contents = ""#CSV.open('event_attendees.csv', headers: true, header_converters: :symbol )
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
    #cleanup the reg date?
  end
  

  def parse_file(filename)
    @people = []
    @contents.each do |row|
      person = {}
      person[:id] = row[0]
      person[:regdate] = row[:regdate]
      person[:first_name] = row[:first_name].to_s.downcase
      person[:last_name] = row[:last_name].to_s.downcase
      person[:email] = row[:email_address].to_s.downcase
      person[:phone] = clean_phone(row[:homephone])
      person[:street] = row[:street]
      person[:city] = clean_city(row[:city])
      person[:state] = clean_state(row[:state])
      person[:zipcode] = clean_zipcode(row[:zipcode])
      @people << person 
    end
    puts "Loaded #{@people.count} Records from '#{filename}'..." 
  end

  def define_file_name(user_input)
    if user_input[-4..-1] == ".csv" && File.exist?(user_input)
      filename = user_input
    elsif user_input == "load"
      puts"Loading Default File"
      filename="event_attendees.csv"
    else 
      puts "Bro, that is not a CSV or i cannot find the file...\n \n Loading Default File."
      filename="event_attendees.csv"
    end
    @contents = CSV.open(filename, headers: true, header_converters: :symbol )
    parse_file(filename)
  end

  def print_queue(input)    
    header = "LAST NAME  FIRST NAME  EMAIL  ZIPCODE  CITY  STATE  ADDRESS  PHONE"
    if input == "print"
      puts header
      @queue.each do |person|
        puts "#{person[:last_name].ljust(15," ")}\t #{person[:first_name].ljust(5," ")}\t #{person[:email].ljust(42," ")}\t #{person[:zipcode]}\t#{person[:city].ljust(26," ")}\t#{person[:state]}\t#{person[:street].ljust(40," ")}\t#{person[:phone]}"
      end
    else
      puts header
      sorted = @queue.sort_by{|person| person[input.to_sym]}
      sorted.each do |person|
        puts "#{person[:last_name].ljust(15," ")}\t #{person[:first_name].ljust(5," ")}\t #{person[:email].ljust(42," ")}\t #{person[:zipcode]}\t#{person[:city].ljust(26," ")}\t#{person[:state]}\t#{person[:street].ljust(40," ")}\t#{person[:phone]}"
      end
    end
  end

def save_to(input,queue)
  if input == "event_attendees.csv" || input == "save"
    puts "cannot overwrite event_attendees.csv... saving to default_file.csv"    
    filename = 'default_file.csv'
  elsif input[-4..-1] ==".csv"
    filename = input  
  else
    filename = "#{input}.csv"
  end
    CSV.open(filename, "wb") do |file|
        file << %w"id regdate first_name last_name email_address homephone street city state zipcode"         
        queue.each do |person|
          file << [person[:id],person[:regdate],person[:first_name].capitalize,person[:last_name].capitalize,person[:email],person[:phone],person[:street],person[:city].capitalize,person[:state].upcase,person[:zipcode]]           
        end          
    end
    puts "Queue Saved to #{filename}"
end

  def queue(input)
    parts = input.split
    command = parts[0]
    case command
    when 'count' then puts "Found #{@queue.count} Records"
    when 'clear' 
    puts "Queue Cleared..."
    @queue = []
    when 'print' then print_queue(parts[-1])
    when 'save' then SaveTo.new(parts[-1],@queue)
    # when 'save' then save_to(parts[-1],@queue)  
    when 'print by' then puts 'puts print by last name'
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
  when 'last_name' then find_last_name(parts[1..-1].join(" ")) #find last_name smith
  when 'phone' then puts "puts phone"
  when 'city' then find_by_city(parts[1..-1].join(" "))
  when 'state' then find_by_state(parts[1..-1].join(" "))
  when 'zipcode' then find_by_zip(parts[1..-1].join(" "))
  else
    puts "What would you like to find?"
  end
end

def show_help(input)
 parts = input.split
 command = parts[0]
 case command
 when 'load' then puts "Enter 'load <filename.csv>' to load records from a new file."
 when 'find' then puts "Enter 'find <attribute> <criteria>' to load records into the Queue. \n Example: 'find first_name sarah' "
 when 'queue' then puts "Enter 'queue print' to print the queue. \n Enter 'queue clear' to clear the queue. \n"
 else 
   puts "What would you like help with? \n 'load <filename.csv'> to input records\n 'find first_name sarah' to find people named sarah. \n 'queue print' to print out all records in the queue.\n "
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
    when 'load' then define_file_name(parts[-1])
    when 'find' then find(parts[1..-1].join(" "))
    when 'queue' then queue(parts[1..-1].join(" "))
    when 'help' then show_help(parts[1..-1].join(" "))
    else
     puts "Sorry, I don't know how to #{command}."
    end

  end

  end
end