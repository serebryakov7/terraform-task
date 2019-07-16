package main

import (
	"context"
	"fmt"
	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/ec2"
	"log"
)

var (
	TagName = aws.String("tag:EBSDailyBackup")
	TargetValues = []*string { aws.String("enabled") }

	sess = session.Must(session.NewSessionWithOptions(session.Options{
		SharedConfigState: session.SharedConfigEnable,
	}))

	ec2srv = ec2.New(sess)

	params = &ec2.DescribeInstancesInput{
		Filters: []*ec2.Filter {
			{
				Name:   TagName,
				Values: TargetValues,
			},
		},
	}
)

func handler () error {
	resp, err := ec2srv.DescribeInstances(params)
	if err != nil {
		return err
	}

	fmt.Printf("res: %v", resp)

	if len(resp.Reservations) == 0 {
		fmt.Println("No instances with provided tag")
		return nil
	}

	for idx, res := range resp.Reservations {
		fmt.Println("  > Reservation Id", *res.ReservationId, " Num Instances: ", len(res.Instances))
		for _, instance := range resp.Reservations[idx].Instances {
			fmt.Println("    - Instance ID: ", *instance.InstanceId)
			for _, volumeId := range getAttachedVolumesIDs(instance) {
				if err := createSnapshot(volumeId); err != nil {
					return err
				}
			}
		}
	}

	return nil
}

func getAttachedVolumesIDs (instance *ec2.Instance) []*string {
	var volumes []*string

	for _, dev := range instance.BlockDeviceMappings {
		volumes = append(volumes, dev.Ebs.VolumeId)
	}

	fmt.Printf("%v", volumes)
	return volumes
}

func createSnapshot(volumeID *string) error {
	params := &ec2.CreateSnapshotInput{
		VolumeId:    volumeID,
	}

	log.Printf("Starting snapshot for %s", aws.StringValue(volumeID))
	_, err := ec2srv.CreateSnapshot(params)
	if err != nil {
		return err
	}

	return nil
}

func main() {
	lambda.Start(handler)
}