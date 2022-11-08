describe "vault::vault-agent-token" do
  platform 'redhat', '8'

  it { is_expected.to run_ruby_block('unwrap_token') }
end