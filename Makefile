export SHELL := /bin/bash

.PHONY: all
all: tf-build

.PHONY: clean
clean:
	docker rmi -f $(docker images -a -q)
	docker system prune -a -f

#------------------------------- BUILD TARGETS ----------------------------------------------------------------------
.PHONY: tf-buildpy36tf240
tf-buildpy36tf240:
	docker build --no-cache -t tf-build:py38tf240 -f Dockerfile240 .

.PHONY: tf-buildpy35tf230
tf-buildpy35tf230:
	docker build --no-cache -t tf-build:py35tf230 -f Dockerfile230 .

.PHONY: tf-build-test
tf-build-test:
	docker build --no-cache -t tf-build:TEST -f DockerfileTEST .
#------------------------------- RUN TARGETS ----------------------------------------------------------------------

.PHONY: run-tf-buildpy36tf240
run-tf-buildpy36tf240:
	docker run -it tf-build:py36tf240 /bin/bash

.PHONY: run-buildpy35tf230
run-buildpy35tf230:
	docker run -it tf-build:py35tf232 /bin/bash

.PHONY: run-tf-build-test
run-tf-build-test:
	docker run -i tf-build:TEST bash < test.sh

