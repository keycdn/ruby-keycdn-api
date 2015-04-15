#!/usr/bin/env ruby
require File.join("./", File.dirname(__FILE__), "..","lib","keycdn")

if ENV["APIKEY"].nil?
  puts '$ export APIKEY=<your_api_key>'
end

keycdn = KeyCDN::Client.new(ENV["APIKEY"])

zone_id = '<zoneId>';

urls = {
        'urls[0]' => 'demo-1.kxcdn.com/lorem.css',
        'urls[1]' => 'demo-1.kxcdn.com/lorem.jpg'
};

puts keycdn.del("zones/purgeurl/#{zone_id}.json", urls)
