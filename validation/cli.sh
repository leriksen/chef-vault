#!/usr/bin/env bash

export VAULT_ADDR="https://vault-public-vault-8860d7cf.f6ac8407.z1.hashicorp.cloud:8200"
export VAULT_NAMESPACE="admin"
export VAULT_FORMAT="json"

while IFS= read -r line || [[ -n "$line" ]]; do
  export VAULT_TOKEN=$line
done < /etc/vault.d/vault-agent-sink

export SECRET=$(vault kv get --mount=secret sample-secret | jq -r '.data.data."first-secret"')
echo $SECRET