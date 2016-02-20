require 'sinatra'
require 'net/http'
require 'ostruct'

urls = [
	"http://localhost:8080/admin/health",
	"http://localhost:8080/health2",
	"http://localhost:8080/health3"
]

get '/health' do
	status_code = 200
	body_text = ""
	urls.each do |url_string|
		result = check_url(url_string)
		if not result.status
			status_code = 500
			body_text += "Error: "
		end
		body_text += "#{url_string} <br/>"
		body_text += "<pre>#{result.text}</pre><br/>"
	end
	status status_code
	body body_text
end

def check_url(url_string)
	url = URI.parse(url_string)
	req = Net::HTTP.new(url.host, url.port)
	req.use_ssl = (url.scheme == 'https')
	res = req.request_get(url.path)
	result = OpenStruct.new
	result.status = res.code == "200"
	result.text = res.read_body
	result
rescue Errno::ENOENT
	result = OpenStruct.new
	result.status = false
	result.text = "Can't find the server"
	result
rescue Errno::ECONNREFUSED
	result = OpenStruct.new
	result.status = false 
	result.text = "Connection Refused"
	result
end