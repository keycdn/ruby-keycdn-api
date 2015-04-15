require 'minitest/autorun'
require 'json'
require './lib/keycdn'

if (ENV["APIKEY"].nil?)
  abort "Please export your APIKEY."
end

class ClientTest < Minitest::Unit::TestCase

    def setup
      @keycdn  = KeyCDN::Client.new(ENV["APIKEY"])
      @time = Time.now.to_i
      @zone_id = '<zoneId>'
    end

    def test_get

      [ "zonealiases.json",
        "zonereferrers.json",
        "zones.json"
      ].each do |end_point|
        key = end_point.include?("/") ? end_point.split("/")[1] : end_point.gsub(/\.json/, "")

        assert @keycdn.get(end_point)["data"][key], "get #{key} with data"
      end

    end

    def test_report

        report = {
          :start => @time-3600,
          :end  => @time
        }

        assert @keycdn.get("reports/credits.json", report)["data"]["stats"], "get credit stats"

    end

    def test_purge_zone

        assert_equal "success", @keycdn.get("zones/purge/#{@zone_id}.json")["status"], "purge zone cache"

    end

    def test_purge_urls

        urls = {
                'urls[0]' => 'demo-1.kxcdn.com/lorem.css',
                'urls[1]' => 'demo-1.kxcdn.com/lorem.jpg'
        };

        assert_equal "success", @keycdn.del("zones/purgeurl/#{@zone_id}.json", urls)["status"], "purge urls"

    end

    def test_post_and_del

      zone = {
        :name => @time.to_s,
        :expire  => 9999
      }

      zone_id = @keycdn.post("zones.json", zone)["data"]["zone"]["id"]
      assert zone_id, "post/add zone"

      assert_equal "success", @keycdn.del("zones/#{zone_id}.json")["status"], "delete zone"
    end

    def test_put

      zone = {
        :name => 'demo',
        :expire  => 8888
      }

      assert_equal @zone_id, @keycdn.put("zones/#{@zone_id}.json", zone)["data"]["zone"]["id"], "put/edit"
    end

end
