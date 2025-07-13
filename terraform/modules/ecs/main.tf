resource "aws_ecs_cluster" "medusa" {
  name = "medusa-cluster"

  tags = {
    Name = "Medusa ECS Cluster"
  }
}

resource "aws_ecs_task_definition" "medusa" {
  family                   = "medusa-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "512"
  memory                   = "1024"
  execution_role_arn       = var.task_exec_role_arn
  task_role_arn            = var.task_role_arn

  container_definitions = jsonencode([
    {
      name  = "medusa-container"
      image = "docker.io/itsjatinsharma/medusa-app:latest"

      portMappings = [
        {
          containerPort = 9000
          hostPort      = 9000
          protocol      = "tcp"
        }
      ]

      environment = [
        { name = "DATABASE_URL", value = var.db_endpoint },
        { name = "REDIS_URL", value = var.redis_endpoint },
      
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/medusa"
          awslogs-region        = "us-east-1"
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])
}

resource "aws_ecs_service" "medusa-service" {
  name            = "medusa-service"
  cluster         = aws_ecs_cluster.medusa.id
  task_definition = aws_ecs_task_definition.medusa.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = var.public_subnet_ids
    security_groups = var.security_groups
    assign_public_ip = true
  }
} 
