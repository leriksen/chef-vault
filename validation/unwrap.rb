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
puts resp.body if resp.is_a?(Net::HTTPSuccess)

body = JSON.parse resp.body
puts body.inspect

cert = JSON.parse body['data']['data']['cert']
puts cert.inspect

puts "cert is " + cert['client-cert']
puts "key  is " + cert['client-key' ]
