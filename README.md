# Grafana with GitHub datasource

## Getting started
Make sure you have docker installed and running.  
[Create a Github personal access token with the appropriate permissions](https://grafana.com/docs/plugins/grafana-github-datasource/latest/setup/token/).  

1. Add `GITHUB_TOKEN` to your local `.env` file. Install and sign in to the [1Password CLI](https://developer.1password.com/docs/cli/) to resolve any `op://` secret references.
2. Run `./build.sh`
3. Run `./run.sh`
4. Open a browser to `http://localhost:3000/`
5. Login with `admin`/`admin`
6. Navigate to Dashboards->GitHub Default
7. Profit!

## Grafana provisioning

Grafana [provisioning of dashboards and data sources](https://grafana.com/tutorials/provision-dashboards-and-data-sources/) occurs by placing the [`provisioning`](./provisioning/) directory in `/etc/grafana/provisioning` of the docker image. For this reason, we are building a custom docker image and adding the [`provisioning`](./provisioning/) directory as well as the [`dashboards`](./dashboards/) needed via the [`Dockerfile`](./Dockerfile).  

To enable faster startup times, grafana plugins are [pre-installed into the custom docker image](https://grafana.com/docs/grafana/latest/setup-grafana/configure-docker/#build-a-grafana-docker-image-with-pre-installed-plugins) by specifying the plugins as a `--build-arg` in the [build.sh](../../build.sh#L6).  

The Dockerfile uses `grafana cli` to install plugins; current Grafana images no longer include the legacy `grafana-cli` executable.

### Amazon Athena

The provisioned `grafana-athena-datasource` uses **Access & secret key** authentication (`authType: keys`) and defaults to AWS region `us-west-2`. Add the following variables to your local, git-ignored `.env` file using your values or 1Password secret references:

```dotenv
AWS_ACCESS_KEY_ID=your-access-key-id
AWS_SECRET_ACCESS_KEY=your-secret-access-key
```

Athena is provisioned with catalog `AwsDataCatalog`, database `github_webhooks_silver_dev`, and workgroup `github-webhooks-dev`. Query results use the workgroup's configured output location unless overridden in Grafana.

The run script loads `.env` with `op run` and passes these AWS variables to Docker. Grafana reads the access and secret keys into the datasource's `secureJsonData` fields at startup, without embedding credential values in the image or provisioning file. Rebuild with `./build.sh`, then recreate the container with `./cleanup.sh` followed by `./run.sh`. The credentials need appropriate Athena, Glue, and S3 permissions; see the [Athena configuration guide](https://grafana.com/docs/plugins/grafana-athena-datasource/latest/configure/).


## Dashboard development
New dashboards can be created or modified locally, then exported to a json file and checked into the [`dashboards`](./dashboards/) directory, or any folder within. When exporting a dashboard, do not enable the `Export for sharing externally` option.

## Cleanup
Stop and delete the `grafana` docker container by running `./cleanup.sh`.