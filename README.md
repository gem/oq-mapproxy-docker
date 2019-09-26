##  [MapProxy](https://github.com/mapproxy/mapproxy) via Docker
[![Build Status](https://travis-ci.com/gem/oq-mapproxy-docker.svg?branch=master)](https://travis-ci.com/gem/oq-mapproxy-docker)

### Build the container

#### Stable releases

TAG: `openquake/mapprox-server:stable`, `openquake/mapprox-server:1.12.0`

```bash
$ docker build --build-arg uid=$(id -u) -t openquake/mapproxy-server .
```

#### Built from master tree

TAG: `openquake/mapprox-server:master`

```bash
$ docker build --build-arg uid=$(id -u) \
  --build-arg pkg=https://github.com/mapproxy/mapproxy/archive/master.zip \
  -t openquake/mapproxy-server .
```

You may skip these steps. The container will be downloaded from the Docker Hub.

### Run the docker and map host data

```
$ docker run -v $(pwd):/io -u $(id -u):$(id -g) -d -p 8080:8080 openquake/mapproxy-server
```

#### Custom configurations via env vars

- `MAPPROXY_NAME`: specify the name of processes spawned by `gunicorn`. Default is `mapproxy`. This feature uses `setproctitle`
- `MAPPROXY_CPU`: set the number of CPU to be used by `MapProxy`. By default it's the number of available CPU in the container
- `MAPPROXY_DEV`: run `MapProxy` in the development mode using its development server instead of `gunicorn`
- `MAPPROXY_WORKER`: specify the worker to be used by `gunicorn`. Default is `gthread`. This option is available only if `MAPPROXY_DEV` is not set


### Data dir structure

`$(pwd)` must have the following structure:

```
/io
 |
 |-- conf
      |-- conf_1.yaml
      |-- conf_2.yaml
      |-- conf_n.yaml
```

### Services provided

This Docker container by default exposes HTTP on port `8080` via `gunicorn`. It must be proxyed via an HTTP proxy (like `nginx`, see the provided `docker-compose.yml`).
