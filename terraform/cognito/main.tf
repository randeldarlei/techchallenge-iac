resource "aws_cognito_user_pool_client" "client" {
  name         = "client"
  user_pool_id = aws_cognito_user_pool.pool.id
}

resource "aws_cognito_user_pool" "pool" {
  name = "pool"
}

resource "aws_iam_role" "cognito_role" {
  name = "cognito_role"

  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "cognito-idp.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "cognito_policy" {
  name   = "cognito_policy"
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "cognito-idp:AdminInitiateAuth",
          "cognito-idp:AdminUserGlobalSignOut"
        ],
        "Resource": "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_cognito_policy" {
  role       = aws_iam_role.cognito_role.name
  policy_arn = aws_iam_policy.cognito_policy.arn
}
