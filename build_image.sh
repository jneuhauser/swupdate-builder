#!/usr/bin/env sh

usage() {
	echo "Usage: $(basename ${0}) flavor"
	exit 1
}

FLAVOR=${1}
[ -r "Dockerfile.${FLAVOR}" ] || usage

docker run --rm --privileged multiarch/qemu-user-static:register --reset

docker build --build-arg HTTP_PROXY --build-arg HTTPS_PROXY --build-arg http_proxy --build-arg https_proxy -t jneuhauser/swupdate-builder:${FLAVOR}-latest -f Dockerfile.${FLAVOR} .
