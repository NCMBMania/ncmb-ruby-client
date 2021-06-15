# frozen_string_literal: true

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'rubygems'
require 'ncmb'
require 'yaml'
yaml = YAML.load_file(File.join(File.dirname(__FILE__), '..', 'setting.yml'))
NCMB.initialize(application_key: yaml['application_key'], 
                  client_key: yaml['client_key']
                  )
json = JSON.parse(open(File.join(File.dirname(__FILE__), 'venues.json'), 'r').read)
venues_class = NCMB::DataStore.new 'Venues'
venues_class.delete_all
json['response']['venues'].each do |venue|
  item = venues_class.new
  params = {
    name: venue['name'],
    location: {
      '__type' => 'GeoPoint',
      'latitude' => venue['location']['lat'],
      'longitude' => venue['location']['lng']
    }
  }
  item.set('name', params[:name])
  item.set('location', params[:location])
  item.save
  puts "#{item.objectId} saved."
end
params = {}
params[:where] = {
  'location' => {
    '$nearSphere' => {
      '__type' => 'GeoPoint',
      'longitude' => 139.745433,
      'latitude' => 35.691152
    },
    '$maxDistanceInKilometers' => 10
  }
}
venues_class = venues_class.where("location", params[:where]['location'])
results = venues_class.get

puts results.length

results.each do |result|
  puts result.objectId
end
