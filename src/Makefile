ROOT_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
APP_NAME := pybossa
APP_VERSION := 4.1.14

ifndef_any_of = $(filter undefined,$(foreach v,$(1),$(origin $(v))))
ifneq ($(call ifndef_any_of, \
	ENV_NAME \
	),)
$(error Environment incorrectly configured in env file)
endif

ENV_PATH := $(ROOT_DIR)../build/environments/$(ENV_NAME)/
include $(ENV_PATH)env.mk

ifndef_any_of = $(filter undefined,$(foreach v,$(1),$(origin $(v))))
ifneq ($(call ifndef_any_of, \
	REPOSITORY_NAMESPACE \
	IMAGE_REGISTRY_TYPE \
	IMAGE_REGISTRY \
	),)
$(error Environment incorrectly configured in env file)
endif

COMMIT := $(shell git rev-parse --short HEAD)

REGISTRY := $(IMAGE_REGISTRY)
REPOSITORY := $(REPOSITORY_NAMESPACE)/$(APP_NAME)
VERSION := $(APP_VERSION)
REGISTRY_MK := $(ROOT_DIR)../tools/$(shell echo $(IMAGE_REGISTRY_TYPE) | tr A-Z a-z).mk
include $(REGISTRY_MK)

#########################
### TOP LEVEL TARGETS ###
#########################

.PHONY: clean
.PHONY: build run
.PHONY: scan publish
.PHONY: repository-login create-repository list-images

build: DOCKER_CONTENT_TRUST=1
build:
	cd .. && \
	docker build \
		-t $(REPOSITORY)-worker \
		-t $(REPOSITORY)-worker:$(APP_VERSION) \
		--build-arg APP_NAME="$(APP_NAME)" \
		--build-arg VERSION="$(APP_VERSION)" \
		--build-arg REVISION="$(COMMIT)" \
		-f ./src/Dockerfile.worker \
		.

clean:
	docker-compose down -t0 -v --remove-orphans

run:
	docker-compose up --remove-orphans

scan: scan-python scan-dockle scan-trivy

publish: publish-image

#########################
### SCAN DEPENDENCIES ###
#########################

.PHONY: scan-python scan-docker scan-trivy

scan-python:
	bandit \
		--severity-level=medium \
		-c $(ROOT_DIR)pyproject.toml \
		-r .

scan-dockle: DOCKLE_IGNORES = $(shell awk 'NF {print $1}' $(ROOT_DIR).dockleignore | paste -s -d, -)
scan-dockle: build
	docker run --rm \
		--env DOCKER_CONTENT_TRUST=1 \
		--env DOCKLE_IGNORES=$(DOCKLE_IGNORES) \
		-v /var/run/docker.sock:/var/run/docker.sock \
		goodwithtech/dockle:latest \
		--timeout 10m \
		--exit-code 1 \
		--exit-level warn \
		--accept-file settings.py \
		$(REPOSITORY):$(APP_VERSION)

scan-trivy: build
	docker run --rm \
		-v /var/run/docker.sock:/var/run/docker.sock \
		-v $${XDG_CACHE_HOME:-$$HOME/.cache}:/root/.cache/ \
		aquasec/trivy:latest \
		image \
		--timeout 10m \
		--ignore-unfixed \
		--exit-code 1 \
		--severity MEDIUM,HIGH,CRITICAL \
		$(REPOSITORY):$(APP_VERSION)
