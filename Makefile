GCP_PROJECT_ID	:= mnes-datagate-prd
GCP_REGION		:= asia-northeast1


GITHUB_REPO 	:= mnes/datagate-uploader-tool
API_USERNAME	:= datagate
TRUST_PROXY		:= loopback
PORT			:= 80

API_PASSWORD_SM_NAME := update-server-api-password
GITHUB_TOKEN_SM_NAME := update-server-github-token

MODULE_NAME := github.com/mnes/datagate-uploader-updater
GIT_REF := $(shell git describe --always)
VERSION := commit-$(GIT_REF)

IMAGE_API := $(MODULE_NAME):$(VERSION)
IMAGE_URI := asia-northeast1-docker.pkg.dev/$(GCP_PROJECT_ID)/cloud-run/datagate-autoupdate-server:$(VERSION)
SERVICE_NAME := datagate-autoupdate-server

#############################################
# Run Locally
#############################################
.PHONY: local/up
local/run: ## Run the server in a local environment
	@docker-compose -f docker-compose.yml up -d

.PHONY: local/down
local/down: ## Run the server in a local environment
	@docker-compose -f docker-compose.yml down --remove-orphans

#############################################
# Deployment
#############################################
.PHONY: docker/build
docker/build: ## Build server with docker
	@docker build \
	--build-arg VERSION=$(VERSION) \
	--build-arg MODULE_NAME=$(MODULE_NAME) \
	-t $(IMAGE_API) \
	--platform linux/amd64 \
	.

.PHONY: docker/push
docker/push:
	@docker tag $(IMAGE_API) $(IMAGE_URI)
	@docker push $(IMAGE_URI)

.PHONY: gcloud/deploy
gcloud/deploy: ## Deploy api to cloud run environment
	@gcloud run deploy $(SERVICE_NAME) \
		--image="$(IMAGE_URI)" \
		--allow-unauthenticated \
		--platform managed \
		--project=$(GCP_PROJECT_ID) \
		--region=$(GCP_REGION) \
		--port=80 \
		--set-env-vars "GITHUB_REPO=$(GITHUB_REPO)" \
		--set-env-vars "API_USERNAME=$(API_USERNAME)" \
		--set-env-vars "TRUST_PROXY=$(TRUST_PROXY)" \
		--update-secrets=API_PASSWORD=$(API_PASSWORD_SM_NAME):latest \
		--update-secrets=GITHUB_TOKEN=$(GITHUB_TOKEN_SM_NAME):latest
	@gcloud run services update-traffic $(API_SERVICE_NAME) \
 		--to-latest \
		--project=${GCP_PROJECT_ID} \
		--region=${GCP_REGION}
