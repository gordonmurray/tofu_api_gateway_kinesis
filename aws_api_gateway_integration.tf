resource "aws_api_gateway_integration" "options" {
  connection_type      = "INTERNET"
  http_method          = "OPTIONS"
  passthrough_behavior = "WHEN_NO_MATCH"
  rest_api_id          = aws_api_gateway_rest_api.default.id
  resource_id          = aws_api_gateway_resource.resource.id
  timeout_milliseconds = "29000"
  type                 = "MOCK"

  request_templates = {
    "application/json" = "{\"statusCode\": 200}"
  }
}

resource "aws_api_gateway_integration" "post" {
  connection_type         = "INTERNET"
  content_handling        = "CONVERT_TO_TEXT"
  http_method             = aws_api_gateway_method.post.http_method
  integration_http_method = aws_api_gateway_method.post.http_method
  passthrough_behavior    = "WHEN_NO_MATCH"
  rest_api_id             = aws_api_gateway_rest_api.default.id
  resource_id             = aws_api_gateway_resource.resource.id
  timeout_milliseconds    = "29000"
  type                    = "AWS"
  uri                     = "arn:aws:apigateway:${var.aws_region}:kinesis:action/PutRecord"
  credentials             = aws_iam_role.api_gateway_kinesis_role.arn

  request_templates = {
    "application/json" = jsonencode({
      StreamName   = aws_kinesis_stream.example_stream.name,
      Data         = "$util.base64Encode($input.body)",
      PartitionKey = "partitionKey" // Define a suitable partition key
    })
  }

}
