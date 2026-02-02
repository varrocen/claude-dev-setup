#!/bin/bash
# Hook to run shellcheck after shell scripts are created or modified

input=$(cat)
file_path=$(echo "$input" | jq -r '.tool_input.file_path')

if [[ "$file_path" == *.sh ]]; then
  shellcheck "$file_path"
fi
