require 'sinatra'
require 'json'
require 'net/http'

# GLOBAL VARS
set :urls, ["http://localhost:8080/admin/health",
            "http://localhost:8080/health2",
            "http://localhost:8080/health3"]

set :body_text, ""

# RESOURCES
get "/health" do
  status_code = 200
  settings.body_text = ""
  settings.urls.each do |url_string|
      unless check_url(url_string)
          status_code = 500
      end
  end
  status status_code
  body settings.body_text
end

get "/health/urls" do
  status 200
  body settings.urls.to_json
end

post "/health/urls" do
  request.body.rewind  # in case someone already read it
  data = JSON.parse request.body.read
  settings.urls.push "#{data['url']}"
  status 200
  body settings.urls.to_json
end

delete "/health/urls" do
  request.body.rewind  # in case someone already read it
  data = JSON.parse request.body.read
  settings.urls.delete "#{data['url']}"
  status 200
  body settings.urls.to_json
end

# FUNCTIONS
helpers do
  def check_url(url_string)
    url = URI.parse url_string
    req = Net::HTTP.new(url.host, url.port)
    req.use_ssl = (url.scheme == 'https')
    path = url.path << '/' unless url.path.end_with?('/')
    res = req.request_get(path)
    settings.body_text << "Status #{res.code}" 
    settings.body_text << "#{url_string}<br/>"
    settings.body_text << "<pre>#{res.read_body}</pre><br/>"
    res.code == "200"
  rescue Errno::ENOENT
    settings.body_text += "Can't find the server: #{url_string}<br/>"
    false
  rescue Errno::ECONNREFUSED
    settings.body_text += "Connection Refused: #{url_string}<br/>"
    false
  end
end
