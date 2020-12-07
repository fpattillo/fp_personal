resource "aws_codedeploy_app" "arquichat-cd" {
  name = "arquichat-cd"
}

resource "aws_codedeploy_deployment_group" "arquichat-dgroup" {
  app_name              = aws_codedeploy_app.arquichat-cd.name
  deployment_group_name = "arquichat-dgroup"
  service_role_arn      = "arn:aws:iam::780722053658:role/dpl-service-role"
  autoscaling_groups = [ aws_autoscaling_group.arquichat-asg.name ]
  deployment_config_name = "CodeDeployDefault.AllAtOnce"

  load_balancer_info {
    target_group_info {
      name = "arquichat-tg"
    }
  }
}