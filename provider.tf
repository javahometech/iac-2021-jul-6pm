# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket         = "javahome-2021-july-05"
    key            = "terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "javahome-iac"
  }
}

# create vpc
resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = var.tenancy
  tags             = local.tags
}
# We want this in prod and we don't want it in dev

resource "aws_subnet" "main" {
  # If current workspace is dev return 0 or return 1
  count             = local.az_count
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 4, count.index)
  tags              = local.tags
  availability_zone = local.az_names[count.index]
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "myapp-ig-${terraform.workspace}"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "public-rt-${terraform.workspace}"
  }
}

# attach this route table to public subnets

resource "aws_route_table_association" "public" {
  count          = local.pub_sub_count
  subnet_id      = local.pub_sub_ids[count.index]
  route_table_id = aws_route_table.public.id
}