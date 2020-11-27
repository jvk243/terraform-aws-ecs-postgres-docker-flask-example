# create and define the container task
resource "aws_ecs_task_definition" "task_definition" {
  family = "flask-app"
  requires_compatibilities = [
    "FARGATE"]
  network_mode = "awsvpc"
  cpu = 256
  memory = 512
  container_definitions = data.template_file.task_definition_template.rendered
}