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

    connection {
        type = "ssh"
        host = self.public_ip
        user = "ec2-user"
        private_key = file("ubuntu.pem")
    }
}

}
resource "aws_lb" "lb_test_terraform" {
    name               = "test-lb-terraform"
    internal           = false
    load_balancer_type = "application"
    security_groups    = ["sg-0901b34801c8d83a2"]
    subnets            = ["subnet-4047933d", "subnet-8b437cc7"]

    enable_deletion_protection = false

#access_logs {
#    bucket  = "terraforms3bucketjjackson"
#    prefix  = "test-lb"
#    enabled = true
#}

tags = {
    Environment = "production"
}
}



resource "aws_lb_target_group_attachment" "remote_ec2instance" {
    target_group_arn = aws_lb_target_group.test.arn
    target_id        = aws_instance.remote_ec2instance.id
    port             = 80
}
resource "aws_lb_listener" "front_end" {
    load_balancer_arn = aws_lb.lb_test_terraform.arn
    port              = "80"
    protocol          = "HTTP"
default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.test.arn
}
}
resource "aws_lb_target_group" "test" {
    name     = "tf-example-lb-tg"
    port     = 80
    protocol = "HTTP"
    vpc_id   = "vpc-21a4d24a"
}