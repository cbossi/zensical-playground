# Zensical Playground

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

* with cache: `docker compose run --rm zensical_build`
* clean build: `docker compose run --rm zensical build --clean`

### Manual cleanup

```
docker container rm zensical
docker image rm zensical
docker container rm zensical_serve
docker image rm zensical_serve
 docker image rm zensical_build
```

## About the setup

There are two problems with the live preview server (`zensical serve`) when running zensical in a docker container:

### Port is not available on host system
Problem: Out of the box, the port `8000` of the live server is not available on the host system. 

Solution: This can be changed by starting `zensical serve` with the additional parameter `-p 8000:8000` and adding the following to the Dockerfile: `EXPOSE 8000/tcp`.

### Live preview does not work with volume mount

Problem: Changes made to the files on the host system are not detected when using a volume mount

Solution: Usage of `docker compose watch` to synchronize changes made on the host to the container. Since the watch can only be invoked after the container has been started, the files have to be copied to the container initially.

### Zensical `build` command does not terminate in combination with volume mount

Problem: The `build` command of zensical does not terminate when used inside a folder mounted to the host. The site artifacts are created, but the command keeps running. (the same behavior is observed with this image, too: https://hub.docker.com/r/joshooaj/zensical)

Solution: The content of the project is copied to a temporary folder not mounted to the host system. The `build` command is then executed in this temporary folder and finally the contentn is copied back to the mounted folder.
