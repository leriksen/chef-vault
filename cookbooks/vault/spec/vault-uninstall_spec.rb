describe "vault::vault-uninstall" do
  platform 'redhat'

  it { is_expected.to remove_package('vault') }
  it { is_expected.to remove_yum_repository('hashicorp') }
  it { is_expected.to remove_package('yum-utils') }
  end