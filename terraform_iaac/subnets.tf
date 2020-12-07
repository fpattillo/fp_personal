resource "aws_subnet" "arquichat-sn1" {
    vpc_id                  = "vpc-fff15a94"
    cidr_block              = "172.31.48.0/20"
    availability_zone       = "us-east-2b"
    map_public_ip_on_launch = true
}
resource "aws_subnet" "arquichat-sn2" {
    vpc_id                  = "vpc-fff15a94"
    cidr_block              = "172.31.64.0/20"
    availability_zone       = "us-east-2c"
    map_public_ip_on_launch = true
}
resource "aws_subnet" "arquichat-sn3" {
    vpc_id                  = "vpc-fff15a94"
    cidr_block              = "172.31.80.0/20"
    availability_zone       = "us-east-2a"
    map_public_ip_on_launch = true
}