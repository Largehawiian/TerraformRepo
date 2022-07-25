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
        private_key = <<EOT
        -----BEGIN RSA PRIVATE KEY-----
MIIEpAIBAAKCAQEAn/UTDcFnypHoxewSW0Q2/sykYkr+D0H1elDcmH3UYoJJilba
iY1985ZB3hN4pmufvp5B++KbkIGniCwj7dFw3raSYHhKmqHCib8ukBl5cp6R7pJo
pgXZ/J2Tuz8wGacD3vvouO2sMj3XTg4VF2i6wEsMP7DqqMBJZJLbKJldcOxyptrx
SS8oCbbfsZCmllq5NANeFhZXJibmE+zi4O/4tVVKu0g8pNsBAEkMHFglfNJxuiL2
8jhdatun6tycyYHKezAjG8sFsGejObOG9UV9INQcmyKDPhPGO4/RIzKapBkoiYwG
w8bT7Aqe1RQChEPvcdl1n9VhWEOqNVWsEmb4iQIDAQABAoIBAB0RpqLLURdpKMo/
Op7HaM8pVX5fbohLTlcqNsynoV89miu/2PtCcW9BETtQgo6L5H35uLgT2H2Mcmu2
ydjARSjUOQm7EqPDXd02lzmsx3tjAdY/WTFCwvi7kktnElC3H2b4lLR2zOJchrIy
sPaOG9IyUUmJ1ztPpobWgWmBZY/NvZFvjDe2I8ESsq1W6UYSLY7rv/SPVudv+gXk
5fJ+6hzLlnd+5sKzU8hhy/XEFZ+ayxbGfcORTe+iRIqjDVcQuqCQ2Q6XHkCWdY/K
PgLb2PF125aJgN0kHXwLeM2DZKsXak4GJQxHcpJkKOh4RGRO0f26yt1gfnzskBRw
BIipfQECgYEA9qV+MpUBPx8PNx9us1RNWjGnn813An/wLiIse5Ia8M3hdnBeeYqi
USSHytzH1NNWSB/gD/5LPbaU9e+EGt/oqcxMkg4udHsBEgHSgBuaZGrjn8Se7XmX
bZqskCMtDfmuyyn55IR/aMlstGdzBPeN6TKYhMlXUkbbWbqsXMNR6hECgYEApgX7
KstXv+wFVkn2eZ7rofZsGnIUOsDOGD4flbTIow7WP0TogoqXz7g2Q4k+/iw0syJJ
rs7NwKKabyhHLvDnoeFpklrb9UAh9BZ7D5isAOjdP73xm2KfHGW20/VmL15ztNM+
qz6Jmng8QnTTZeovrVV2UghUnssDArC9UmO3bvkCgYAKP3gN2/kQSVcVgD3WP6Nz
IusHDb9rICu3jv3wKHLsHHHIvQR/4k26N11ZBXFcG2fTWVey8mrn5oUr7sa7YyBE
pdNsoiA2AMJboC3B2uPAVlycz8uWrF2pVSrkVkHR+dTUZisW3pZ4oR3eJQo3Y53G
2a5Snhb9uSn2AXaV6BuoMQKBgQCX/S/ELKXnqI32Qf3nt4pmGq86wqcsZmgGn5DQ
v9FSHXocL9xf7bsvSag7ycCmdhfEyqYD54VLTlDtZEVOfvK/Kxo4BwAJFK5Aw/fi
/lSw/H3YJe6y3uVk3OU0RBtJUEHDEAT2Rmk4xcv81vDVA0CkgXGxhbjaKmZWJzEa
5PkAGQKBgQCGJdxldCCb8U8Vlq7LxZT3pXrMfrjZnWp/XnwDrq5fKXLqrMj7gMQV
JXQpi4aZNOnSW4DKzIXUuS3OKK7yf/B4PSYYpO7ceR+qo56lEHx+LXMUEc9L84W+
+rCfpmOyRmHetBTFe7DFqCEqrGZc86gwuACnjEVnusz1+hOj7Vi+Ow==
EOT
    }
}
}