login-to-container-registry:
ifndef AWS_PROFILE
	$(error AWS_PROFILE is not defined)
endif
ifndef CONTAINER_REGISTRY_HOST
	$(error CONTAINER_REGISTRY_HOST is not defined)
endif
	aws ecr get-login-password \
		--profile=$(AWS_PROFILE) | \
	docker login \
		--username AWS \
		--password-stdin $(CONTAINER_REGISTRY_HOST)
.PHONY: login-to-container-registry
