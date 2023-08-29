# aws s3 rm s3://saju-front-prod --recursive
# terraform destroy 를 하기전에 S3 버킷 내용이 삭제되어야 한다.
# s3 버킷 생성시 AWS를 이용하는 모든 사용자들의 s3 버킷 이름과 중복해서 사용할 수 없습니다.

# S3 버킷
# 위치 : s3 > 버킷
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
resource "aws_s3_bucket" "hansom-s3" {
  bucket = var.bucket //버킷 이름

  tags = {
    Name    = "hansom-front-${var.service_type}"
    Service = "hansom-${var.service_type}"
  }
}


// 버킷을 해제해주는 풀어주는 작업
resource "aws_s3_bucket_public_access_block" "public-access" {
  bucket = aws_s3_bucket.hansom-s3.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# resource "aws_s3_object" "learn-terraform-sample-txt" { 해당내용은 불필요
#   bucket = aws_s3_bucket.hansom-s3.id
#   key    = "sample.txt"
#   source = "sample.txt"
# }


# 버킷 정책(acl)
resource "aws_s3_bucket_policy" "bucket-policy" {
  bucket = aws_s3_bucket.hansom-s3.id

  depends_on = [
    aws_s3_bucket_public_access_block.public-access
  ]

  policy = <<POLICY
{
  "Version":"2012-10-17",
  "Statement":[
    {
      "Sid":"PublicRead",
      "Effect":"Allow",
      "Principal": "*",
      "Action":["s3:GetObject"],
      "Resource":["arn:aws:s3:::${aws_s3_bucket.hansom-s3.id}/*"]
    }
  ]
}
POLICY
}


//정적 웹 호스팅
resource "aws_s3_bucket_website_configuration" "hansom-s3" {
  bucket = aws_s3_bucket.hansom-s3.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

  routing_rule {
    condition {
      key_prefix_equals = "docs/"
    }
    redirect {
      replace_key_prefix_with = "documents/"
    }
  }
}
