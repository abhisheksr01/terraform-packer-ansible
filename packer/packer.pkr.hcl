packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "~> 1"
    }
    ansible = {
      source  = "github.com/hashicorp/ansible"
      version = "~> 1"
    }
  }
}

variable "base_ami" {
  type    = string
  default = "ami-042fab99b38a3963d"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "ssh_username" {
  type    = string
  default = "ec2-user"
}

variable "subnet_id" {
  type    = string
  default = "subnet-07dbff755e3736579"
}

locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }

source "amazon-ebs" "autogenerated_1" {
  ami_name                    = "packer-base-${local.timestamp}"
  associate_public_ip_address = true
  instance_type               = "${var.instance_type}"
  source_ami                  = "${var.base_ami}"
  ssh_username                = "${var.ssh_username}"
  subnet_id                   = "${var.subnet_id}"
  tags = {
    Name = "Packer-Ansible"
  }
}

build {
  sources = ["source.amazon-ebs.autogenerated_1"]

  provisioner "ansible" {
    playbook_file = "../ansible/playbook.yml"
    extra_arguments = [ "--scp-extra-args", "'-O'" ]
  }

}