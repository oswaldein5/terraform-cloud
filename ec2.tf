variable "instances" {
  description = "Name of each instance"
  #type        = list(string)
  type    = set(string)
  default = ["apache"]
}

#* Create resource
resource "aws_instance" "public_instance" {
  #count                  = length(var.instances) # var.type = list
  #for_each = toset(var.instances) # convert list to set
  for_each               = var.instances # var.type = set or map
  ami                    = var.ec2_specs.ami
  instance_type          = var.ec2_specs.instance_type
  subnet_id              = aws_subnet.public_subnet.id
  key_name               = data.aws_key_pair.key.key_name
  vpc_security_group_ids = [aws_security_group.sg_public_instance.id]
  user_data              = file("scripts/userdata.sh")

  tags = {
    # "Name" = var.instances[count.index] # list
    "Name" = "${each.value} - ${local.sufix}"
  }
}

resource "aws_instance" "monitoring_instance" {
  count                  = var.enable_monitoring == 1 ? 1 : 0 # evaluate condition
  ami                    = var.ec2_specs.ami
  instance_type          = var.ec2_specs.instance_type
  subnet_id              = aws_subnet.public_subnet.id
  key_name               = data.aws_key_pair.key.key_name
  vpc_security_group_ids = [aws_security_group.sg_public_instance.id]
  user_data              = file("scripts/userdata.sh")

  tags = {
    # "Name" = var.instances[count.index] # list
    "Name" = "Monitoring - ${local.sufix}"
  }
}
