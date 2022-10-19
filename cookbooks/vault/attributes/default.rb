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

default[:vault][:agent_config][:flags][:config]             = '/etc/vault.d/vault.hcl'
default[:vault][:agent_config][:flags][:exit_after_auth]    = false # default
default[:vault][:agent_config][:flags][:log_level]          = 'info'  # default

default[:vault][:agent_config][:approle][:role_id_file_path]                   = '/tmp/role_id_file_path'
default[:vault][:agent_config][:approle][:secret_id_file_path]                 = '/tmp/secret_id_file_path'
default[:vault][:agent_config][:approle][:remove_secret_id_file_after_reading] = true

default[:vault][:agent_config][:args][:address]   = 'https://vault-public-vault-8860d7cf.f6ac8407.z1.hashicorp.cloud:8200'      # server address - overrides value in config file
default[:vault][:agent_config][:args][:namespace] = 'admin' # namespace for commands
