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

publish-image: repository-login tag-image
	kind load --name=$(REGISTRY) docker-image $(REPOSITORY):$(VERSION)

repository-login:

create-repository:

list-images:
	@node_name=$$(kubectl get nodes \
		-l node-role.kubernetes.io/control-plane=,node-role.kubernetes.io/master \
		-o custom-columns=NAME:.metadata.name \
	| tail -n 1) \
	; docker exec $$node_name crictl images $(REPOSITORY)

list-charts:
	@helm show chart oci://$(CHART_REGISTRY)/$(REPOSITORY)
