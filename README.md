# Zensical Playground

Provides a dockerized setup to work with zensical.

## Commands

### Create

`docker compose run --build --rm zensical_new`


### Start preview mode
* `./serve`
* open http://localhost:8001

Above command runs:
```
docker compose up --build zensical_serve -d
docker compose watch zensical_serve
```

### Stop preview mode
* Press `Ctrl+C` to stop watch mode
* `./unserve`

Above command runs:
```
docker compose down zensical_serve --rmi all
```

### Build

* `./build` or `./build --clean`
* see build output in [content/site](./content/site) with [index.html](./content/site/index.html) as entry point

Above command runs
```
# cached build
docker compose run --build --rm zensical_build
# clean build
docker compose run --build --rm zensical_build --clean
```

### Publish to GitHub Pages
* Go to [Publish Documentation to GitHub Pages](https://github.com/cbossi/zensical-playground/actions/workflows/publish-to-github-pages.yml) workflow under `Actions` tab of repository → *Run workflow*
* Open published page: https://cbossi.github.io/zensical-playground

#### Initial setup
Initially, GitHub Pages has to be activated for the current repository: 
Got to [Pages Settings](https://github.com/cbossi/zensical-playground/settings/pages) of current repository → Under *Source* set *GitHub Actions*. 

### Manual cleanup

Should not be required, since containers should be removed automatically and the image should be rebuilt when using `--build` parameter as documented above.

```
docker container rm zensical_new
docker container rm zensical_serve
docker container rm zensical_build
docker image rm zensical
# remove all dangling images (i.e. images without a name)
docker image prune -f
```

## About the setup

There are two problems with the live preview server (`zensical serve`) when running zensical in a docker container:

### Port is not available on host system
Problem: Out of the box, the port `8000` of the live server is not available on the host system. 

Solution: This can be changed by starting `zensical serve` with the additional parameter `-p 8000:8000` and adding the following to the Dockerfile: `EXPOSE 8000/tcp`.

### Live preview does not work with volume mount

Problem: Changes made to the files on the host system are not detected when using a volume mount

Solution: Usage of `docker compose watch` to synchronize changes made on the host to the container. Since files have to be available initially to start the server, we have to copy them into the image at image build time (see `COPY` statement in [Dockerfile](./Dockerfile))

### Zensical `build` command does not terminate in combination with volume mount

Problem: The `build` command of zensical does not terminate when used inside a folder mounted to the host. The site artifacts are created, but the command keeps running. (the same behavior is observed with this image, too: https://hub.docker.com/r/joshooaj/zensical)

Solution: The content of the project is copied to a temporary folder not mounted to the host system. The `build` command is then executed in this temporary folder and finally the content is copied back to the mounted folder.
