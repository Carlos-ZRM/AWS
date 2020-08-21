import boto3

regions = ['us-east-1','us-east-2','us-west-1','us-west-2']

def lambda_handler(event, context):
    for region in regions : 
        print("Region->",region)
        ec2 = boto3.client('ec2', region_name=region)
        instances = getInstance( ec2 )
        if  instances:
            start(ec2, instances)
        else :
            print("Not instances in this region ")

def start(ec2, instances):
    ec2.start_instances(InstanceIds=instances)
    print('started your instances: ' + str(instances))

def stop (ec2, instances):
    ec2.stop_instances(InstanceIds=instances)
    print('stopped your instances: ' + str(instances))

def getInstance(ec2):
    instances = []
    
    response = ec2.describe_instances(
        Filters=[
            {
                'Name': 'tag:estatus',
                'Values': [
                    'test', 'QA','qa','dev','desarrollo'
                ],
            },
        ]
        
    )
    
    
    for res in response["Reservations"]:
        for li in res["Instances"]:
            instances.append(li["InstanceId"])
    
    return instances
