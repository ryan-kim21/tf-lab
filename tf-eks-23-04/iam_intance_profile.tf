resource "aws_iam_instance_profile" "dev-ec2-instance-profile" {
  name = "dev-ec2-instance-profile"
  path = "/"
  role = "dev-iam-role-ec2-instance-bastion"
}