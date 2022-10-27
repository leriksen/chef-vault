describe "vault::vault-agent-configure" do
  platform 'redhat', '8'

  before(:each) do
    stub_data_bag_item("vault", "approle").and_return(
      {
        id: 'approle',
        role_id: 'role_id',
        secret_id: 'secret_id',
      }
    )
  end

  it { is_expected.to create_template('/etc/vault.d/vault-agent.hcl') }
end