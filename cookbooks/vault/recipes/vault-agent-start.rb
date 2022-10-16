
default_options = {
  config:             '/etc/vault.d/vault.hcl',
  exit_after_auth:    'false',
  log_level:          'info',
  address:            '',
  agent_address:      '',
  ca_cert:            '',
  ca_path:            '',
  client_cert:        '',
  client_key:         '',
  header:             [],
  mfa:                '',
  namespace:          '',
  output_curl_string: 'false',
  output_policy:      'false',
  policy_override:    'false',
  tls_server_name:    '',
  tls_skip_verify:    'false',
  unlock_key:         '',
  wrap_ttl:           ''
}

node = {
  :vault => {
    :agent_config => {
      :args => {
        :address   => 'https://vault-public-vault-8860d7cf.f6ac8407.z1.hashicorp.cloud:8200',      # server address - overrides value in config file
        :namespace => 'admin' # namespace for commands
      }
    }
  }
}
def form_agent_command(options)
  cli_options = ''
  options.each do |key, value|
    arg = "-#{key.to_s.gsub(/_/, '-')}" # convert _ to -
    if value.kind_of?(Array) # repeated values
      value.each do |entry|
        cli_options += "-#{arg}=#{entry} "
      end
    else
      cli_options += "-#{arg}=#{value} " unless value.nil? or value.empty? # skip unset
    end
  end
  "vault agent #{cli_ options}"
end

options = default_options.merge(node[:vault][:agent_config][:args])

puts form_agent_command(options)

# script 'start_agent' do
#   interpreter "bash"
#   code <<-EOT
#     vault agent -config='<%= node[:vault][:agent_config][:path]' %>
#   EOT
# end

