require 'csv'

class EventReporter
  

  def clean_zipcode(zipcode)
    zipcode.to_s.rjust(5,"0")[0..4]
  end

  def clean_phone(dirty_phone)
    phone = dirty_phone.gsub(/[)(-., ]/, '') 

    if phone.length  == 10
      phone
    elsif phone.length ==11 && phone[0]==1
      phone
    else
      "0000000000"
    end
  end

  def full_date(regdate)
    DateTime.strptime(regdate, '%m/%d/%y %H:%M')
  end

  def registration_hour(regdate)
    full_date(regdate).strftime('%l %p')
  end

  def registration_day(regdate)
    full_date(regdate).strftime('%A')
  end

  def legislators_for_zipcode(zipcode)
    Sunlight::Legislator.all_in_zipcode(zipcode)
  end

  def save_thank_you_letters(id,form_letter)
    Dir.mkdir("output") unless Dir.exists?("output")

    filename = "output/thanks_#{id.rjust(5,"0")}.html"

    File.open(filename,'w') do |file|
      file.puts form_letter
    end
  end

  def ranking_of_days
    rankday = 0
    puts "\nDays by Rank: "
    Hash[most_common_day.sort_by{|k, v| v}.reverse].each do |day,value|
      rankday += 1
      puts "#{rankday}. #{day} with #{value}"
    end
  end

  def ranking_of_hours
    rankhour = 0
    puts "\nHours by Rank: "
    Hash[most_common_hour.sort_by{|k, v| v}.reverse].each do |day,value|
      rankhour +=1
      puts "#{rankhour}. #{day} with #{value}"
    end
  end


  puts "EventManager initialized."

  contents = CSV.open 'event_attendees.csv', headers: true, header_converters: :symbol

 # template_letter = File.read "form_letter.erb"
 #erb_template = ERB.new template_letter

 most_common_day = Hash.new(0)
 most_common_hour = Hash.new(0)

 # contents.each do |row|
 #  id = row[0]
 #  name = row[:first_name]
 #  zipcode = clean_zipcode(row[:zipcode])
 #  legislators = legislators_for_zipcode(zipcode)
 #  phone = clean_phone(row[:homephone])

 #  hour_registered = registration_hour(row[:regdate])
 #  most_common_hour[hour_registered] +=1

 #  day_registered = registration_day(row[:regdate])
 #  most_common_day[day_registered] += 1
 #  form_letter = erb_template.result(binding)

 #    #save_thank_you_letters(id,form_letter)
 #    # 
 #    # puts "phone: #{phone}"
 #    # puts "registered: #{hour_registered} on #{day_registered}"
 #  end

# puts "The most common day is #{most_common_day.max_by { |k, v| v }[0]} and the most common hour is #{most_common_hour.max_by { |k, v| v }[0]}"
end