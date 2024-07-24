#!/bin/bash

TOPIC_NAME="cops-aws-health-topic"
TOPIC_ARN=$(aws sns list-topics | jq -r --arg TOPIC_NAME "$TOPIC_NAME" '.Topics[] | select(.TopicArn | contains($TOPIC_NAME)).TopicArn')

echo "TOPIC_NAME: $TOPIC_NAME"
echo "TOPIC_ARN: $TOPIC_ARN"

aws sns publish --topic-arn $TOPIC_ARN --subject "AWS Health Event Notification" \
    --message file://resources/sns.message.json \
    --message-attributes file://resources/sns.attr.json