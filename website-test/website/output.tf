output "load_balancer_address" {
  value       = module.load-balancer.load_balancer_address
  description = "The DNS name for the Load Balancer."
}

output "load_balancer_id" {
  value       = module.load-balancer.load_balancer_id
  description = "The id of the Load Balancer."
}