data "aws_iam_policy_document" "server_execution_role_assume_policy" {
  statement {
    actions = [
      "sts:AssumeRole"
    ]
    effect = "Allow"
    principals {
      identifiers = [
        "apigateway.amazonaws.com",
        "lambda.amazonaws.com",
        "events.amazonaws.com"
      ]
      type = "Service"
    }
  }
}

resource "aws_iam_role" "server_execution_role" {
  assume_role_policy = data.aws_iam_policy_document.server_execution_role_assume_policy.json

  name                  = "${local.server}-execution-role"
  description           = "${local.server}-execution-role"
  force_detach_policies = true
}
