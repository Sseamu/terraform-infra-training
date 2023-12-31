# VPC
variable "vpc_id" {
  type = string
}

# 프라이빗 서브넷1
variable "private_subnet1_id" {
  type = string
}

# 서비스 타입
variable "service_type" {
  type = string
}

# 인스턴스 타입
variable "instance_type" {
  type = string
}

# user_data 경로
variable "user_data_path" {
  type = string
}
