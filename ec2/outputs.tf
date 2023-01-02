output "app_eip" {
  value = aws_eip.addr.public_ip
}
 
output "app_instance" {
    value = aws_instance.web.id
}