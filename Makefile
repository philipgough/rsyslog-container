TAG ?= $(shell git -C "$(PROJECT_PATH)" describe --dirty --tags || echo 'latest')
PROJECT_PATH := $(patsubst %/,%,$(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
REGISTRY ?= docker.io/philipgough
IMAGE_NAME = rsyslog


.PHONY: image
image: ## Build container image
	docker build -f $(PROJECT_PATH)/Dockerfile --tag $(REGISTRY)/$(IMAGE_NAME):$(TAG) .

.PHONY: test
test: ## Test the container image
	./test.sh
