#!/bin/bash

if [[ "$#" -lt 1 ]]; then
    echo "USAGE: $0 <URL> [parameters]"
    exit 1
fi

if ! which curl&>/dev/null; then
    echo "ERROR: curl not found, is it installed?"
    exit 2
fi

API="https://bfnt.io/api/v2/action/shorten"
PARAMS="key=<insert API key here>"
URL_PARAMETER="url"

if [[ "$#" -gt 1 ]]; then PARAMS="$PARAMS&$2"; fi
RESULT=$(curl -s --data-urlencode "$URL_PARAMETER=$1" "$API?$PARAMS")
TIMESTAMP=$(date --rfc-3339=seconds)

echo "$TIMESTAMP - $1 => $RESULT" >> .shortener.log
echo "$RESULT" && exit 0
