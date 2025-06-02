#!/bin/bash

# MIT License
# Copyright (c) 2025 Grzegorz Błaszczyk

HEAD=`which head`
XXD=`which xxd`

if [ -z "$1" ]; then
  echo "Usage: $0 [transaction_hex]"
  exit 1
fi

hex="$1"

# Get all OP_RETURN (6a + 1 byte indicating the length + data afterwards)
while [[ $hex =~ (6a)([0-9a-fA-F]{2})([0-9a-fA-F]+) ]]; do
  len_hex="${BASH_REMATCH[2]}"
  data_hex="${BASH_REMATCH[3]}"

  # Calculate how many bytes the OP_RETURN has
  len_dec=$((16#${len_hex}))
  data_hex_cut=$(echo "$data_hex" | ${HEAD} -c $((len_dec * 2)))

  if [[ ${#data_hex_cut} -ge $((len_dec * 2)) ]]; then
    # Decode to ASCII
    decoded=$(echo "${data_hex_cut}" | ${XXD} -r -p 2>/dev/null)
    if [[ "$decoded" =~ ^[[:print:][:space:]]+$ ]]; then
      echo "OP_RETURN: ${decoded}"
    fi
  fi

  # Cut out first OP_RETURN to search for more
  hex=${hex#*6a}
done
