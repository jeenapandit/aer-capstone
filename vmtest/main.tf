resource "aws_instance" "vm" {  
  ami           = "ami-0f88e80871fd81e91"
  instance_type = "t2.micro"

  tags = {
    Name = "${var.project}-vm"
	Project = var.project
  }
}