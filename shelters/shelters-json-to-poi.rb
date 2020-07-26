#!/opt/stpst/embedded/bin/ruby

require 'json'
require 'open-uri'

shelters_file = 'shelters.json'
shelters_url = 'https://shelterapp.dk/api/get'

File.open(shelters_file, "wb") do |saved_file|
  open(shelters_url, "rb") do |read_file|
    saved_file.write(read_file.read)
  end
end

shelters = JSON.parse(File.read(shelters_file))

shelters.each do |shelter|
  printf("%s,%s,\"%s\",\"Features:\n", shelter['longitude'], shelter['latitude'], shelter['name'].gsub(/"/, ''))
  shelter['features'].each do |x|
    case x
      when 9002
        puts "WC"
      when 9001
        puts "Primitive Toilet"
      when 9000
        puts "No information on toilet"
      when 1
        puts "Accessible for disabled"
      when 6
        puts "Access to drinking water"
      when 9
        puts "Has shelter"
      when 10
        puts "Has fireplace"
      when 11
        puts "Accessible via Cano"
      when 12
        puts "Has shower facilities"
      when 13
        puts "Dogs allowed"
      when 14
        puts "Horses allowed"
      when 15
        puts "Accessible with baby stroller"
    end
  end
  printf("Address: %s\n", shelter['address']) unless ( shelter['address'] == '' )
  printf("Booking possible\n") if ( shelter['booking'] == 1 )
  printf("\"\n")
end
