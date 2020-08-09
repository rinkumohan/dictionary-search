require_relative "dictionary"

#Program begins here
begin
  Dictionary.initiate
rescue => e
  puts "Something went wrong!"
end
