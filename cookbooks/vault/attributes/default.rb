case node['platform_family']
# put your aws/azure/vmware specifics here
# for now we are only coding for RHEL on EC2
# see https://docs.chef.io/infra_language/checking_platforms/#platform-values for values
when 'debian', 'ubuntu'
when 'rhel', 'fedora'
when 'windows'
end

default['vault']['repo-tools']    = 'yum-utils'
default['vault']['pkg_name']      = 'vault'
default['vault']['hashi_repo']    = 'https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo'
