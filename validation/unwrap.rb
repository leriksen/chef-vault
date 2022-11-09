require 'uri'
require 'net/http'
require 'json'
uri = URI 'https://vault-public-vault-8860d7cf.f6ac8407.z1.hashicorp.cloud:8200/v1/sys/wrapping/unwrap'
https = Net::HTTP.new(uri.host, uri.port)
https.use_ssl = true

token = ENV["WRAPPING_TOKEN"]
puts token

req = Net::HTTP::Post.new uri.path
req['X-Vault-Token'] = token

resp = https.request req

case resp
when Net::HTTPForbidden
  puts "resource is forbidden to client #{resp.message} #{resp.code} msg==<#{resp.read_body}>"
  exit
when Net::HTTPClientError
  puts "request has an error from client #{resp.message} #{resp.code} msg==<#{resp.read_body}>"
  exit
when Net::HTTPSuccess
  # continue as if nothing happened
  body = resp.body
when Net::HTTPFatalError, Net::HTTPServerException, Net::HTTPRetriableError, Net::HTTPError
  puts "request has a probable protocol error #{resp.message} #{resp.code} msg==<#{resp.read_body}>"
  exit
else
  puts "unusual condition #{resp.class} #{resp.message} #{resp.code} msg==<#{resp.read_body}>"
  exit
end

puts body.inspect

begin
  cert = JSON.parse body['data']['data']['cert']
rescue JSON::ParseError => e
  puts "unable to parse JSON response from vault - #{e.message}"
  exit
end

puts cert.inspect

puts "cert is " + cert['client-cert']
puts "key  is " + cert['client-key' ]
