terraform {
    required_version = ">=0.12.13"
}

resource "aws_instance" "remote_ec2instance" {
    ami = "ami-092b43193629811af"
    vpc_security_group_ids = ["sg-0901b34801c8d83a2"]
    instance_type = "t2.micro"
    key_name = "ubuntu"
    tags = {
        Name = "remote_ec2instance"
    }

    provisioner "remote-exec" {
        inline = [
            "sudo dnf install -y httpd",
            "sudo systemctl start httpd",
            "sudo dnf install -y git",
            "sudo git clone https://github.com/Largehawiian/DummyWebsite/ /var/www/html"
        ]
    
    data "github_actions_public_key" "UBUNTU" {
    repository = "TerraformRepo"
}

    connection {
        type = "ssh"
        host = self.public_ip
        user = "ec2-user"
        private_key = "UBUNTU"
    }
}
}