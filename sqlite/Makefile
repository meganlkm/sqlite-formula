GIT_COMMIT=$(shell git rev-parse HEAD)
MY_DIR=$(shell basename "$(CURDIR)")
TEST_LABEL_KEY=salt-state-testing
TEST_TAG=${TEST_LABEL_KEY}
define DOCKER_BODY
ARG TEST_LABEL
ARG TEST_LABEL_KEY
ARG TEST_TAG
ARG GIT_COMMIT=unknown
LABEL $$TEST_LABEL_KEY=$$TEST_LABEL
LABEL git-commit=$$GIT_COMMIT
LABEL TEST_TAG=$$TEST_TAG
ADD tests/ /srv/salt
ADD . /srv/salt/$$TEST_LABEL
WORKDIR /srv/salt
RUN sed -i "s/#master: salt/master: localhost/g" /etc/salt/minion &&\
   salt-call --local state.apply
endef
export DOCKER_BODY
.PHONY: default
test testv:
	echo 'FROM simplyadrian/allsalt:debian_jessie > tests/Dockerfile
	echo "$$DOCKER_BODY" >> tests/Dockerfile
	docker build --build-arg TEST_LABEL="${MY_DIR}" \
	  --build-arg TEST_LABEL_KEY=${TEST_LABEL_KEY} \
	  --build-arg GIT_COMMIT=${GIT_COMMIT} \
	  --build-arg TEST_TAG=${TEST_TAG} \
	  --force-rm -t "${MY_DIR}":${TEST_TAG} -f tests/Dockerfile .
remove:
	docker rmi $(shell docker images -q --filter label=TEST_TAG=${TEST_TAG} --filter label=${TEST_LABEL_KEY}="${MY_DIR}")
	rm tests/Dockerfile
clean .IGNORE: remove
all: test
