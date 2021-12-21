ROOT_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
APP_NAME := pybossa
APP_VERSION ?= 4.1.11
DOCKERFILE_PATH ?= Dockerfile
DOCKER_BUILD_CONTEXT ?= .
COMMIT = $(shell git rev-parse --short HEAD)

clean:
ifndef IMAGE_REPOSITORY
	$(error IMAGE_REPOSITORY is not defined)
endif
	docker rmi -f $(APP_NAME)
	docker rmi -f $(APP_NAME):$(APP_VERSION)
	docker rmi -f $(IMAGE_REPOSITORY)
	docker rmi -f $(IMAGE_REPOSITORY):$(APP_VERSION)
	docker rmi -f $(CONTAINER_REGISTRY_HOST)/$(IMAGE_REPOSITORY):$(APP_VERSION)
	docker image prune -f

lint:
	$(eval $(call latest_github_release,hadolint_version,hadolint,hadolint))
	docker run --rm -i hadolint/hadolint:$(hadolint_version) < $(DOCKERFILE_PATH)

build: DOCKER_CONTENT_TRUST=1
build:
ifndef IMAGE_REPOSITORY
	$(error IMAGE_REPOSITORY is not defined)
endif
	docker build \
		-t $(APP_NAME) \
		-t $(APP_NAME):$(APP_VERSION) \
		-f $(DOCKERFILE_PATH) \
		--build-arg APP_NAME="$(APP_NAME)" \
		--build-arg VERSION="$(APP_VERSION)" \
		--build-arg REVISION="$(COMMIT)" \
		$(DOCKER_BUILD_CONTEXT)

scan: build scan-dockle scan-trivy

scan-dockle:
ifndef IMAGE_REPOSITORY
	$(error IMAGE_REPOSITORY is not defined)
endif
	$(eval $(call latest_github_release,dockle_version,goodwithtech,dockle))
	$(eval dockle_version=v$(dockle_version))
	docker run --rm \
		-v /var/run/docker.sock:/var/run/docker.sock \
		goodwithtech/dockle:$(dockle_version) \
		--exit-code 1 \
		--exit-level warn \
		$(IMAGE_REPOSITORY):$(APP_VERSION)

scan-trivy:
ifndef IMAGE_REPOSITORY
	$(error IMAGE_REPOSITORY is not defined)
endif
	$(eval $(call latest_github_release,trivy_version,aquasecurity,trivy))
ifdef XDG_CONFIG_HOME
	docker run --rm \
		-v /var/run/docker.sock:/var/run/docker.sock \
		-v $(XDG_CONFIG_HOME):/root/.cache/ \
		aquasec/trivy:$(trivy_version) \
		--ignore-unfixed \
		--exit-code 1 \
		--severity MEDIUM,HIGH,CRITICAL \
		$(IMAGE_REPOSITORY):$(APP_VERSION)
else
	docker run --rm \
		-v /var/run/docker.sock:/var/run/docker.sock \
		aquasec/trivy:$(trivy_version) \
		--exit-code 1 \
		--severity MEDIUM,HIGH,CRITICAL \
		$(IMAGE_REPOSITORY):$(APP_VERSION)
endif

ifeq ($(MAKECMDGOALS), publish)
ifndef CONTAINER_REGISTRY
$(error CONTAINER_REGISTRY is not defined)
endif
include $(ROOT_DIR)$(shell echo $(CONTAINER_REGISTRY) | tr A-Z a-z).mk
publish: login-to-container-registry
ifndef IMAGE_REPOSITORY
	$(error IMAGE_REPOSITORY is not defined)
endif
ifndef CONTAINER_REGISTRY_HOST
	$(error CONTAINER_REGISTRY_HOST is not defined)
endif
	docker tag $(APP_NAME) $(IMAGE_REPOSITORY)
	docker tag $(APP_NAME):$(APP_VERSION) $(IMAGE_REPOSITORY):$(APP_VERSION)
	docker tag $(APP_NAME):$(APP_VERSION) $(CONTAINER_REGISTRY_HOST)/$(IMAGE_REPOSITORY):$(APP_VERSION)
	docker push $(CONTAINER_REGISTRY_HOST)/$(IMAGE_REPOSITORY):$(APP_VERSION)
endif

define latest_github_release =
 $(1) = $(shell \
 	curl --silent https://api.github.com/repos/$(2)/$(3)/releases/latest | \
 	grep '"tag_name":' | \
	sed -E 's/.*v([^"]+).*/\1/')
endef
