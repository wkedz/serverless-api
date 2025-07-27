#!/bin/bash

STACK_NAME="ServerlessApiStack"
OUTPUT_KEY="ApiUrl"
OUTPUT_FILE="./cdk-outputs.json"

if [ ! -f "$OUTPUT_FILE" ]; then
  echo "Error: File $OUTPUT_FILE not exists."
  echo "Run:"
  echo ""
  echo "    cdk deploy --outputs-file $OUTPUT_FILE"
  echo ""
  exit 1
fi

API_URL=$(jq -r ".\"$STACK_NAME\".\"$OUTPUT_KEY\"" ./cdk-outputs.json)

POST_URL="${API_URL}empl"
echo "Making POST request to $POST_URL"
RESPONSE=$(curl -H "Content-Type: application/json" -X POST $POST_URL -d '{"name": "John Doe", "possition": "developer"}')
id=$(echo "$RESPONSE" | jq -r '.id')
echo "Extracted id: $id"


GET_URL="${API_URL}empl?id=${id}"

echo "Making GET request to $GET_URL"
curl -X GET $GET_URL


echo