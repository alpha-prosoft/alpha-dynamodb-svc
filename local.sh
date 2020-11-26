#!/bin/bash

set -e

export BUILD_ID="3"
export TARGET_ACCOUNT_ID="$(aws sts get-caller-identity | jq -r '.Account')"

docker build --progress=plain \
             --no-cache \
             --build-arg BUILD_ID="${BUILD_ID}" \
             --build-arg DOCKER_URL="registry-1.docker.io" \
             --build-arg DOCKER_ORG="alphaprosoft" \
             -t alpha-dynamodb-svc:b${BUILD_ID} .

docker run -it -v /var/run/docker.sock:/var/run/docker.sock \
          -e TargetAccountId="${TARGET_ACCOUNT_ID}" \
          -e EnvironmentNameUpper="PIPELINE" \
          -e ServiceName="alpha-dynamodb-svc" \
          -e BUILD_ID="${BUILD_ID}" \
          alpha-dynamodb-svc:b${BUILD_ID} /dist/deploy.sh
