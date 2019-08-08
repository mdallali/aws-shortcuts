provider "aws" {
  region = "us-east-1"
}

#Accounts
variable "accounts" {
  type    = "list"
  default = ["123456789012", "534373424529"] 
}

data "template_file" "cross-account" {
  template = "${file("templates/cross-account-policy.tpl")}"
  vars {
    role_arn = "${join("\",\"", formatlist("arn:aws:iam::%s:role/ReadOnlyCrossAccount", var.accounts))}"
  }
}

resource "aws_iam_policy" "assume_role" {
  name = "AssumeRoles"
  path = "/"
  policy = "${data.template_file.cross-account.rendered}" 
}

output "arns" {
  value = "${formatlist("arn:aws:iam:%s:role/ReadOnlyCrossAccount", var.accounts)}"
}
