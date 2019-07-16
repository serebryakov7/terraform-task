resource "aws_cloudwatch_event_rule" "daily" {
    name = "daily"
    description = "Fires every five minutes"
    schedule_expression = "rate(1 day)"
}

resource "aws_cloudwatch_event_target" "ebs_snapshot_every_day" {
    rule = "${ aws_cloudwatch_event_rule.daily.name}"
    target_id = "ebs_snapshot"
    arn = "${ aws_lambda_function.check_foo.arn }"
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_ebs_snapshot" {
    statement_id = "AllowExecutionFromCloudWatch"
    action = "lambda:InvokeFunction"
    function_name = "${ aws_lambda_function.ebs_snapshot.function_name }"
    principal = "events.amazonaws.com"
    source_arn = "${ aws_cloudwatch_event_rule.daily.arn }"
}