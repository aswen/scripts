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

printf("%s\r\n%s\r\n%s\r\n",'<?xml version="1.0" encoding="UTF-8"?>', '<kml xmlns="http://earth.google.com/kml/2.0">', '<Document>')
shelters.each do |shelter|
  printf("<Placemark>\r\n<name>%s</name>\r\n<description>", shelter['name'].gsub(/"/, '').gsub(/&/, '&amp;'))
  printf("Address: %s, ", shelter['address']) unless ( shelter['address'] == '' )
  counter = 1
  shelter['features'].each do |x|
    case x
      when 9002
        printf("Has WC")
      when 9001
        printf("Has Primitive Toilet")
      when 9000
        printf("No information on toilet")
      when 1
        printf("Is accessible for disabled")
      when 6
        printf("Has access to drinking water")
      when 9
        printf("Has shelter")
      when 10
        printf("Has fireplace")
      when 11
        printf("Is accessible via Cano")
      when 12
        printf("Has shower facilities")
      when 13
        printf("Dogs allowed")
      when 14
        printf("Horses allowed")
      when 15
        printf("Accessible with baby stroller")
      else
        printf("This shelter has an unknown feature: %i. That's exciting! What will it be?", x)
    end
    printf(", ") if ( counter < shelter['features'].count )
    counter += 1
  end
  printf("Booking possible") if ( shelter['booking'] == 1 )
  printf("</description>\r\n<Point><coordinates>%s,%s,0</coordinates></Point>\r\n</Placemark>\r\n", shelter['longitude'], shelter['latitude'])
end
printf("%s\r\n%s", '</Document>', '</kml>')
