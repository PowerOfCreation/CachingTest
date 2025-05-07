#!/bin/bash

SARIF_FILE="$(gzip -c dummy-sarif.sarif | base64 -w0)"

TOKEN=""

COMMIT_SHA=""

JSON=$(jq -n \
  --arg commit_sha "$COMMIT_SHA" \
  --arg ref "refs/heads/main" \
  --arg sarif "$SARIF_FILE" \
  '{commit_sha: $commit_sha, ref: $ref, sarif: $sarif}')

curl -L \
  -X POST \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $TOKEN" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/repos/PowerOfCreation/CachingTest/code-scanning/sarifs \
  -d "$JSON"
