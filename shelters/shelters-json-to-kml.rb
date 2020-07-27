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

printf("%s\n",'<?xml version="1.0" encoding="UTF-8"?>')
printf("%s\n",'<kml xmlns="http://earth.google.com/kml/2.0">')
printf("<Document>\n")
printf("<name>Shelters in Denmark.</name>\n")
shelters.each do |shelter|
  printf("<Placemark>\n<name>%s</name>\n<description>\n", shelter['name'].gsub(/"/, '').gsub(/&/, '&amp;'))
  printf("Address: %s, ", shelter['address']) unless ( shelter['address'] == '' )

  # Process the features. Documented at https://shelterapp.dk/api/features/
  shelter['features'].each do |feature|
    case feature
      when 0
        printf("Putting up a tent is allowed.")
      when 1
        printf("Is accessible for disabled.")
      when 6
        printf("Has access to drinking water.")
      when 9
        printf("Has shelter.")
      when 10
        printf("Has fireplace.")
      when 11
        printf("Is accessible via Cano.")
      when 12
        printf("Has shower facilities.")
      when 13
        printf("Dogs allowed.")
      when 14
        printf("Horses allowed.")
      when 15
        printf("Accessible with baby stroller.")
      when 3081
        printf("Has space for hammock.")
      when 9000
        printf("No information on toilet.")
      when 9001
        printf("Has Primitive Toilet.")
      when 9002
        printf("Has WC.")
      when 9003
        printf("Is bookable.")
      when 9004
        printf("Is paid.")
      when 9005
        printf("There are photo's in the app.")
      else
        printf("This shelter has an unknown feature: %i. That's exciting! What will it be?", feature)
    end
    printf("\n")
  end
  # Default the colour is yellow
  icon_colour = "yellow"

  # Green if only a tent is allowed
  icon_colour = "green"  if ( shelter['features'].include?(0) )

  # Orange if there is a shelter and a tent is allowed
  icon_colour = "orange" if ( shelter['features'].include?(9) and shelter['features'].include?(0) )

  # Pink if there is a shelter and a tent is allowed and it has water and a toilet
  icon_colour = "pink" if ( shelter['features'].include?(9) and shelter['features'].include?(0) and shelter['features'].include?(6) and ( shelter['features'].include?(9001) or shelter['features'].include?(9002) ) )

  # Blue if there is a shelter and NO tent is explicitly allowed
  icon_colour = "blue" if ( shelter['features'].include?(9) and !shelter['features'].include?(0) )

  # Purple if it's a paid shelterplace OR reservation is possible
  icon_colour = "purple"   if ( shelter['features'].include?(9004) or shelter['features'].include?(9003) )

  # Red if it's a paid shelterplace with reservation
  icon_colour = "red"   if ( shelter['features'].include?(9004) and shelter['features'].include?(9003) )

  printf("</description>\n<Point><coordinates>%s,%s,0</coordinates>\n</Point>\n<styleUrl>#placemark-%s</styleUrl>\n</Placemark>\n", shelter['longitude'], shelter['latitude'], icon_colour)
end
printf("%s\n%s", '</Document>', '</kml>')
