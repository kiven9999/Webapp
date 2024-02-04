resource "aws_ecs_cluster" "web_app" {
  name = "webapp"
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecs-task-execution-role"

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement": [{
      "Effect"   : "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action"   : "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_ecs_task_definition" "webapp-task" {
  family                   = "webapp-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  cpu                      = "512"  
  memory                   = "1024"  

  container_definitions = jsonencode([
    {
      "name": "my-container",
      "image": "178695293962.dkr.ecr.us-east-2.amazonaws.com/webapp24",
      "portMappings": [
        {
          "containerPort": 80,
          "hostPort": 80
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "webapp-service" {
  name            = "webapp-service"
  cluster         = aws_ecs_cluster.web_app.id
  task_definition = aws_ecs_task_definition.webapp-task.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    security_groups = [data.aws_security_group.lb_sg.id]
    subnets         = [data.aws_subnet.east_2a.id, data.aws_subnet.east_2b.id, data.aws_subnet.east_2c.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.my_target_group.arn
    container_name   = "my-container"
    container_port   = 80
  }

  depends_on = [aws_lb_listener.my_lb_listener]
}