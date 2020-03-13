provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "web" {
  ami = "ami-0d1cd67c26f5fca19"
  instance_type = "t2.micro"

  provisioner "local-exec" {
    command = "apt-get update && apt-get install nginx -y"
}
  provisioner "file" {
    source = "index.html"
    destination = "/var/www/html/"
}
}

