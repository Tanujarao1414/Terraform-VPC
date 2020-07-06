# Define SSH key pair for our instances
resource "aws_key_pair" "default" {
  key_name = "mykey"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDxv/GOo8awUFahN4v76hT8jb6vGRit2+yzBnQyJl5ThHwUmz4o1Xr8GzTZ+jM49llENM9JU65iwZbRa037JG2WzCtcnaUPeNdmDtOOIkARk2h3C0Bh9N0IPJm2lnQv/Gxlxe6dtAjGwZLSenO/ynK9i/b9ISIR72g9XeiDxAmsM3uRZbpfkJZT/zko3sJuWo6ht/RDJh1RpNDRDIWiOTNNFWaQyWgwxpSbyfuQRq1drgzbK1IIbxftJcGQHOCDio3DXaMsaXq7RekGKdtaUf0DsUoWzkTs1yyvdN/yIZ7UJNNK0pQbwRFKOMqOdutiKKxfeLVd1GcM6vHxm6Z3JkMP hp@LAPTOP-VV2BGDTF"
}

# Define webserver inside the public subnet
resource "aws_instance" "wb" {
   ami  = "${var.ami}"
   instance_type = "t1.micro"
   key_name = "${aws_key_pair.default.id}"
   subnet_id = "${aws_subnet.public-subnet1.id}"
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

#EC2 instance for index1.html
resource "aws_instance" "ec2-user" {
   ami  = "${var.ami}"
   instance_type = "t1.micro"
   key_name = "${aws_key_pair.default.id}"
   subnet_id = "${aws_subnet.public-subnet1.id}"
   vpc_security_group_ids = ["${aws_security_group.sgweb.id}"]
   iam_instance_profile = "${aws_iam_instance_profile.ec2-role.name}"
   associate_public_ip_address = true

   source_dest_check = false
   user_data = "${file("userdata.sh")}"

  tags={
    "Name" : "ec2-1"
  }
}

resource "aws_instance" "ec2-user2" {
   ami  = "${var.ami}"
   instance_type = "t1.micro"
   key_name = "${aws_key_pair.default.id}"
   subnet_id = "${aws_subnet.public-subnet2.id}"
   vpc_security_group_ids = ["${aws_security_group.sgweb.id}"]
   iam_instance_profile = "${aws_iam_instance_profile.ec2-role.name}"
   associate_public_ip_address = true

   source_dest_check = false
   user_data = "${file("userdata.sh")}"

  tags={
    "Name" : "ec2-2"
  }
}