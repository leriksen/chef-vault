describe "vault::vault-agent-configure" do
  platform 'redhat'

  it { is_expected.to create_template('/etc/vault.d/vault-agent.hcl') }
end