#!/bin/bash

# This script encrypts sensitive files using Ansible Vault.

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <file-to-encrypt> <vault-password-file>"
    exit 1
fi

FILE_TO_ENCRYPT=$1
VAULT_PASSWORD_FILE=$2

ansible-vault encrypt "$FILE_TO_ENCRYPT" --vault-password-file "$VAULT_PASSWORD_FILE"