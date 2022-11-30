AWS_PROFILE ?= euw1-infra
AWS_REGION ?= eu-west-1

REPOSITORY_NAMESPACE ?= ai

IMAGE_REGISTRY_TYPE ?= ECR
IMAGE_REGISTRY ?= 361126655718.dkr.ecr.eu-west-1.amazonaws.com

CHART_REGISTRY_TYPE ?= ECR
CHART_REGISTRY ?= 361126655718.dkr.ecr.eu-west-1.amazonaws.com

K8S_API_VERSION ?= 1.20.15
K8S_NAMESPACE ?= ci

SECRET_VARS_AWS_SECRET_KEY := does-not-matter
IMAGE_CREDENTIALS_PASSWORD = $(shell aws ecr get-login-password --profile=$(AWS_PROFILE))
