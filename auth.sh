#!/usr/bin/env sh

set -x

nounce=$((RANDOM*100))
tmp=$(mktemp)
jq '.nonce = "'$nounce'" | .label = "key-'$nounce'"' account-settings.json > "$tmp" && mv "$tmp" account-settings.json
openssl dgst -sha512 -sign private.key account-settings.json | openssl base64 -A | awk '{print "SIGNATURE=\""$1"\""}' > .env