data "aws_ami" "app" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-*-x86_64-gp2"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  owners = ["amazon"]
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.app.id
  instance_type = var.instance_size

  tags = {
    Name = "Web01"
  }
}

resource "aws_eip" "addr" {
  # instance = aws_instance.web.id
  vpc = true


  tags = {
    Name        = var.infra_name
    Project     = var.project
    }
}

resource "aws_eip_association" "eip_assoc" {
  count = (var.create_eip) ? 1 : 0 
  instance_id   = aws_instance.web.id
  allocation_id = aws_eip.addr.id
}