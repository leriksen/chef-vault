describe "vault::vault-agent-configure" do
  platform 'redhat', '8'

  it { is_expected.to create_template('/etc/vault.d/vault-agent.hcl') }
end