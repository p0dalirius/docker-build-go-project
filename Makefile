.PHONY: all build_docker compile

IMGNAME := build_go_project
INSTALL_PATH := /usr/local/bin/build-go-project

all: install

build_docker:
	docker build -t $(IMGNAME):latest -f Dockerfile .

install: build_docker
	cp build-go-project.sh ${INSTALL_PATH}
	chmod +x ${INSTALL_PATH}

compile: build_docker
	docker run --rm -v "$(shell pwd):/workspace" -it $(IMGNAME) $(shell uname -s | tr "[:upper:]" "[:lower:]") $(shell uname -m)
