module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "isucon-11q"
  cidr = "10.0.0.0/16"

  azs            = ["ap-northeast-1a"]
  public_subnets = ["10.0.101.0/24"]

  tags = {
    Terraform = "true"
  }
}

module "aws_isucon_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "aws-isucon"
  description = "aws-isucon"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["ssh-tcp", "http-80-tcp"]
  egress_rules        = ["all-all"]
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  for_each = toset(["1", "2", "3", "4"])

  name = "isucon11q-${each.key}"

  ami                    = "ami-00acaccebe03b5bed" # isucon11q (https://github.com/matsuu/aws-isucon)
  instance_type          = "t2.micro"
  vpc_security_group_ids = [module.aws_isucon_sg.security_group_id]
  subnet_id              = module.vpc.public_subnets[0]

  tags = {
    Terraform = "true"
  }
}