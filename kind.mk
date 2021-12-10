login-to-container-registry:
.PHONY: login-to-container-registry

push-image-to-cluster:
ifndef IMAGE_REPOSITORY
	$(error IMAGE_REPOSITORY is not defined)
endif
	kind load docker-image $(IMAGE_REPOSITORY):$(APP_VERSION)
.PHONY: push-image-to-cluster
