#!/bin/bash

# running the docker run command
op run --env-file="$(dirname "$0")/.env" -- sh -c '
    exec docker run -d -p 3000:3000 --name=grafana \
        -e GITHUB_TOKEN \
        -e AWS_ACCESS_KEY_ID \
        -e AWS_SECRET_ACCESS_KEY \
        -e AWS_SESSION_TOKEN \
        -e AWS_REGION \
        -e AWS_DEFAULT_REGION \
        grafana-custom
'

    #-e "GF_LOG_LEVEL=debug" \