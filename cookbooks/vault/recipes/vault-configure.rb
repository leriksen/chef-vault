template node[:vault][:agent_config][:approle][:role_id_file_path] do
  source 'role_id.erb'
  owner 'vault'
  group 'vault'
  mode '0644'
  variables (
    {
      role_id: secrets['role_id']
    }
  )
end

template node[:vault][:agent_config][:approle][:secret_id_file_path] do
  source 'secret_id.erb'
  owner 'vault'
  group 'vault'
  mode '0644'
  variables (
    {
      secret_id: secrets['secret_id']
    }
  )
end

template node[:vault][:agent_config][:flags][:config] do
  source 'vault.hcl.erb'
  owner 'vault'
  group 'vault'
  mode '0644'
end