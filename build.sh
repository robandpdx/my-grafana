#!/bin/bash

# running the build command
docker build \
  --build-arg "GRAFANA_VERSION=latest" \
  --build-arg "GF_INSTALL_PLUGINS=grafana-piechart-panel,neocat-cal-heatmap-panel,petrslavotinek-carpetplot-panel,fifemon-graphql-datasource,marcusolsson-treemap-panel,grafana-github-datasource" \
  -t grafana-custom .

  