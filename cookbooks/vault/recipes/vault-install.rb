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

yum_repository 'hashi_repo' do
  baseurl node['vault']['hashi_repo']
  only_if { ['rhel', 'fedora'].include? node['platform_family'] }
end

package node['vault']['pkg_name'] do
  action :install
end
