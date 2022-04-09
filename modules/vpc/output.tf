output "shared_services_public_rt_id" {
  value = aws_route_table.shared_services_public_rt.id
}

output "shared_services_private_rt_id" {
  value = aws_route_table.shared_services_private_rt.id
}
