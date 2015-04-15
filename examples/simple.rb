#!/usr/bin/env ruby
require File.join('./', File.dirname(__FILE__), '..','lib','keycdn')
#require "keycdn"

keycdn = KeyCDN::Client.new(ENV["APIKEY"])

puts 'GET /zones.json'
puts keycdn.get("zones.json")

puts 'GET /zones/<zoneId>.json'
puts keycdn.get("zones/<zoneId>.json")

time = Time.now.to_i

report = {
  :start => time-3600,
  :end  => time
}

puts 'GET reports/credits.json'
puts keycdn.get("reports/credits.json", report)
