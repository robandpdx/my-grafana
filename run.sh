#!/bin/bash

# running the docker run command
docker run -d -p 3000:3000 --name=grafana \
    -e "DS_GITHUB_TOKEN=$GITHUB_TOKEN" \
    grafana-custom

    #-e "GF_LOG_LEVEL=debug" \