APP_NAME := pybossa
APP_VERSION ?= 4.0.2
IMAGE_REPOSITORY := $(APP_NAME)
DOCKERFILE_PATH ?= Dockerfile
DOCKER_BUILD_CONTEXT ?= .

COMMIT = $(shell git rev-parse --short HEAD)

clean:
	docker rmi -f $(IMAGE_REPOSITORY)
	docker rmi -f $(IMAGE_REPOSITORY):$(APP_VERSION)
	docker image prune -f

lint:
	$(eval $(call latest_github_release,hadolint_version,hadolint,hadolint))
	docker run --rm -i hadolint/hadolint:$(hadolint_version) < $(DOCKERFILE_PATH)

build: DOCKER_CONTENT_TRUST=1
build: lint
	docker build \
		-t $(IMAGE_REPOSITORY) \
		-t $(IMAGE_REPOSITORY):$(APP_VERSION) \
		-f $(DOCKERFILE_PATH) \
		--build-arg APP_NAME="$(APP_NAME)" \
		--build-arg VERSION="$(APP_VERSION)" \
		--build-arg REVISION="$(COMMIT)" \
		$(DOCKER_BUILD_CONTEXT)

scan: build scan-dockle scan-trivy

scan-dockle:
	$(eval $(call latest_github_release,dockle_version,goodwithtech,dockle))
	$(eval dockle_version=v$(dockle_version))
	docker run --rm \
		-v /var/run/docker.sock:/var/run/docker.sock \
		goodwithtech/dockle:$(dockle_version) \
		--exit-code 1 \
		--exit-level warn \
		$(IMAGE_REPOSITORY):$(APP_VERSION)

scan-trivy:
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

publish:
	docker tag $(IMAGE_REPOSITORY):$(APP_VERSION) $(IMAGE_REPOSITORY):$(COMMIT)

define latest_github_release =
 $(1) = $(shell \
 	curl --silent https://api.github.com/repos/$(2)/$(3)/releases/latest | \
 	grep '"tag_name":' | \
	sed -E 's/.*v([^"]+).*/\1/')
endef
