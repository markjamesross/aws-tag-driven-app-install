resource "aws_cloudwatch_event_rule" "event_driven_install_uninstall" {
  name        = "event-driven-install-uninstall"
  description = "Capture tag being added to EC2 instance to drive application install or uninstall"

  event_pattern = <<EOF
{
  "source": ["aws.tag"],
  "detail-type": ["Tag Change on Resource"],
  "detail": {
    "service": [
        "ec2"
    ],
    "resource-type": [
        "instance"
    ]
  }
}
EOF
  tags          = merge({ Name = "event-driven-install" }, var.tags)
}

resource "aws_cloudwatch_event_target" "event_driven_install_uninstall" {
  rule = aws_cloudwatch_event_rule.event_driven_install_uninstall.name
  arn  = aws_lambda_function.event_driven_install_uninstall.arn
}