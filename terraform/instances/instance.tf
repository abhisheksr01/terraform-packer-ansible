data "aws_ami" "ec2-ami" {
  filter {
    name   = "state"
    values = ["available"]
  }
  filter {
    name   = "tag:Name"
    values = ["Packer-Ansible"]
  }
  most_recent = true
}

data "terraform_remote_state" "remote" {
  backend = "s3"
  config = {
    bucket = "packer-terraform-ansible"
    key    = "s3/infrastructure/network/terraform.tfstate"
    region = "eu-west-2"
  }
}

resource "aws_instance" "instance" {
  ami                    = data.aws_ami.ec2-ami.id
  instance_type          = var.instance_type
  subnet_id              = data.terraform_remote_state.remote.outputs.public_subnets
  vpc_security_group_ids = data.terraform_remote_state.remote.outputs.security_group_ids
  key_name               = var.key_pair_name

  tags = var.default_tags
}

resource "aws_eip" "ami_ip" {
  vpc      = true
  instance = aws_instance.instance.id
  tags     = var.default_tags
}
