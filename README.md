# swupdate-builder as docker container

https://hub.docker.com/r/jneuhauser/swupdate-builder/

## build conatiner

### build container
docker build . -t jneuhauser/swupdate-builder:stretch

### build container with support to build a debian package
docker build --build-arg DEBIAN_PACKAGE=y . -t jneuhauser/swupdate-builder:stretch-deb-package

### build container with the same proxy as from host
docker build --build-arg HTTP_PROXY --build-arg HTTPS_PROXY --build-arg http_proxy --build-arg https_proxy . -t jneuhauser/swupdate-builder:stretch

## use container to build swupdate in local host dir

### run container
docker run -i -t -v $(pwd):/swupdate jneuhauser/swupdate-builder:stretch

### run container with the same proxy as from host
docker run -e HTTP_PROXY -e HTTPS_PROXY -e http_proxy -e https_proxy -i -t -v $(pwd):/swupdate jneuhauser/swupdate-builder:stretch
