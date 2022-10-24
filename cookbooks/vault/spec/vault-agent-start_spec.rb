describe "vault::vault-agent-start" do
  platform 'redhat'

  it { is_expected.to start_systemd_unit('vault-agent.service') }
end