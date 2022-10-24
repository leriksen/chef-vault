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

default[:root]               = '/etc'
default[:vault][:home]       = node[:root] + '/vault.d'
default[:vault][:cert_path]  = node[:vault][:home]
default[:vault][:repo_tools] = 'yum-utils'

default[:vault][:agent_config][:config]   = node[:vault][:home] + '/vault-agent.hcl'
default[:vault][:agent_config][:pid_path] = node[:vault][:home]
default[:vault][:agent_config][:pid_file] = node[:vault][:agent_config][:pid_path] + '/vault-agent.pid'

default[:vault][:agent_config][:vault_dns] = 'https://vault-public-vault-8860d7cf.f6ac8407.z1.hashicorp.cloud:8200'
default[:vault][:agent_config][:args][:namespace] = 'admin' # namespace for commands

default[:vault][:agent_config][:ca_file] = '/etc/pki/ca-trust/extracted/pem/tls-ca-bundle.pem'
default[:vault][:agent_config][:cert_file] = 'agent.crt'
default[:vault][:agent_config][:key_file]  = 'agent.key'

default[:vault][:agent_config][:service_name]  = 'vault-agent.service'

default[:vault][:agent_config][:sink_file]  = node[:vault][:home] + '/vault-agent-sink'

default[:accounts][:vault][:unix_user]  = 'vault'
default[:accounts][:vault][:unix_group] = 'vault'

default[:vault][:agent_config][:role_id]   = node[:vault][:home] + '/role_id'
default[:vault][:agent_config][:secret_id] = node[:vault][:home] + '/secret_id'
