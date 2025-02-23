variable "env" {
  description = "Which Environment"
  default     = "Staging"
}
variable "aws_region" {
  description = "aws region"
  default     = "ap-south-1"
}

variable "az_1" {
  description = "availibilty zone"
  default = "ap-south-1a"
}

variable "az_2" {
  description = "availibilty zone"
  default = "ap-south-1b"
}


variable "cluster_name" {
  description = "cluster name"
  default     = "amllan-eks"

}
variable "vpc_name" {
  description = "vpc name"
  default = "amllan-eks-vpc"
  
}
variable "eks_version" {
  description = "eks versions"
  default     = "1.31"
}

variable "cidr_range" {
  description = "vpc cidr range"
  default     = "10.0.0.0/16"
}

variable "private_sb_1" {
  description = "private subnet 1 CIDR"
  default     = "10.0.1.0/24"
}
variable "private_sb_2" {
  description = "private subnet 2 CIDR"
  default     = "10.0.2.0/24"
}
variable "public_sb_1" {
  description = "public subnet 1 CIDR"
  default     = "10.0.4.0/24"
}
variable "public_sb_2" {
  description = "public subnet 2 CIDR"
  default     = "10.0.5.0/24"
}
