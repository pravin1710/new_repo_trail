resource "aws_ecs_cluster" "aws-ecs-cluster" {
  name = "${var.app_name}-${var.app_environment}-cluster"
  
  tags = {
    Name        = "${var.app_name}-ecs"
    Environment = var.app_environment
  }
  depends_on = [ aws_vpc.aws-vpc ]
}

resource "aws_cloudwatch_log_group" "log-group" {   ##Log Group on CloudWatch to get the containers logs
  name = "${var.app_name}-${var.app_environment}-logs"

  tags = {
    Application = var.app_name
    Environment = var.app_environment
  }
}





resource "aws_ecs_task_definition" "aws-ecs-task-1" {
  family = "${var.app_name}-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  memory                   = "1024"
  cpu                      = "512"
  execution_role_arn       = aws_iam_role.ecsTaskExecutionRole.arn
  task_role_arn            = aws_iam_role.ecsTaskExecutionRole.arn
  
  runtime_platform {
   operating_system_family = "LINUX"
   
  }
  
container_definitions = jsonencode([
   {
     name      = "${var.app_name}-${var.app_environment}-container-1"
     image     =  "590183913538.dkr.ecr.eu-north-1.amazonaws.com/nginx"
     cpu       = 512
     memory    = 1024
     essential = true
     portMappings = [
       {
         containerPort = 80
         hostPort      = 80
         protocol      = "tcp"
       }
     ]
     logConfiguration = {
     logDriver = "awslogs"
     options = {
        "awslogs-create-group"  = "true",
        "awslogs-group"         = "${aws_cloudwatch_log_group.log-group.name}"
        "awslogs-region"        = "${var.aws_region}"
        "awslogs-stream-prefix" = "ecs"
     }
    }
     healthCheck = {
     command     = ["CMD-SHELL", "curl -f http://localhost/ || exit 1"]
     interval    = 30
     timeout     = 5
     retries     = 3
     startPeriod = 60
    }

   }
 ])
 
}






resource "aws_ecs_task_definition" "aws-ecs-task-2" {
  family = "${var.app_name}-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  memory                   = "1024"
  cpu                      = "512"
  execution_role_arn       = aws_iam_role.ecsTaskExecutionRole.arn
  task_role_arn            = aws_iam_role.ecsTaskExecutionRole.arn
  
  runtime_platform {
   operating_system_family = "LINUX"
   
  }
  
container_definitions = jsonencode([
   {
     name      = "${var.app_name}-${var.app_environment}-container-2"
     image     =  "590183913538.dkr.ecr.eu-north-1.amazonaws.com/nginx"
     cpu       = 512
     memory    = 1024
     essential = true
     portMappings = [
       {
         containerPort = 80
         hostPort      = 80
         protocol      = "tcp"
       }
     ]
     logConfiguration = {
     logDriver = "awslogs"
     options = {
        "awslogs-create-group"  = "true",
        "awslogs-group"         = "${aws_cloudwatch_log_group.log-group.name}"
        "awslogs-region"        = "${var.aws_region}"
        "awslogs-stream-prefix" = "ecs"
     }
    }
     healthCheck = {
     command     = ["CMD-SHELL", "curl -f http://localhost/ || exit 1"]
     interval    = 30
     timeout     = 5
     retries     = 3
     startPeriod = 60
    }

   }
 ])
 
}



