export SHELL := /bin/bash
export TAG := TEST

.PHONY: all
all: tf-build

.PHONY: tf-build
tf-build:
	docker build --no-cache -t tf-build:$(TAG) -f Dockerfile .

.PHONY: tf-build-test
tf-build-test:
	docker build --no-cache -t tf-build:$(TAG) -f DockerfileTEST .
#------------------------------- RUN TARGETS ----------------------------------------------------------------------

.PHONY: run-tf-build
run-tf-build:
	docker run -it tf-build:$(TAG) /bin/bash

.PHONY: run-tf-build-test
run-tf-build-test:
	docker run -i tf-build:$(TAG) bash < test.sh

