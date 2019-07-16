data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "ebs_snap.py"
  output_path = "ebs_snap.zip"
}