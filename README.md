# Ruby gem for the KeyCDN API


## Installation

``` bash
gem install keycdn
```

> Requires Ruby 1.9.2+

#### With Bundler

```
bundle init
echo "gem 'keycdn'" >> Gemfile
bundle install --path vendor/bundle
```

## Usage

### Initial
```ruby
require 'keycdn'

# $ export APIKEY=<your_api_key>
keycdn = KeyCDN::Client.new(ENV["APIKEY"])
```

### Get all zones
```ruby
keycdn.get("zones.json")
```

### Get a specific zone
```ruby
keycdn.get("zones/<zoneId>.json")
```

### Generate reports
```ruby
time = Time.now.to_i

report = {
  :start => time-3600,
  :end  => time
}

keycdn.get("reports/traffic.json", report)
keycdn.get("reports/storage.json", report)
keycdn.get("reports/credits.json", report)
```

### Add a new zone
```ruby
zone = {
  :name => @time.to_s,
  :expire  => 1234
}

keycdn.post("zones.json", zone)
```

### Edit a zone
```ruby
zone_id = '<zoneId>'

zone = {
  :name => '<name>',
  :expire  => 4321
}

keycdn.put("zones/#{zone_id}.json", zone)
```

### Purge zone cache
```ruby
# purge zone cache
zone_id = '<zoneId>'

keycdn.get("zones/purge/#{zone_id}.json")
```

### Purge URLs
```ruby
zone_id = '<zoneId>'

urls = {
        'urls[0]' => 'demo-1.kxcdn.com/lorem.css',
        'urls[1]' => 'demo-1.kxcdn.com/lorem.jpg'
};

keycdn.del("zones/purgeurl/#{@zone_id}.json", urls)

```


For more details visit https://www.keycdn.com
