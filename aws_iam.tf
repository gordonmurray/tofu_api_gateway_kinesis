# Create an IAM Role and Policy for API Gateway to Access Kinesis

resource "aws_iam_role" "api_gateway_kinesis_role" {
  name = "api_gateway_kinesis_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "apigateway.amazonaws.com"
        },
      },
    ],
  })
}

resource "aws_iam_role_policy" "api_gateway_kinesis_policy" {
  name = "api_gateway_kinesis_policy"
  role = aws_iam_role.api_gateway_kinesis_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "kinesis:PutRecord",
          "kinesis:PutRecords"
        ],
        Effect   = "Allow",
        Resource = aws_kinesis_stream.example_stream.arn
      },
    ],
  })
}
