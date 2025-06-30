data "aws_iam_policy_document" "server_execution_role_policy" {
  statement {
    actions = [
      "lambda:*",
      "cloudformation:*"
    ]
    resources = ["*"]
    effect    = "Allow"
  }
  statement {
    actions = [
      "ec2:AttachNetworkInterface",
      "ec2:CreateNetworkInterface",
      "ec2:DeleteNetworkInterface",
      "ec2:DescribeInstances",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeSubnets",
      "ec2:DescribeVpcs",
      "ec2:DescribeVpcsRequest",
      "ec2:DetachNetworkInterface",
      "ec2:ModifyNetworkInterfaceAttribute",
      "ec2:ResetNetworkInterfaceAttribute"
    ]
    resources = ["*"]
    effect    = "Allow"
  }
  statement {
    actions = [
      "xray:PutTraceSegments",
      "xray:PutTelemetryRecords"
    ]
    resources = ["*"]
    effect    = "Allow"
  }
  statement {
    actions   = ["logs:*"]
    resources = ["arn:aws:logs:*:*:*"]
    effect    = "Allow"
  }
  statement {
    actions   = ["apigateway:*"]
    resources = ["*"]
    effect    = "Allow"
  }
  statement {
    actions   = ["dynamodb:*"]
    resources = ["arn:aws:dynamodb:*:*:*"]
    effect    = "Allow"
  }
  statement {
    actions   = ["elasticfilesystem:*"]
    resources = ["*"]
    effect    = "Allow"
  }
  statement {
    actions   = ["events:*"]
    resources = ["*"]
    effect    = "Allow"
  }
  statement {
    actions   = ["kinesis:*"]
    resources = ["arn:aws:kinesis:*:*:*"]
    effect    = "Allow"
  }
  statement {
    actions   = ["route53:*"]
    resources = ["*"]
    effect    = "Allow"
  }
  statement {
    actions   = ["sns:*"]
    resources = ["arn:aws:sns:*:*:*"]
    effect    = "Allow"
  }
  statement {
    actions   = ["sqs:*"]
    resources = ["arn:aws:sqs:*:*:*"]
    effect    = "Allow"
  }
  statement {
    actions   = ["s3:*"]
    resources = ["arn:aws:s3:::*", "arn:aws:s3:::*/*"]
    effect    = "Allow"
  }
}

resource "aws_iam_policy" "server_execution_role_permissions" {
  name        = "${local.server}-execution-role-permissions"
  description = "${local.server}-execution-role-permissions"

  policy = data.aws_iam_policy_document.server_execution_role_policy.json
}

resource "aws_iam_role_policy_attachment" "server_execution_role_permissions" {
  role       = aws_iam_role.server_execution_role.name
  policy_arn = aws_iam_policy.server_execution_role_permissions.arn
}
