require_relative 'save_to'
require_relative 'load_new_file'

require 'csv'
require 'date'
require 'gyoku'

class EventReporter

  def initialize
    @people = []
    @list = []
    @queue = []
    @contents = ""
  end




  def queue_print(input)
    first_name_length = [12]
    last_name_length = [12]
    email_length = []
    city_length = []
    street_length = []
    @queue.each do |person|    
      first_name_length << person[:first_name].length
      last_name_length << person[:last_name].length
      email_length << person[:email].length
      city_length << person[:city].length
      street_length << person[:street].length
    end
    first_name_ljust = first_name_length.max
    last_name_ljust =  last_name_length.max
    email_ljust = email_length.max
    city_ljust =  city_length.max
    street_ljust = street_length.max

    header = "#{"LAST NAME".ljust(last_name_ljust," ")}|#{"FIRST NAME".ljust(first_name_ljust)}|#{"EMAIL".ljust(email_ljust)}|#{"ZIPCODE".ljust(10," ")}|#{"CITY".ljust(city_ljust," ")}|#{"STATE".ljust(5," ")}|#{"ADDRESS".ljust(street_ljust," ")}|#{"PHONE".ljust(13," ")}"
    if input == "print"
      puts header
      @queue.each do |person|
        puts "#{person[:last_name].ljust(last_name_ljust," ")}|#{person[:first_name].ljust(first_name_ljust," ")}|#{person[:email].ljust(email_ljust," ")}|#{person[:zipcode].ljust(10," ")}|#{person[:city].ljust(city_ljust," ")}|#{person[:state].upcase.ljust(5," ")}|#{person[:street].to_s.ljust(street_ljust," ")}|#{person[:phone].ljust(13," ")}"
      end
    else
      puts header
      sorted = @queue.sort_by{|person| person[input.to_sym]}
      sorted.each do |person|
        puts "#{person[:last_name].ljust(queue_lengths[:last_name_bucket]," ")} #{person[:first_name].ljust(queue_lengths[:first_name_bucket]," ")} #{person[:email].ljust(queue_lengths[:email_bucket]," ")} #{person[:zipcode].ljust(7," ")} #{person[:city].ljust(queue_lengths[:city_bucket]," ")} #{person[:state].upcaseljust(5," ")} #{person[:street].to_s.ljust(queue_lengths[:street_bucket]," ")} #{person[:phone]}"
      end
    end
    puts "\n\n\n\n"
  end

  def queue(input)
    parts = input.split
    command = parts[0]
    case command
    when 'count' then puts "Found #{@queue.count} Records"
    when 'clear' 
    puts "Queue Cleared..."
    @queue = []
    when 'print' then queue_print(parts[-1])
    when 'save' then SaveTo.new(parts[-1],@queue)
    # when 'save' then save_to(parts[-1],@queue)  
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
  #when 'help' then puts "\n Run 'queue count' to show number of items in queue. \n Run 'queue clear' to clear the items in the queue."
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

                  class HelpText
                    def initialize
                     @command = ""
                    end

                  def help_queue(input)
                     parts = input.split
                      @command = parts[0]
                     case @command
                     when 'count' then puts "\n\n\n\n\tHelp Queue Count 'queue print' to print the queue. \n Enter 'queue clear' to clear the queue. \n"
                     when 'clear' then puts "\n\n\n\n\tEnter 'queue print' to print the queue. \n Enter 'queue clear' to clear the queue. \n"
                     when 'print' then puts "\n\n\n\nEnter 'queue print' to print the queue. \n Enter 'queue clear' to clear the queue. \n"
                     else
                  end
                  end


                    def show_help(input) 
                      parts = input.split
                      @command = parts[0]
                     case @command
                     when 'load' then puts "Enter 'load <filename.csv>' to load records from a new file."
                     when 'find' then puts "Enter 'find <attribute> <criteria>' to load records into the Queue. \n Example: 'find first_name sarah' "
                     when 'queue' 
                      help_queue(parts[1..-1].join(" "))
                     else 
                       puts "#{'-'*100}\n\n\n\n\t\tWelcome to Event Reporter. \n\n\n\n\t\tYou can Search a CSV for specific names/cities/states/zipcodes and print them  
                       \n\tType 'load <filename.csv>'' to load records\n\t Enter 'find first_name sarah' to find people named sarah. 
                       \n Type 'queue print' to print out all records in the queue.\n Type 'queue print by <attribute> to sort the data by an attribute\n
                       Type 'queue save to filename' to save the queue, JSON, XML, txt and CSV are acceptable extensions."
                     end
                    end

                  end
# def show_help(input)
#  parts = input.split
#  command = parts[0]
#  case command
#  when 'load' then puts "Enter 'load <filename.csv>' to load records from a new file."
#  when 'find' then puts "Enter 'find <attribute> <criteria>' to load records into the Queue. \n Example: 'find first_name sarah' "
#  when 'queue' then puts "Enter 'queue print' to print the queue. \n Enter 'queue clear' to clear the queue. \n"
#  else 
#    puts "What would you like help with? \n 'load <filename.csv'> to input records\n 'find first_name sarah' to find people named sarah. \n 'queue print' to print out all records in the queue.\n "
#  end
# end


 def run
  command = ""
  while command != "quit"
    printf "enter command: "
    input = gets.chomp.downcase
    parts = input.split
    command = parts[0]
    case command
    when 'quit' then puts "Goodbye!"
    when 'load' 
      @queue = []
      @people = LoadNewFile.new(parts[-1])
      @people = @people.returner
    #when 'load' then define_file_name(parts[-1])
    when 'find' then find(parts[1..-1].join(" "))
    when 'queue' then queue(parts[1..-1].join(" "))
    when 'help' 
      #show_help(parts[1..-1].join(" "))
      a = HelpText.new
      a.show_help(parts[1..-1].join(" "))

    else
     puts "Sorry, I don't know how to #{command}."
    end

  end

  end
end