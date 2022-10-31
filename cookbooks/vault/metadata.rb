name 'vault'
maintainer 'Leif Eriksen'
maintainer_email 'leif.eriksen.au+chef-vault-github@gmail.com'
license 'All Rights Reserved'
description 'Installs/Configures Vault client'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.4.47'
chef_version '>= 15.0'
source_url 'https://github.com/leriksen/chef-vault-client'
issues_url 'https://github.com/leriksen/chef-vault-client/issues'

recipe 'vault::default', 'Install and configure Vault client'
