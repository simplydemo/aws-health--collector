#!/bin/bash

# aws events put-events --entries file://resources/eventbus.evt.json

aws events put-events --region us-east-1 --entries file://resources/eventbus.default.json

