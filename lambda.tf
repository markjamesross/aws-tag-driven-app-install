resource "aws_lambda_function" "event_driven_install_uninstall" {
  filename         = "./src/event-driven-install-uninstall.zip"
  source_code_hash = filebase64sha256("./src/event-driven-install-uninstall.zip")
  function_name    = "event-driven-install-uninstall"
  role             = aws_iam_role.iam_for_lambda.arn
  handler          = "event-driven-install-uninstall.handler"
  runtime          = "python3.7"

  environment {
    variables = {
      LOG_LEVEL              = "10"
      SSM_DOCUMENT_INSTALL   = var.ssm_document_install
      SSM_DOCUMENT_UNINSTALL = var.ssm_document_uninstall
      APP_TAG_KEY            = var.app_tag_key
      APP_TAG_INSTALL_VALUE  = var.app_tag_install_value
    }
  }

  tags = merge({ Name = "event-driven-install-uninstall" }, var.tags)
}

resource "aws_iam_role" "iam_for_lambda" {
  name = "iam-for-lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = merge({ Name = "iam-for-lambda" }, var.tags)
}

resource "aws_iam_role_policy_attachment" "basic" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.iam_for_lambda.name
}

resource "aws_iam_role_policy_attachment" "ssm" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
  role       = aws_iam_role.iam_for_lambda.name
}

resource "aws_cloudwatch_log_group" "event_driven_install" {
  name              = "/aws/lambda/event-driven-install-uninstall"
  retention_in_days = 14
}

resource "aws_lambda_permission" "allow_cloudwatch_install_uninstall" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.event_driven_install_uninstall.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.event_driven_install_uninstall.arn
}