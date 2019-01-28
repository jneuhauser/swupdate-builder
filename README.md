# swupdate-builder as docker container

https://hub.docker.com/r/jneuhauser/swupdate-builder/

## run non host arch containers

https://hub.docker.com/r/multiarch/qemu-user-static

### Register qemu-*-static for all supported processors except the current one
`docker run --rm --privileged multiarch/qemu-user-static:register --reset`

## build conatiner

### build container
```
FLAVOR=armhf-stretch
docker build -t jneuhauser/swupdate-builder:${FLAVOR} -f Dockerfile.${FLAVOR} .
```

### build container with the same proxy as from host
```
FLAVOR=armhf-stretch
docker build --build-arg HTTP_PROXY --build-arg HTTPS_PROXY --build-arg http_proxy --build-arg https_proxy -t jneuhauser/swupdate-builder:${FLAVOR} -f Dockerfile.${FLAVOR} .
```

## use container to build swupdate in persistent host dir

### run container
```
FLAVOR=armhf-stretch
cd ${WORKDIR}
docker run --rm -i -t -v $(pwd):/swupdate jneuhauser/swupdate-builder:${FLAVOR}
```

### run container with the same proxy as from host
```
FLAVOR=armhf-stretch
cd ${WORKDIR}
docker run -e HTTP_PROXY -e HTTPS_PROXY -e http_proxy -e https_proxy --rm -i -t -v $(pwd):/swupdate jneuhauser/swupdate-builder:${FLAVOR}
```

## build swupdate from within container in local host dir

### build swupdate tar file
```
git clone -b 2018.11-release https://github.com/jneuhauser/swupdate.git
cd swupdate
make dh_defconfig
make -j4
install -m 755 swupdate /usr/local/bin/
executables_with_so_to_tar /swupdate/ swupdate
```

### build swupdate debian package
```
git clone -b 2018.11-release https://github.com/jneuhauser/swupdate.git
cd swupdate
export DEB_BUILD_OPTIONS='parallel=4'
./debian/rules clean && ./debian/rules build && fakeroot debian/rules binary
```
