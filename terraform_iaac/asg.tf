provider "aws" {
  region     = "us-east-2"
}

resource "aws_launch_template" "arquichat-lt" {
  name = "arquichat-lt"

  disable_api_termination = false

  ebs_optimized = false

  iam_instance_profile {
    arn = "arn:aws:iam::780722053658:instance-profile/backend-role"
  }

  image_id = "ami-062d56f8de395a822"

  key_name = "frontendKey"

  instance_initiated_shutdown_behavior = "terminate"

  instance_type = "t2.micro"

  vpc_security_group_ids = ["sg-0616e30f428cf3ac1"]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "arquichat"
    }
  }

  user_data = base64encode(<<USER_DATA
    #!/bin/bash
    sudo apt-get update -y

    # INSTALL AMAZON CLI
    sudo apt  install awscli -y

    # INSTALL DOCKER
    sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"
    sudo apt-get update
    sudo apt-get install -y docker-ce
    sudo usermod -aG docker ubuntu

    # INSTALL DOCKER-COMPOSE
    sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/bin/docker-compose
    sudo chmod +x /usr/bin/docker-compose
    sudo apt-get install ruby -y
    sudo apt-get install wget -y

    # ENABLE DOCKER BOOT SERVICE
    sudo systemctl enable docker_boot
    sudo systemctl start docker_boot
    
    # INSTALL CODEDEPLOY AGENT
    cd /home/ubuntu
    wget https://aws-codedeploy-us-east-1.s3.us-east-1.amazonaws.com/latest/install
    sudo chmod +x ./install
    sudo ./install auto
    sudo service codedeploy-agent start
    USER_DATA
    )
}

resource "aws_autoscaling_group" "arquichat-asg" {
  name                      = "arquichat-asg"
  max_size                  = 1
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "EC2"
  desired_capacity          = 1
  force_delete              = false
  
  launch_template {
        id      = aws_launch_template.arquichat-lt.id
        version = "$Latest"
  }
  
  vpc_zone_identifier       = [aws_subnet.arquichat-sn1.id, aws_subnet.arquichat-sn2.id, aws_subnet.arquichat-sn3.id]
  
  target_group_arns=  [
              "arn:aws:elasticloadbalancing:us-east-2:780722053658:targetgroup/arquichat-tg/543ae42f3701dda4"
            ]

  tag {
    key                 = "name"
    value               = "arquichat"
    propagate_at_launch = true
  }
}