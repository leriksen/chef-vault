describe "vault::vault-install" do
  platform 'redhat'

  it { is_expected.to install_package('yum-utils') }
end