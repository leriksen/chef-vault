describe "vault::vault-agent-stop" do
  platform 'redhat'

  it { is_expected.to stop_systemd_unit('vault-agent.service') }
end