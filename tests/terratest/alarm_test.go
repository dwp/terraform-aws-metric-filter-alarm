package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"

	"path/filepath"

	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
)

// Terratest functions for testing the ses notifcation module
func TestAlarm(t *testing.T) {
	t.Parallel()

	// AWS Region set as eu-west-1 as standard.
	awsRegion := "eu-west-1"

	// set up variables for other module variables so assertions may be made on them later

	// Terraform plan.out File Path
	exampleFolder := test_structure.CopyTerraformFolderToTemp(t, "../..", "example/")
	planFilePath := filepath.Join(exampleFolder, "plan.out")


	terraformOptionsAlarm := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../../example",
		Upgrade:      true,

		// Variables to pass to our Terraform code using -var options
		Vars: map[string]interface{}{

		},

		//Environment variables to set when running Terraform
		EnvVars: map[string]string{
			"AWS_DEFAULT_REGION": awsRegion,
		},

		// Configure a plan file path so we can introspect the plan and make assertions about it.
		PlanFilePath: planFilePath,
	})

	// website::tag::2::Run `terraform init`, `terraform plan`, and `terraform show` and fail the test if there are any errors
	plan := terraform.InitAndPlanAndShowWithStruct(t, terraformOptionsAlarm)


	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptionsAlarm)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptionsAlarm)

	// website::tag::3::Use the go struct to introspect the plan values.
	terraform.RequirePlannedValuesMapKeyExists(t, plan, "aws_cloudwatch_log_group.terratest_log_group")
	terraform.RequirePlannedValuesMapKeyExists(t, plan, "aws_sns_topic.terratest_topic")
	terraform.RequirePlannedValuesMapKeyExists(t, plan, "module.terratest_metric_filter_alarm.aws_cloudwatch_log_metric_filter.metric_filter")
	terraform.RequirePlannedValuesMapKeyExists(t, plan, "module.terratest_metric_filter_alarm.aws_cloudwatch_metric_alarm.metric_alarm")


	// Run `terraform output` to get the value of an output variable
	metricfilterID := terraform.Output(t, terraformOptionsAlarm, "metric_filter_id")
	terratestloggroupID := terraform.Output(t, terraformOptionsAlarm, "terratest_log_group_id")
	topicArn := terraform.Output(t, terraformOptionsAlarm, "topic_arn")
	metricfilteralarmArn := terraform.Output(t, terraformOptionsAlarm, "metric_filter_alarm_arn")

	// To get the value of an output variable, run 'terraform output'
	Tags := terraform.OutputMap(t, terraformOptionsAlarm, "metric_alarm_tags")

	// Check that we get back the outputs that we expect
	assert.Equal(t, "DataWorks", Tags["Application"])
	assert.Equal(t, "PRJ0022507", Tags["Business-Project"])
	assert.Equal(t, "Data and Analytics", Tags["Function"])
	assert.Equal(t, "TerratestAlarm", Tags["Name"])

	// Checks topic arn exists
	lengthOftopicArn := len(topicArn)
	assert.NotEqual(t, lengthOftopicArn, 0, "ARN Output MUST be populated")

	// Checks filter id exists
	lengthOfmetricfilterID := len(metricfilterID)
	assert.NotEqual(t, lengthOfmetricfilterID, 0, "ID Output MUST be populated")

	// Checks log group id exists
	lengthOfterratestloggroupID := len(terratestloggroupID)
	assert.NotEqual(t, lengthOfterratestloggroupID, 0, "ID Output MUST be populated")

	// Checks filter alarm arn exists
	lengthOfmetricfilteralarmArn := len(metricfilteralarmArn)
	assert.NotEqual(t, lengthOfmetricfilteralarmArn, 0, "ARN Output MUST be populated")
}
