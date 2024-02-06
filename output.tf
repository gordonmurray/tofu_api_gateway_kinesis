output "api_gateway_invoke_url" {
  value = "https://${aws_api_gateway_rest_api.default.id}.execute-api.${var.aws_region}.amazonaws.com/prod"
}
