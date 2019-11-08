

  #-------------
  # Role


resource "aws_iam_role" "demo-cluster" {
  name = "terraform-eks-demo-cluster"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "demo-cluster-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = "${aws_iam_role.demo-cluster.name}"
}

resource "aws_iam_role_policy_attachment" "demo-cluster-AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = "${aws_iam_role.demo-cluster.name}"
}

  #-------------
  # EKS Master Cluster Security Group



resource "aws_security_group" "demo-cluster" {
  name        = "terraform-eks-demo-cluster"
  description = "Cluster communication with worker nodes"
  vpc_id      = "${var.id_vpc}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terraform-eks-demo"
  }
}


resource "aws_security_group_rule" "demo-cluster-ingress-workstation-https" {
  cidr_blocks = ["0.0.0.0/0"]
  description       = "Allow workstation to communicate with the cluster API Server"
  from_port         = 443
  protocol          = "tcp"
  security_group_id = "${aws_security_group.demo-cluster.id}"
  to_port           = 443
  type              = "ingress"
}


  #-------------
  # EKS Master Cluster

resource "aws_eks_cluster" "demo" {
  name            = "${var.cluster-name}"
  role_arn        = "${aws_iam_role.demo-cluster.arn}"

  vpc_config {
    security_group_ids = ["${aws_security_group.demo-cluster.id}"]
    subnet_ids         = "${var.public_subnet_ids.*.id}"
  }

  depends_on = [
    "aws_iam_role_policy_attachment.demo-cluster-AmazonEKSClusterPolicy",
    "aws_iam_role_policy_attachment.demo-cluster-AmazonEKSServicePolicy",
  ]
}



locals {
  kubeconfig = <<KUBECONFIG


apiVersion: v1
clusters:
- cluster:
    server: ${aws_eks_cluster.demo.endpoint}
    certificate-authority-data: ${aws_eks_cluster.demo.certificate_authority.0.data}
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: aws
  name: aws
current-context: aws
kind: Config
preferences: {}
users:
- name: aws
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1alpha1
      command: aws-iam-authenticator
      args:
        - "token"
        - "-i"
        - "${var.cluster-name}"
KUBECONFIG



  demo-node-userdata = <<USERDATA
#!/bin/bash
set -o xtrace
/etc/eks/bootstrap.sh --apiserver-endpoint '${aws_eks_cluster.demo.endpoint}' --b64-cluster-ca '${aws_eks_cluster.demo.certificate_authority.0.data}' '${var.cluster-name}'
USERDATA
}


