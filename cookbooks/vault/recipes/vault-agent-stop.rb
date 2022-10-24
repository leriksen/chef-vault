systemd_unit node[:vault][:agent_config][:service_name] do
  action [:stop]
end