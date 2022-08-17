#!/bin/bash
aws lambda invoke --function-name go-lambda-function-3 --cli-binary-format raw-in-base64-out --payload '{"what is your name": "ahmet","what is your age": 21}' out
sed -i'' -e 's/"//g' out
sleep 15
aws logs get-log-events --log-group-name /aws/lambda/go-lambda-function-3 --log-stream-name $(cat out) --limit 5