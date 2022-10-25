describe "vault::vault-agent-install" do
  platform 'redhat'

  it { is_expected.to install_package('yum-utils') }
  it { is_expected.to create_yum_repository('hashicorp') }
  it { is_expected.to install_package('vault') }
  it { is_expected.to delete_file('/etc/vault.d/vault.hcl') }
  it { is_expected.to delete_file('/etc/vault.d/vault.env') }
end