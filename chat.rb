#!/usr/bin/env ruby

@db.each do |message|
  puts "#{message[0]} at #{message[1]}: #{message[2]}"
end

print "Enter name:"
name = gets.chomp
print "Enter message:"
message = gets.chomp

@db << [name, Time.now.strftime("%Y-%m-%d %H:%M:%S"), message]

BEGIN {
  require 'csv'
  @db = DATA == "" ? [] : CSV.parse(DATA, headers:true)
}

END {
  csv_string = ""
  @db.to_csv.each_line do |line|
    csv_string << line
  end

  # write csv_string to DATA part of current file
  non_data = File.read(__FILE__).split(/^__END__$/, 2).first
  File.open(__FILE__, 'w') do |f|
    f.puts non_data
    f.puts "__END__"
    f.puts csv_string
  end
}

__END__
,,
Kasper,2023-06-11 18:13:03,This makes me happy!
