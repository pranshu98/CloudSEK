resource "aws_s3_bucket" "app_bucket" {
  bucket = "${var.app_name}-bucket-${substr(md5(timestamp()), 0, 8)}"

}
resource "aws_s3_bucket_acl" "app_bucket_acl" {
  bucket = aws_s3_bucket.app_bucket.id
  acl    = "private"  
}

output "bucket_name" {
  value = aws_s3_bucket.app_bucket.bucket
}
