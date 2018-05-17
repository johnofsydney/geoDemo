require 'geocoder'
require 'pry'

opera_house = Geocoder.search('Sydney opera house')[0]
eiffel_tower = Geocoder.search('Eiffel Tower')[0]

d = Geocoder::Calculations.distance_between( opera_house.formatted_address, eiffel_tower.formatted_address )

binding.pry
