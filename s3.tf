resource "aws_s3_bucket" "bucket-nemesis" {
  bucket = "bucket-${local.s3-sufix}"

  tags = {
    Name = "Bucket - ${local.sufix}"
  }
}
