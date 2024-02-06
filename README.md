# tofu_api_gateway_kinesis
Using Open Tofu to create an AWS API gateway that submits data to Kinesis



### Example Curl command

```
curl -X POST \
     -H "Content-Type: application/json" \
     -d '{"message": "Hello World"}' \
     https://xxxxxxxxx.execute-api.us-east-1.amazonaws.com/prod/upload/
 ```