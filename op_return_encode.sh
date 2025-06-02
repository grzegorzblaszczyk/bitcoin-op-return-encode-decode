#!/bin/bash

# MIT License
# Copyright (c) 2025 Grzegorz Błaszczyk

TR=`which tr`
XXD=`which xxd`
WC=`which wc`

if [ -z "$1" ]; then
  echo "Usage: $0 [ASCII text]"
  exit 1
fi

text="$1"

length=$(echo -n "$text" | ${WC} -c)

if [ "${length}" -gt 80 ]; then
  echo "ERROR: OP_RETURN argument cannot be longer than 80 bytes (currently it is ${length} bytes)"
  exit 1
fi

echo -n "$text" | ${XXD} -p | ${TR} -d '\n'
echo -e "\n"
