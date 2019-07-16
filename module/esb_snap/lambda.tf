resource "aws_lambda_function" "ebs_snapshot" {
  filename         = "lambda_function.zip"
  function_name    = "EBSSnapshot"
  role             = aws_iam_role.lambda.arn
  handler          = "main"
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  runtime          = "go.1.13"
}