# Zeniscal Playground

Provides a dockerized setup to work with zensical.

## Comands

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
