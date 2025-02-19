resource "aws_iam_user" "abz_readonly" {
  name = "abz-readonly"
}

resource "aws_iam_user_policy_attachment" "abz_readonly" {
  user = aws_iam_user.abz_readonly.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

resource "aws_iam_user_login_profile" "abz_readonly" {
  user = aws_iam_user.abz_readonly.name
}

resource "aws_iam_access_key" "abz_readonly" {
  user = aws_iam_user.abz_readonly.name
}

output "abz_readonly_console_password" {
  sensitive = true
  value     = aws_iam_user_login_profile.abz_readonly.password
}

output "abz_readonly_access_key" {
  value = aws_iam_access_key.abz_readonly.id
}

output "abz_readonly_secret_key" {
  sensitive = true
  value     = aws_iam_access_key.abz_readonly.secret
}