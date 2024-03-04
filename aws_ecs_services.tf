
resource "aws_ecs_service" "aws-ecs-service-1" {
  name                 = "${var.app_name}-${var.app_environment}-ecs-service-1"
  cluster              = aws_ecs_cluster.aws-ecs-cluster.id
  task_definition      = aws_ecs_task_definition.aws-ecs-task-1.arn
  deployment_maximum_percent = 200
  deployment_minimum_healthy_percent = 100
  launch_type          = "FARGATE"
  scheduling_strategy  = "REPLICA"
  desired_count        = 2
  force_new_deployment = true

  network_configuration {
    subnets          = aws_subnet.private.*.id
    assign_public_ip = false
    security_groups = [
      aws_security_group.service_security_group.id,
      aws_security_group.load_balancer_security_group.id
    ]
  }

  

  load_balancer {
    target_group_arn = aws_lb_target_group.target_group_1.arn
    container_name   = "${var.app_name}-${var.app_environment}-container-1"
    container_port   = 80
  }

  depends_on = [ aws_lb_target_group.target_group_1 ]

}


# resource "aws_ecs_service" "aws-ecs-service-2" {
#   name                 = "${var.app_name}-${var.app_environment}-ecs-service-2"
#   cluster              = aws_ecs_cluster.aws-ecs-cluster.id
#   task_definition      = aws_ecs_task_definition.aws-ecs-task-2.arn
#   deployment_maximum_percent = 200
#   deployment_minimum_healthy_percent = 100
#   launch_type          = "FARGATE"
#   scheduling_strategy  = "REPLICA"
#   desired_count        = 2
#   force_new_deployment = true

#   network_configuration {
#     subnets          = aws_subnet.private.*.id
#     assign_public_ip = false
#     security_groups = [
#       aws_security_group.service_security_group.id,
#       aws_security_group.load_balancer_security_group.id
#     ]
#   }

  

#   load_balancer {
#     target_group_arn = aws_lb_target_group.target_group_2.arn
#     container_name   = "${var.app_name}-${var.app_environment}-container-2"
#     container_port   = 80
#   }

#   depends_on = [ aws_lb_target_group.target_group_2 ]

# }

