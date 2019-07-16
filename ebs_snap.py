import boto3
import os

ec = boto3.client('ec2')

tag_name = os.environ['TAG_NAME']
tag_value = os.environ['TAG_VALUE']

def lambda_handler(event, context):
    reservations = \
        ec.describe_instances(Filters=[
         {
          'Name': 'tag:' + tag_name,
          'Values': [tag_value]
         }
         ]).get('Reservations', [])

    instances = sum([[i for i in r['Instances']] for r in reservations], [])

    for instance in instances:
        for dev in instance['BlockDeviceMappings']:
            if dev.get('Ebs', None) is None:
                continue
            vol_id = dev['Ebs']['VolumeId']
            
            ec.create_snapshot(VolumeId=vol_id)
