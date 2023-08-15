resource "aws_ecr_repository" "enumV2-repo" {
  name                 = "enumversiontwo_repo"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}