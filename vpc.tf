data "aws_vpc" "ecs_vpc" {
  id = "vpc-0bca07ad1242332da"
}

data "aws_subnet" "east_2a" {
  id = "subnet-017402b49d8c23fe4"
}

data "aws_subnet" "east_2b" {
  id = "subnet-0ff9b2a41099b7c06"
}

data "aws_subnet" "east_2c" {
  id = "subnet-043a89d8a4ad74b3c"
}

data "aws_security_group" "lb_sg" {
  vpc_id = data.aws_vpc.ecs_vpc.id
  id     = "sg-022d8552476b100bd"
}