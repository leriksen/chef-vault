script 'unwrap_token' do
  interpreter "bash"
  environment (
    {
      VAULT_TOKEN: node[:vault][:agent_config][:wrapped_cert][:content],
      VAULT_ADDR:  node[:vault][:agent_config][:vault_dns]
    }
  )
  code <<-EOH
    echo $VAULT_TOKEN > /etc/vault.d/agent_token.txt
    json=$(vault unwrap -format=json | jq -r '.data.data.#{node[:vault][:agent_config][:wrapped_cert][:cert_field]}' )
    echo $json  >> /etc/vault.d/agent_token.txt
    echo $json | jq -r '."client-cert"' > "#{node[:vault][:agent_config][:cert_file]}"
    echo $json | jq -r '."client-key"'  > "#{node[:vault][:agent_config][:key_file]}"
    json=
    VAULT_TOKEN=
  EOH
end