# create and define the container task
resource "aws_ecs_task_definition" "task_definition" {
  family = var.ecs_task_definition_name
  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn = aws_iam_role.ecs_task_role.arn
  requires_compatibilities = [
    "FARGATE"]
  network_mode = "awsvpc"
  cpu = 256
  memory = 512
  container_definitions = data.template_file.task_definition_template.rendered
}