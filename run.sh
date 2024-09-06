#!/bin/bash

# running the docker run command
docker run -d -p 3000:3000 --name=grafana \
    -e "DS_MYSQL_URL=" \
    -e "DS_MYSQL_USER=robandpdx" \
    -e "DS_MYSQL_PASSWORD=$MYSQL_PASSWORD" \
    -e "DS_GITHUB_TOKEN=$GITHUB_TOKEN" \
    grafana-custom

    #-e "GF_LOG_LEVEL=debug" \