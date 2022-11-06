#!/usr/bin/env bash

export VAULT_ADDR="https://vault-public-vault-8860d7cf.f6ac8407.z1.hashicorp.cloud:8200"
export VAULT_NAMESPACE="admin"

while IFS= read -r line || [[ -n "$line" ]]; do
  export VAULT_TOKEN=$line
done < /etc/vault.d/vault-agent-sink

export SECRET
SECRET=$(curl -s --header "X-Vault-Token: ${VAULT_TOKEN}" \
    --header "X-Vault-Namespace: ${VAULT_NAMESPACE}" \
    "${VAULT_ADDR}/v1/secret/data/sample-secret" | jq -r '.data.data."first-secret"')

echo "${SECRET}"