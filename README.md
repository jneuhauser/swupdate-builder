# swupdate-builder as docker container

https://hub.docker.com/r/jneuhauser/swupdate-builder/

## build conatiner

### build container
`docker build . -t jneuhauser/swupdate-builder:jessie`

### build container with the same proxy as from host
`docker build --build-arg HTTP_PROXY --build-arg HTTPS_PROXY --build-arg http_proxy --build-arg https_proxy . -t jneuhauser/swupdate-builder:jessie`

## use container to build swupdate in local host dir

### run container
`docker run -i -t -v $(pwd):/swupdate jneuhauser/swupdate-builder:jessie`

### run container with the same proxy as from host
`docker run -e HTTP_PROXY -e HTTPS_PROXY -e http_proxy -e https_proxy -i -t -v $(pwd):/swupdate jneuhauser/swupdate-builder:jessie`

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
