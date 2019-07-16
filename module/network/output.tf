output "vpc_id" {
  value = aws_vpc.default.id
}

output "cluster_subnet_ids" {
  value = aws_subnet.cluster.*.id
}

output "gateway_subnet_ids" {
  value = aws_subnet.gateway.*.id
}