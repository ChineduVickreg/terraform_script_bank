resource "aws_s3_bucket" "s3Bucket" {
     bucket = "enumv2-production-bucket"
     acl       = "private"

     /* policy  = jsonencode({
      "version" : "2012-10-17",
      "statement" : [{
         "action" : ["s3:GetObject", "s3:GetObjectAcl","s3:ListBucket"],
         "effect" : "Allow",
         "resource" : "arn:aws:s3:::enumv2-production-bucket/*",
         "principal" : "arn:aws:iam::357586184453:root"
      },
    ],
  }) */

  

   website {
       index_document = "index.html"
   }
}