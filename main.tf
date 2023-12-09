provider "aws" {
  region = "us-east-1"
}

# Create an ECS cluster
resource "aws_ecs_cluster" "cluster" {
  name = "node-cluster"
}

resource "aws_security_group" "sg" {
  name        = "ecs_sg"
  description = "Allow Jenkins traffic"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create task definition
resource "aws_ecs_task_definition" "task" {
  family                   = "my-node-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  container_definitions    = jsonencode([{
    name  = "my-container",
    image = "arishak/node-image:latest", # Specify your Docker image
    portMappings = [{
      containerPort = 3000,
      hostPort      = 3000
    }]
  }])
}

# Create an ECS service
resource "aws_ecs_service" "service" {
  name            = "my-service"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.task.arn
  launch_type     = "FARGATE"

  network_configuration {
    subnets = ["subnet-0f138c54611ff6123", "subnet-0f4f89687422670f3"] # Specify your subnet IDs
    security_groups = [aws_security_group.sg.id]
  }
}