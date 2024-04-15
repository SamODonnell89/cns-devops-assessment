import requests
import datetime
import time
import boto3

def get_service_url():
    # Retrieve the service URL using the AWS SDK
    eks_client = boto3.client('eks')
    cluster_name = 'canstar-eks-cluster'

    cluster_info = eks_client.describe_cluster(name=cluster_name)
    endpoint = cluster_info['cluster']['endpoint']

    # Todo: Replace hard-coded values to improve maintainability
    k8s_client = boto3.client('eks', endpoint_url=f'https://{endpoint}')
    service_name = 'current-time-service'
    namespace = 'default'

    service_info = k8s_client.describe_service(name=service_name, namespace=namespace)
    service_url = service_info['status']['loadBalancer']['ingress'][0]['hostname']

    return f'http://{service_url}'

def check_service_health():
    service_url = get_service_url()
    try:
        response = requests.get(service_url)
        if response.status_code == 200:
            service_time = datetime.datetime.strptime(response.text.strip(), '%Y-%m-%d %H:%M:%S')
            current_time = datetime.datetime.now()
            time_diff = abs((current_time - service_time).total_seconds())
            if time_diff <= 1:
                print("Service is healthy")
            else:
                print("Service clock is desynchronized by more than 1 second")
        else:
            print("Service is not responding")
    except requests.exceptions.RequestException as e:
        print("Error occurred while checking service health:", e)

while True:
    check_service_health()
    time.sleep(60)  # Check every 60 seconds, Todo: replace with a cron job