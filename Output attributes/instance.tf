resource "aws_instance" "instance1" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"
  provisioner "local-exec" {
      command = "echo ${aws_instance.instance1.private_ip} >> private_ips.txt"
  }
}

output "ip" {
  value       = aws_instance.instance1.public_ip
}
