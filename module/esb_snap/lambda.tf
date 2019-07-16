resource "aws_lambda_function" "test_lambda" {
  filename         = "lambda_function.zip"
  function_name    = "esb_snapshot"
  role             = "${ aws_iam_role.lambda.arn }"
  handler          = "index.handler"
  source_code_hash = "${ data.archive_file.lambda_zip.output_base64sha256 }"
  runtime          = "go.1.13"
}