provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_iam_user" "nopporn" {
  name = "nopporn"

  tags = {
    full-name = "Nopporn Chumnininini"
  }
}