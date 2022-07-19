resource "aws_ecs_task_definition" "test-http" {
  family                = "test-http"
  container_definitions = file("td.json")
}

resource "aws_ecs_service" "test-http" {
  name            = "test-http"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.test-http.arn
  iam_role        = aws_iam_role.ecs_service_role.arn
  desired_count   = 2
  depends_on      = [aws_iam_role_policy.ecs_service_role_policy]

  load_balancer {
    target_group_arn = "arn:aws:elasticloadbalancing:us-east-1:733816228796:targetgroup/tg-default/91691ab6409026a2"
    container_name   = "nginx"
    container_port   = 80
  }
}
