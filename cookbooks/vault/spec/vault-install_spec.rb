describe "vault::vault-install" do
  platform 'redhat'

  it { is_expected.to install_package('yum-utils') }
  it { is_expected.to create_yum_repository('hashicorp') }
  it { is_expected.to install_package('vault') }
end