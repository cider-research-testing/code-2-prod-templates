variable "function_filename" {
  type = string
  description = "Filename of the Lambda function zip file"
}

variable "function_name" {
  type = string
  description = "Name of the Lambda function"
}

variable "function_role_arn" {
  type = string
  description = "ARN of the IAM role for the Lambda function"
}

variable "function_handler" {
  type = string
  description = "Handler for the Lambda function"
}

variable "function_runtime" {
  type = string
  description = "Runtime for the Lambda function"
}


data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}


resource "aws_lambda_function" "test_lambda" {
  filename         = var.function_filename
  function_name    = var.function_name
  role             = var.function_role_arn
  handler          = var.function_handler
  source_code_hash = filebase64sha256(var.function_filename)
  runtime          = var.function_runtime
}
