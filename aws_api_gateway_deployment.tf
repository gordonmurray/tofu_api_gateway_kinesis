
resource "aws_api_gateway_deployment" "default" {
  rest_api_id       = aws_api_gateway_rest_api.default.id
  stage_name        = "prod"
  stage_description = "Production stage"
  depends_on        = [aws_api_gateway_integration.post]
  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.default.body))
  }
}
