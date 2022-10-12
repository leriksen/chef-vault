# execute "reset-vault-modules" do
#   command 'dnf module reset vault -y'
#   cwd 'usr/bin'
#   action :run
#   user 'root'
#   group 'root'
#   live_stream true
# end
#
# execute "disable-vault-5" do
#   command 'dnf module disable vault:5 -y'
#   cwd 'usr/bin'
#   action :run
#   user 'root'
#   group 'root'
#   live_stream true
# end
#
# execute "enable-vault-6" do
#   command 'dnf module enable vault:6 -y'
#   cwd 'usr/bin'
#   action :run
#   user 'root'
#   group 'root'
#   live_stream true
# end

package node['vault']['repo-tools'] do
  action :install
end

# package node['vault']['pkg_name'] do
#   action :install
# end
#
# service node['vault']['service_name'] do
#   service_name node['vault']['service_name']
#   action [ :enable, :start ]
# end
#
# # secret is needed for config
# secrets = data_bag_item('certs', 'vault')
#
# template File.join(node['vault']['conf_dir'], 'vault.conf') do
#   source 'vault.conf.erb'
#   owner 'root'
#   group 'root'
#   mode '0644'
#   variables (
#     {
#       password: secrets['vault-password']
#     }
#   )
#   notifies :restart, "service[#{node['vault']['service_name']}]"
# end
#
# template File.join(node['vault']['sysconfig_dir'], node['vault']['pkg_name']) do
#   source 'vault.sysconfig.erb'
#   owner 'root'
#   group 'root'
#   mode '0755'
#   notifies :restart, "service[#{node['vault']['service_name']}]"
# end
#
# include_recipe 'devops::default'
#
# group node['vault']['group'] do
#   append true
#   comment 'add devops unix user to the vault group so they can read logs'
#   members [ node['accounts']['devops']['unix_user'] ]
#   action :modify
# end
#
# directory "#{node['vault']['certs_path']}" do
#   recursive true
#   action :create
# end
#
# include_recipe 'vault::vault-cert-update'