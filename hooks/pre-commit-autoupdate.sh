#!/bin/bash
# Hook to run pre-commit autoupdate after .pre-commit-config.yaml is created or modified

input=$(cat)
file_path=$(echo "$input" | jq -r '.tool_input.file_path')

if [[ "$file_path" == *".pre-commit-config.yaml" ]]; then
  pre-commit autoupdate
fi
