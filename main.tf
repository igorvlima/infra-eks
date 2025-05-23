provider "aws" {
  region = "us-east-1" 
}


resource "aws_security_group" "eks_sg" {
vpc_id = var.vpc_id
name   = "eks_sg"

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_eks_cluster" "eks_cluster" {
  name     = "eks-cluster"
  role_arn = aws_iam_role.eks_role.arn

  vpc_config {
    subnet_ids = [var.subnet1,var.subnet2]
    security_group_ids = [aws_security_group.eks_sg.id]
  }
}

resource "aws_iam_role" "eks_role" {
  name = "my-eks-role"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement": [{
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }]
  })
}