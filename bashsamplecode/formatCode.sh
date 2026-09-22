#!/bin/bash

# format all code

if ! which shfmt > /dev/null; then
   echo "Installing shfmt ..."
   sudo apt install shfmt
fi

shfmt -i 3 -ci -sr -w ./*.sh
