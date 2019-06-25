provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_iam_user" "nopporn" {
  name = "nopporn"

  tags = {
    full-name = "Nopporn Chumnininini"
  }

  force_destroy = true
}

// Self-service policy
resource "aws_iam_user_policy_attachment" "self-service-atm" {
  user = aws_iam_user.nopporn.name
  policy_arn = aws_iam_policy.self-service-policy.arn
}

resource "aws_iam_policy" "self-service-policy" {
  name = "SelfService"
  policy = data.aws_iam_policy_document.self-service-doc.json
}

data "aws_iam_policy_document" "self-service-doc" {
  statement {
    sid       = "AllowIndividualUserToSeeAndManageOnlyTheirOwnAccountInformation"
    effect    = "Allow"
    resources = ["arn:aws:iam::*:user/$${aws:username}"]

    actions = [
      "iam:ChangePassword",
      "iam:CreateAccessKey",
      "iam:DeleteAccessKey",
      "iam:ListAccessKeys",
      "iam:UpdateAccessKey",
    ]
  }
}