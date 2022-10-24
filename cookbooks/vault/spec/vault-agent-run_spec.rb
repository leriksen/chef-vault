describe "vault::vault-agent-run" do
  platform 'redhat'

  it { is_expected.to create_systemd_unit('vault-agent.service') }
  it { is_expected.to enable_systemd_unit('vault-agent.service') }
  it { is_expected.to start_systemd_unit('vault-agent.service') }
end