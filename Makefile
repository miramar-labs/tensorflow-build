export SHELL := /bin/bash
export TAG := TEST

.PHONY: all
all: tf-build

.PHONY: tf-build
tf-build:
	docker build --no-cache --build-arg CUDAVER=$(CUDAVER) --build-arg CUDNNVER=$(CUDNNVER) --build-arg TFVER=$(TFVER) -t tf-build:$(TAG) -f Dockerfile .

#------------------------------- RUN TARGETS ----------------------------------------------------------------------

.PHONY: run-tf-build
run-tf-build:
	docker run -it tf-build:$(TAG) /bin/bash

.PHONY: run-tf-build-test
run-tf-build-test:
	docker run -i tf-build:$(TAG) bash < test.sh

