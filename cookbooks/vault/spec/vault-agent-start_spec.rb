describe "vault::vault-agent-start" do
  platform 'redhat', '8'

  it { is_expected.to start_systemd_unit('vault-agent.service') }
end