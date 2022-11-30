ifndef_any_of = $(filter undefined,$(foreach v,$(1),$(origin $(v))))
ifneq ($(call ifndef_any_of, \
	AWS_PROFILE \
	AWS_REGION \
	REGISTRY \
	REPOSITORY \
	VERSION \
	),)
$(error Environment incorrectly configured in .env)
endif

.PHONY: tag-image publish-image
.PHONY: repository-login create-repository list-images

tag-image:
	docker tag $(REPOSITORY):$(VERSION) \
		$(REGISTRY)/$(REPOSITORY):$(VERSION)

publish-image: repository-login tag-image
	docker push $(REGISTRY)/$(REPOSITORY):$(VERSION)

repository-login:
	@aws ecr get-login-password \
		--profile=$(AWS_PROFILE) \
		--region=$(AWS_REGION) \
	| docker login \
		--username=AWS \
		--password-stdin $(REGISTRY) >/dev/null 2>&1

create-repository: repository-login
	aws ecr describe-repositories \
		--profile=$(AWS_PROFILE) \
		--region=$(AWS_REGION) \
		--repository-name=$(REPOSITORY) 2>&1 >/dev/null || \
	aws ecr create-repository \
		--profile=$(AWS_PROFILE) \
		--region=$(AWS_REGION) \
		--repository-name=$(REPOSITORY) \
		--image-tag-mutability IMMUTABLE \
		--image-scanning-configuration scanOnPush=true

list-images: repository-login
	@aws ecr list-images \
		--profile=$(AWS_PROFILE) \
		--region=$(AWS_REGION) \
		--repository-name=$(REPOSITORY)

list-charts: repository-login
	@aws ecr list-images \
		--profile=$(AWS_PROFILE) \
		--region=$(AWS_REGION) \
		--repository-name=$(REPOSITORY)
