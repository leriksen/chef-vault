package node[:vault][:hashi_repo][:pkg_name] do
  action :remove
end

yum_repository node[:vault][:hashi_repo][:name] do
  action :remove
end

package node[:vault][:repotools] do
  action :remove
end
