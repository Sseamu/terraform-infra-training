#private IP
output "private_ip" {
  value = module.ec2.private_ip
}

#Elastic Ip
output "eip_ip" {
  value = module.ec2-bastion.eip_ip
}

#로드밸런서 주소
output "alb_dns_name" {
  value = module.alb.alb_dns_name
}

#S3 정적웹 호스팅 => 이건 4월기준으로 새롭게 변경되서 작업안해도됨
# S3 정적 웹 호스팅 엔드포인트 
#주석처리는 ctrl + k + C 주석해제는 ctrl + k + u

# output "s3_endpoint" {
#   value = module.s3.s3_endpoint
# }

# RDS 엔드포인트
output "rds_endpoint" {
  value = module.rds.rds_endpoint
}
