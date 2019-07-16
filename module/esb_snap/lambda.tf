resource "aws_lambda_function" "ebs_snapshot" {
  filename         = data.archive_file.lambda_zip.output_path
  function_name    = "EBSDailySnapshot"
  role             = aws_iam_role.lambda.arn
  handler          = "ebs_snap.lambda_handler"
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  runtime          = "python3.7"

  vpc_config {
    security_group_ids = [var.eks_node_sec_group_id]
    subnet_ids         = var.cluster_subnet_ids
  }

  environment {
    variables = {
      TAG_NAME  = "aws:autoscaling:groupName"
      TAG_VALUE = "eks"
    }
  }
}