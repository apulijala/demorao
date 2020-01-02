output "publicdns" {
  value = aws_instance.web.public_dns
}


output "publicip" {
  value = aws_instance.web.public_ip 
}
