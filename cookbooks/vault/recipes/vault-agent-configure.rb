secrets = data_bag_item('vault', 'approle')

file node[:vault][:agent_config][:role_id] do
  content secrets['role_id']
end

file node[:vault][:agent_config][:secret_id] do
  content secrets['secret_id']
end

template node[:vault][:agent_config][:config] do
  source 'vault-agent.hcl.erb'
  owner node[:accounts][:vault][:unix_user]
  group node[:accounts][:vault][:unix_group]
  mode '0644'
end