const https = require('https');
const fs = require('fs');

const vault_addr      = "https://vault-public-vault-8860d7cf.f6ac8407.z1.hashicorp.cloud:8200";
const vault_token     = fs.readFileSync('/etc/vault.d/vault-agent-sink', 'utf-8').trim();
const vault_namespace = 'admin';

const options = {
  headers: {
    'X-Vault-Token': vault_token,
    'X-Vault-Namespace': vault_namespace
  }
};

https.get(vault_addr + '/v1/secret/data/sample-secret', options, (resp) => {
  let data = '';
  resp.on('data', (chunk) => {
    data += chunk;
  });
  resp.on('end', () => {
    let secret = JSON.parse(data).data.data['first-secret'];
    console.log(secret);
  });
}).on('error', (err) => {
  console.log(err.message);
});
