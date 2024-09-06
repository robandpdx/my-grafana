# Grafana with GitHub datasource

## Getting started
Make sure you have docker installed and running.  
[Create a Github personal access token with the appropriate permissions](https://grafana.com/docs/plugins/grafana-github-datasource/latest/setup/token/).  

1. Set the following environment variables: `GITHUB_TOKEN`  
2. Run `./build.sh`
3. Run `./run.sh`
4. Open a browser to `http://localhost:3000/`
5. Login with `admin`/`admin`
6. Navigate to Dashboards->GitHub Default
7. Profit!

## Grafana provisioning

Grafana [provisioning of dashboards and data sources](https://grafana.com/tutorials/provision-dashboards-and-data-sources/) occurs by placing the [`provisioning`](./provisioning/) directory in `/etc/grafana/provisioning` of the docker image. For this reason, we are building a custom docker image and adding the [`provisioning`](./provisioning/) directory as well as the [`dashboards`](./dashboards/) needed via the [`Dockerfile`](./Dockerfile).  

To enable faster startup times, grafana plugins are [pre-installed into the custom docker image](https://grafana.com/docs/grafana/latest/setup-grafana/configure-docker/#build-a-grafana-docker-image-with-pre-installed-plugins) by specifying the plugins as a `--build-arg` in the [build.sh](../../build.sh#L6).  


## Dashboard development
New dashboards can be created or modified locally, then exported to a json file and checked into the [`dashboards`](./dashboards/) directory, or any folder within. When exporting a dashboard, do not enable the `Export for sharing externally` option.

## Cleanup
Stop and delete the `grafana` docker container by running `./cleanup.sh`.