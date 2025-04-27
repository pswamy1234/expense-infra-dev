resource "aws_key_pair" "vpn" {
  key_name   = "vpn"
  # you can paste the public key directly like this
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDTXCFYut1iE2xw/HngEasSG/Rzz9KCEp6HI1ds4YH9HZvdxk6/rS8w9ISQjYmJQcbz1DDOQg/Dq4nMm8+UMf1FS/2SE839BLV4gqWbQ40jvPfvtlanNp+J0atv4I2VE4pCOQglQEUQ9pPo/Ng8H/qwP95u23/aMYzZlKmlgBXhTs08z41rjLyog8XhNkOhqlZDeWfPfxPd0Jmn/jqkGOtDOjUp4rjmrJmGnkgODFyVCvKQMuIdp2NOOMFpFzYWYs8pz3ImEIvfQMkI13wEUVpF5ir6ADnIOJIVHYQB5nIdATuckZzuLV4lVcOrDXA3KFU/u1cIMUkZ2yliv1vMT+f0IwsFpZNnvPtOb5V10C2P54nZ+J9TE7S7lMtBkNqeQ/MY4qNHk00/kq8weY0xxcAMxCMglAzP7c/B81vDSpooG+vI9cKZNdqYeagFWR3v7+hLYh06u4CzMXd6xgJ0Pgt6StsAaxFBG12uxUyoUf/BFMfBKYtmD4RvKd87BVN/C8pCW1I4GMbdwf45HQkSes1gl3ZfQKsRTIenCWNRiKukOQc3xeaTUovCF6hkreQN7l/cotJszssk0y16zgl8CPjMvuSVMSoR2I+mlMn62wGaxC4f2EIeJKk6GusCbStdWMhjiowKQy8OKCyeTAv1fZT009AERK3xwfDLzAJDNIeeJw== SAMSUNG@Swamy"
  #public_key = file("~/.ssh/vpn.pub")
  # ~ means windows home directory
}


module "vpn" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  key_name = aws_key_pair.vpn.key_name
  name = "${var.project_name}-${var.environment}-vpn"

  instance_type          = "t3.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.vpn_sg_id.value]
  # convert StringList to list and get first element
  subnet_id = local.public_subnet_id
  ami = data.aws_ami.ami_info.id
  
  tags = merge(
    var.common_tags,
    {
        Name = "${var.project_name}-${var.environment}-vpn"
    }
  )
}