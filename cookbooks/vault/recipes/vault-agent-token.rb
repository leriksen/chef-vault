ruby_block 'unwrap_token' do
  block do
    require 'uri'
    require 'net/http'
    require 'json'

    uri = URI node[:vault][:agent_config][:vault_dns] + '/v1/sys/wrapping/unwrap'
    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true
    https.verify_mode = OpenSSL::SSL::VERIFY_NONE

    req = Net::HTTP::Post.new uri.path

    token = node[:vault][:agent_config][:wrapped_cert][:content]
    req['X-Vault-Token'] = token

    resp = https.request req

    body = JSON.parse resp.body

    cert = JSON.parse body['data']['data']['cert']

    File.write node[:vault][:agent_config][:role_id  ], cert['role_id'  ]
    File.write node[:vault][:agent_config][:secret_id], cert['secret_id']
 end
end
