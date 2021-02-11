# docker-generatedata

[![Docker Pulls](https://img.shields.io/docker/pulls/mvisonneau/generatedata.svg)](https://hub.docker.com/r/mvisonneau/generatedata/)

This repository creates a [Docker](https://www.docker.com/) image of a standalone version of [generatedata.com](http://generatedata.com) (from [benkeen/generatedata](https://github.com/benkeen/generatedata)).

## Usage

The easiest is to use [docker-compose](https://docs.docker.com/compose/), I provide a file in the `examples` folder:

```bash
~$ wget https://raw.githubusercontent.com/mvisonneau/docker-generatedata/master/examples/docker-compose.yml
~$ docker-compose up -d
```

In a few seconds/minutes, you will have a fully working version available at [http://localhost:8000](http://localhost:8000).

It currently supports both: `linux/amd64` and `linux/arm64` platforms

## Configuration

You can use the following environment variables in order to configure the container:

Name | Required | Description
--- | --- | ---
**GD_API_ENABLED**     | *false* | Whether to enable the API or not (default: **true**)
**GD_DB_HOSTNAME**     | *true*  | MySQL database endpoint
**GD_DB_NAME**         | *true*  | MySQL database name
**GD_DB_USERNAME**     | *true*  | MySQL database user
**GD_DB_PASSWORD**     | *false*  | MySQL database password
**GD_DB_TABLE_PREFIX** | *false* | MySQL database table prefix (default: **gd_**)
**GD_ENCRYPTION_SALT** | *false* | Encryption Salt (default: **changeme**)

Example using an external database:

```bash
~$ docker run -it -p 8080:8080 \
     -e GD_DB_HOSTNAME=myinstance.123456789012.eu-west-1.rds.amazonaws.com \
     -e GD_DB_NAME=generatedata \
     -e GD_DB_USERNAME=foo \
     -e GD_DB_PASSWORD=bar \
     ghcr.io/mvisonneau/generatedata:latest
```

## Contribute

Contributions are more than welcome! Feel free to submit a [PR](https://github.com/mvisonneau/docker-generatedata/pulls).
