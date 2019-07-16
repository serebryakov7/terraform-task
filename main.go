package main

import (
	"fmt"
	_ "github.com/aws/aws-sdk-go/aws"
	_ "github.com/aws/aws-sdk-go/aws/awserr"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/aws/event"
	"github.com/aws/aws-sdk-go/service/ec2"
	"github.com/aws/aws-sdk-go/aws"
	_ "github.com/aws/aws-sdk-go/service/ec2"
)

var sess = session.Must(session.NewSession())
var tagName = "test"

func Handle (event event.CloudWatchEvent) {
	ecClient := ec2.New(sess)
	params := &ec2.DescribeInstancesInput {
		Filters: []*ec2.Filter{
			&ec2.Filter{
				Name: aws.String("tag:Tag"),
				Values: []*string{
					aws.String(tagName),
				},
			},
		},
	}

	res, _ := ecClient.DescribeInstances(params)

	for _, i := range res.Reservations[0].Instances {
		var nt string
		for _, t := range i.Tags {
			if *t.Key == "test" {
				nt = *t.Value
				break
			}
		}
		fmt.Println(nt, *i.InstanceId, *i.State.Name)
	}

}

