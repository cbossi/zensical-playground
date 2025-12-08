# Zeniscal Playground

Provides a dockerized setup to work with zensical.

## Commands

### Create

`docker compose run --rm zensical new`


### Start preview mode

* `docker compose up zensical_serve -d`
* `docker compose watch zensical_serve`
* open http://localhost:8001

### Stop preview mode
* Press `Ctrl+C` to stop watch mode
* `docker compose -p zensical-playground down --rmi all`

### Build

`docker compose run --rm zensical build`

### Manual cleanup

```
docker container rm zensical
docker image rm zensical
docker container rm zensical_serve
docker image rm zensical_serve
```

## About the setup

There are two problems with the live preview server (`zensical serve`) when running zensical in a docker container:

## Live preview does not work with volume mount

Problem: Changes made to the files on the host system are not detected when using a volume mount

Solution: Usage of `docker compose watch` to synchronize changes made on the host to the container. Since the watch can only be invoked after the container has been started, the files have to be copied to the container initially.

## Live preview not available on host system

Problem: When starting the live server without additional param, it cannot be invoked from the host system, since it only listens to `127.0.0.1`. This can be changed by running it with an additional parameter: `zensical serve -a 0.0.0.0:8000`. However, this completely breaks the live reload, also inside the container (most probably a bug in zensical).

Solution: Creating a proxy from port `8000` to port `8001` inside the container by installing `socat` and using it like the following: `socat TCP-LISTEN:8001,fork,reuseaddr TCP:127.0.0.1:8000`. Then the port forwarding from container to host is done on port `8001` instead of `8000` (where `zensical serve` actually listens to).
