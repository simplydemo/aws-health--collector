#!/bin/bash

REGION="ap-northeast-2"
ECR_NAME="cops-health-delibird-lambda-ecr"
ECR_TAG="1.0.0"
KMS_ALIAS_NAME="aws/ecr"
LAMBDA_IMAGE="symplesims/aws-health-delibird:1.0.0"

# ECR 생성 함수
create_ecr() {
    aws ecr create-repository \
        --repository-name $ECR_NAME --image-tag-mutability IMMUTABLE --no-cli-pager \
        --encryption-configuration '{"encryptionType":"KMS","kmsKey":"alias/aws/ecr"}' \
        --image-scanning-configuration scanOnPush=false

    aws ecr put-lifecycle-policy --repository-name $ECR_NAME --no-cli-pager \
        --lifecycle-policy-text '{
            "rules": [
                {
                    "rulePriority": 1,
                    "description": "Keep only 15 images",
                    "selection": {
                        "tagStatus": "any",
                        "countType": "imageCountMoreThan",
                        "countNumber": 15
                    },
                    "action": {
                        "type": "expire"
                    }
                }
            ]
        }'
}


# ECR 이미지 업로드 함수
upload_image() {
    docker pull $LAMBDA_IMAGE

    local ecr_repository_uri=$(aws ecr describe-repositories --repository-names $ECR_NAME --query "repositories[0].repositoryUri" --output text)

    echo "Docker 로그인 중..."
    aws ecr get-login-password --region $REGION | docker login --username AWS --password-stdin $ecr_repository_uri

    echo "Docker 이미지 태그 추가 중..."
    docker tag $LAMBDA_IMAGE "$ecr_repository_uri:${ECR_TAG}"

    echo "Docker 이미지 푸시 중..."
    ECR_REPOSITORY_URI="$ecr_repository_uri:${ECR_TAG}"
    docker push "$ECR_REPOSITORY_URI"
}


echo "1. ECR 저장소 생성"
create_ecr

echo "2. ECR 업로드 실행"
upload_image

