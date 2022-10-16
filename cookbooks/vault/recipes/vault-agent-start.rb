script 'start_agent' do
  interpreter "bash"
  code <<-EOT
    vault agent -config='<%= node[:vault][:agent_config][:flags][:config]' -exit-after-auth node[:vault][:agent_config][:flags][:exit_after_auth] -log-level node[:vault][:agent_config][:flags][:log_level] %>
  EOT
end

