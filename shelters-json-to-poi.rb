#!/opt/stpst/embedded/bin/ruby

# Get the file using: curl -A "Mozilla/5.0 (Linux)" -o shelters.json 'http://shelterapp.dk/api/get'

require 'json'

shelters_file = File.read('shelters.json')

shelters = JSON.parse(shelters_file)


shelters.each do |shelter|
  printf("%s,%s,\"%s\",\"Features:\n", shelter['longitude'], shelter['latitude'], shelter['name'].gsub(/"/, ''))
  shelter['features'].each do |x|
    case x
      when "9002"
        puts "WC"
      when "9001"
        puts "Primitive Toilet"
      when "9000"
        puts "No information on toilet"
      when "1"
        puts "Accessible for disabled"
      when "6"
        puts "Access to drinking water"
      when "9"
        puts "Has shelter"
      when "10"
        puts "Has fireplace"
      when "11"
        puts "Accessible via Cano"
      when "12"
        puts "Has shower facilities"
      when "13"
        puts "Dogs allowed"
      when "14"
        puts "Horses allowed"
      when "15"
        puts "Accessible with baby stroller"
    end
  end
  printf("Address: %s\n", shelter['address']) unless ( shelter['address'] == '' )
  printf("Booking possible\n") if ( shelter['booking'] == 1 )
  printf("\"\n")
end
