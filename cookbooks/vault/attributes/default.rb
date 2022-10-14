case node[:platform_family]
# put your aws/azure/vmware specifics here
# for now we are only coding for RHEL on EC2
# see https://docs.chef.io/infra_language/checking_platforms/#platform-values for values
when 'debian', 'ubuntu'
when 'rhel', 'fedora'
when 'windows'
end

default[:vault][:repotools]    = 'yum-utils'
default[:vault][:hashi_repo]    = {
  name:         'hashicorp',
  baseurl:      'https://rpm.releases.hashicorp.com/RHEL/$releasever/$basearch/stable',
  gpgkey:       'https://rpm.releases.hashicorp.com/gpg',
  gpgcheck:     true,
  enabled:      true,
  pkg_name:     'vault',
}
