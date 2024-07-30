# aws-health-collector

AWS Health Event를 통합하고 Hangout 과 같은 실시간 채널을 통해 주요 이벤트를 확인하세요.

<br>

## ECR Lambda Image

- [trigger-evtbus.sh](./cf-stacks/trigger-evtbus.sh) Bash Shell은 Hangout 실시간 채널로 이벤트를 통지하는 기능을 AWS Lambda로 구성될 수 있도록 AWS ECR 저장소를 생성하고,
[aws-health-delibird](https://hub.docker.com/r/symplesims/aws-health-delibird) 컨테이너 이미지를 ECR 저장소에 Push 하도록 도와줍니다.


<br>


## Data Collector

- [aws-cf-template-health-collector](cf-stacks/aws-cf-template-health-collector-v1.0.yaml) CF Stack 템플릿은 여러 AWS 계정으로부터 AWS Health 이벤트를 수집하고, 실시간 채널(Hangout)로 메시지를 발송하는 `Data Collector`를 구성 합니다.


<br>


## Health Forwarder

- [aws-cf-template-health-forwarder-orgs-v1.0.yaml](./cf-stacks/aws-cf-template-health-forwarder-orgs-v1.0.yaml) CF StackSet 템플릿은 Organizations 의 AWS 맴버 계정을 대상으로 
AWS Health 이벤트를 Data Collector 로 전송하는 `Health Forwarder`를 구성합니다.

