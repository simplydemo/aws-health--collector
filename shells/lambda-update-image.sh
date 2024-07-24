#!/bin/bash

REPO_NAME="cops-health-delibird-lambda-ecr"

ECR_REPO_URL=$(aws ecr describe-repositories --query "repositories[?repositoryName=='${REPO_NAME}'].repositoryUri" --output text)

echo "ECR_REPO_URL: $ECR_REPO_URL"

aws lambda update-function-code --function-name cops-health-delibird-lambda \
  --image-uri ${ECR_REPO_URL}:1.0.0  --no-cli-pager