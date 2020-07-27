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
  printf("Address: %s\n", shelter['address']) unless ( shelter['address'] == '' )

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
  printf("\"\n")
end
