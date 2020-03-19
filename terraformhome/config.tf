provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "web" {
  ami = "ami-0d1cd67c26f5fca19"
  instance_type = "t2.micro"
  security_groups = ["allow-all"]
  key_name = "aws-home"  
  
  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = "${file("/home/lpv_mail/aws-home.pem")}"
    agent = false
  }


  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install nginx -y"
    ]
  }

  provisioner "file" {
    source = "index.html"
    destination = "/tmp/index.html"
  }

  provisioner "remote-exec" {
    inline = ["sudo mv /tmp/index.html /var/www/html/"]
  }

}

