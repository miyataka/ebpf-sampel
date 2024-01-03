# IMAGE={ubuntu:latest}
IMAGE_TAG=ebpf:0.0.1 # image created by docker commit from ubuntu:latest

.PHONY: run
run:
	docker run -it --mount type=bind,source=${PWD},target=/home/ubuntu ${IMAGE_TAG} bash

.PHONY: docker-commit
docker-commit:
	docker commit $(shell docker ps -lq) ${IMAGE_TAG}
