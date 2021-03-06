# aws-tag-driven-app-install
Repo to demonstrate AWS tag driven application installation using EventBridge, Lambda and SSM Documents.
Should be considered a proof of concept, in customer envrionmetns I would expect a centrally driven, cross account approach.

Please see [blog article](https://markrosscloud.medium.com/aws-event-driven-application-installs-on-ec2-98826b58f4e5) for more deatils


<!--- BEGIN_TF_DOCS --->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.14.0 |
| aws | >= 3.20.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 3.20.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| app\_tag\_install\_value | Tag value to use to drive install of application.  Any other value or removal of the key will result in an uninstall | `string` | `"true"` | no |
| app\_tag\_key | Tag key to use to drive install of application | `string` | `"install-app"` | no |
| ssm\_document\_install | Name of SSM document to install app | `string` | `"event-driven-install"` | no |
| ssm\_document\_uninstall | Name of SSM document to install app | `string` | `"event-driven-uninstall"` | no |
| tags | Tags to apply to resources | `map(any)` | <pre>{<br>  "Environment": "App-Install-Event-Driven-Test"<br>}</pre> | no |

## Outputs

No output.

<!--- END_TF_DOCS --->

## Author
Mark Ross (connect via [LinkedIn](https://www.linkedin.com/in/markjamesross/))
