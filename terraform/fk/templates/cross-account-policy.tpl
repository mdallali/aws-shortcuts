{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Resource": [
        "${role_arn}"
	],
      "Action": [
        "sts:AssumeRole"
      ]
    }
  ]
}
