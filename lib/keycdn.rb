require "uri"
require "net/http"
require "json"

module KeyCDN

    class Client

        ENDPOINT = 'https://api.keycdn.com/'

        METHOD_MAP = {
          :get    => Net::HTTP::Get,
          :post   => Net::HTTP::Post,
          :put    => Net::HTTP::Put,
          :delete => Net::HTTP::Delete
        }

        def initialize(api_key)
            @api_key = api_key
        end

        def get(url, params = {})
            call url, :get, params
        end

        def post(url, params = {})
            call url, :post, params
        end

        def put(url, params = {})
            call url, :put, params
        end

        def del(url, params = {})
            call url, :delete, params
        end

        private

        def call(url, method, params = {})
            raise ArgumentError, "URL could not be empty" if url.nil? || url.empty?

            url = ENDPOINT + url
            uri = URI(url)

            request = Net::HTTP.new(uri.host, uri.port)
            request.use_ssl = true

            case method
            when :get
                full_url = encode_path_params(url, params)
                request_header = METHOD_MAP[method].new(full_url)
            else
                request_header = METHOD_MAP[method].new(uri.path)
                request_header.set_form_data(params)
            end

            request_header.basic_auth @api_key, ''
            response = request.start {|http| http.request(request_header) }

            parse_response(response)
        end

        def encode_path_params(path, params)
            encoded = URI.encode_www_form(params)
            [path, encoded].join("?")
        end

        def parse_response(response)
            body = response.body
            json = JSON.parse(body, :symbolize_names => false)
            json
        end

    end

end
