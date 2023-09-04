# terraform-infra-training
terraform-infra-training
---------------------------
rds-ec2-s3-alb
기본적인 아키텍쳐 (lucidChart를 이용해서 아키텍쳐 그림)

![image](https://github.com/Sseamu/terraform-infra-training/assets/50833458/248c3669-0f8c-4248-b5f8-e7ab14f0cafc)

이 아키텍쳐는 학습용 아키텍쳐라서 위와 같이 만들었음
아키텍쳐 자체에 문제는 많음 DB instacne가 private이 아닌 public에 있어서 보안상 문제가 발생할 수 있다는 점에서 적합하지 않은 아키텍쳐임
Alb를 사용하려고 가용존을 2개로 나누는 식으로 관리를 한 것 같음 
여기서 아키텍쳐를 변경한다면 public subnet과 private subnet을 각 가용존에 1개씩 관리해서 작업하는식으로 관리하는게 더 나은 아키텍쳐라고생각됨! 
![image](https://github.com/Sseamu/terraform-infra-training/assets/50833458/3965fac9-d78e-4d6c-9d80-4a600c90fe1f)

아래는 위 아키텍쳐에서 좀 더 개선된 모양의 AWs architecture
AWS Architecture

![image](https://github.com/Sseamu/terraform-infra-training/assets/50833458/c5b130bb-8ac6-4d41-bbe6-574fbac0acd5)

이 아키텍쳐는 public subnet과 private subnet이 각 가용영역에 1개씩 있고 
public subnet에 있는 ec2-bastion host를 통해 ec2-instance에 접속할 수 있도록 하는 아키텍쳐 이다.
여기서 bastion host는 외부에서 내부네트워크로 진입하는데 출입구 역할을 하며 원격으로 접속하여 내부 시스템에 접근하는 사용자를 관리하는 역할을 한다.
(보안및 접속 관리)
Nat Gateway는 private Subnet에 있는 Ec2-isntance가 외부에서 데이터를 다운로드 및 업데이트 할 수 있게 Ec2 인스턴스가 외부와 통신할 수 있도록
도와주는 역할을 한다. 단 외부에서 직접 액세스는 할 수 없다 ( 이걸 bastion host를 통해 액세스함)
