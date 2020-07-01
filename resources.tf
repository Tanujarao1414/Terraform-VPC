# Define SSH key pair for our instances
resource "aws_key_pair" "default" {
  key_name = "mykey"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDAhJfJnnpGxCtsWre+JHdFwMJLd4xdVc4CtskkGAu8JYS3TBEgLlP8rItCYLT1bFw5C4Y5RsU6jbrwVbbGdy0WB6+EaVrBE8hr7UuM85nfsiaOTyAfJrjbypARz1rbMqtUwlEX8TFh12jxG0T9JM4XE0g5yWqTLGqd/QIZb4pHgctQCY/FAs2f0RYOtlbqJgWhAfkCMDJPPEZaRljP2PUtBnE7/Y02vhAw25ixuIcHMm1XRqVlVLhVL3xg4iqMsW7v2qwZAQ5xBoWJ/TMrhY2uz0bq9yTdeEGfI0g2aVWbsS0si2aJjJ9Wa1icX8lLVc7W87YerwwnCrDnnizrmoX5 hp@LAPTOP-VV2BGDTF"
}

# Define webserver inside the public subnet
resource "aws_instance" "wb" {
   ami  = "${var.ami}"
   instance_type = "t1.micro"
   key_name = "${aws_key_pair.default.id}"
   subnet_id = "${aws_subnet.public-subnet.id}"
   vpc_security_group_ids = ["${aws_security_group.sgweb.id}"]
   iam_instance_profile = "${aws_iam_instance_profile.ec2-role.name}"
   associate_public_ip_address = true

   source_dest_check = false
   user_data = "${file("userdata.sh")}"

  tags={
    "Name" : "webserver"
  }
}

# Define database inside the private subnet
resource "aws_instance" "db" {
   ami  = "${var.ami}"
   instance_type = "t1.micro"
   key_name = "${aws_key_pair.default.id}"
   subnet_id = "${aws_subnet.private-subnet.id}"
   vpc_security_group_ids = ["${aws_security_group.sgdb.id}"]
   source_dest_check = false

  tags={
    "Name" = "database"
  }
}