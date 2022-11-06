import hvac

VAULT_ADDR = "https://vault-public-vault-8860d7cf.f6ac8407.z1.hashicorp.cloud:8200"
VAULT_NAMESPACE = "admin"

with open('/etc/vault.d/vault-agent-sink') as f:
    VAULT_TOKEN = f.readlines()[0].strip('\n')

client = hvac.Client(url=VAULT_ADDR, token=VAULT_TOKEN, namespace=VAULT_NAMESPACE)
data = client.secrets.kv.v2.read_secret(path='sample-secret', mount_point='secret')

print(data['data']['data']['first-secret'])
