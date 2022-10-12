case node['platform_family']
when 'debian'
  default['vault']['repo-tools']    = 'software-properties-common'
  default['vault']['sysconfig_dir'] = '/etc/default'
  default['vault']['pkg_name']      = 'vault-server'
  default['vault']['conf_dir']      = '/etc/vault'
  default['vault']['service_name']  = 'vault'
when 'rhel', 'fedora'
  default['vault']['repo-tools']    = 'yum-utils'
  default['vault']['sysconfig_dir'] = '/etc/sysconfig'
  default['vault']['pkg_name']      = 'vault'
  default['vault']['conf_dir']      = '/etc'
  default['vault']['service_name']  = 'vault'
end
default['vault']['port']            = 6379
default['vault']['group']           = 'vault'
default['vault']['certs_path']      = '/etc/vault/ssl/certs'
default['vault']['cert_name']       = 'vault-app.vault.australiasoutheast.cloudapp.azure.com'
default['vault']['cert_source']     = 'https://artifactoryvault.blob.core.windows.net/data/cert_content.txt'
