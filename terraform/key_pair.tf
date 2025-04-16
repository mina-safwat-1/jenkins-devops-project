resource "aws_key_pair" "my_key" {
  key_name   = "my-aws-key"
  public_key = file("${path.module}/my-aws-key.pub")
}