
resource "aws_iam_role" "ecs_task_role" {
  name               = "${var.app_name}-ecs-task-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_assume_role_policy.json
}

data "aws_iam_policy_document" "ecs_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_ecs_cluster" "app_cluster" {
  name = "${var.app_name}-cluster-${substr(md5(timestamp()), 0, 8)}"
}

resource "aws_ecs_task_definition" "app_task" {
  family                   = "${var.app_name}-task-${substr(md5(timestamp()), 0, 8)}"
  requires_compatibilities = ["FARGATE"]
  network_mode            = "awsvpc"
  execution_role_arn      = aws_iam_role.ecs_task_role.arn

  container_definitions    = jsonencode([{
    name      = "${var.app_name}-container"
    image     = "node:14"
    essential = true
    portMappings = [{
      containerPort = 3000
      hostPort      = 3000
      protocol      = "tcp"
    }]
  }])
}

resource "aws_ecs_service" "app_service" {
  name            = "${var.app_name}-service-${substr(md5(timestamp()), 0, 8)}"
  cluster         = aws_ecs_cluster.app_cluster.id
  task_definition = aws_ecs_task_definition.app_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.subnets
    security_groups  = [var.security_group]
    assign_public_ip = true
  }
}

output "service_name" {
  value = aws_ecs_service.app_service.name
}
