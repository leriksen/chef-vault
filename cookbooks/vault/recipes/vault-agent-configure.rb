template node[:vault][:agent_config][:config] do
  source 'vault-agent.hcl.erb'
  owner node[:accounts][:vault][:unix_user]
  group node[:accounts][:vault][:unix_group]
  mode '0644'
end