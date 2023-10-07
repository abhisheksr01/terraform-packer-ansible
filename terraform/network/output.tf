output "vpc_id" {
  value = aws_vpc.vpc.id
}
output "public_subnets" {
  value = aws_subnet.subnet_public.id
}
output "ec2keyName" {
  value = aws_key_pair.ec2key.key_name
}
output "security_group_ids" {
  value = [aws_security_group.sg_22.id, aws_security_group.sg_80.id]
}
