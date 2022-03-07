
export PATH_DEPLOY=.deploy
export APP_NAME=laravel
export ECR_ACCOUNT=000000000000
export AWS_DEFAULT_REGION=ap-southeast-2
export CONTAINER_PORT=80
export MEMORY?=1024
BUILD_VERSION?=latest

export IMAGE_NAME=$(ECR_ACCOUNT).dkr.ecr.$(AWS_DEFAULT_REGION).amazonaws.com/${APP_NAME}:${BUILD_VERSION}

dockerBuild:
	@echo "make dockerBuild"
	docker build  --no-cache -t ${IMAGE_NAME} .
.PHONY: dockerBuild

app-run:
	echo "--- running app"
	docker-compose -f $(PATH_DEPLOY)/docker-compose.yml run --rm ${APP_NAME}
.PHONY: app-run

app-start:
	@echo "Starting application..."
	docker-compose -f .deploy/docker-compose.yml up laravel
.PHONY: app-start

run:
	docker run --env-file .env -p 8080:$(CONTAINER_PORT) $(IMAGE_NAME)
.PHONY: run
