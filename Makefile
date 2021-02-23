export SHELL := /bin/bash

.PHONY: all
all: tf-build-nightly

.PHONY: clean
clean:
	docker system prune -a -f

#------------------------------- BUILD TARGETS ----------------------------------------------------------------------
.PHONY: tf-build-nightly
tf-build-nightly:
	docker build --no-cache -t tf-build:nightly -f DockerfileNIGHTLY .

.PHONY: tf-build-241
tf-build-241:
	docker build --no-cache -t tf-build:v2.4.1 -f Dockerfile241 .

#------------------------------- RUN TARGETS ----------------------------------------------------------------------

.PHONY: run-tf-build-nightly
run-tf-build-nightly:
	docker run -it tf-build:nightly /bin/bash

.PHONY: run-tf-build-241
run-tf-build-241:
	docker run -it tf-build:v2.4.1 /bin/bash


