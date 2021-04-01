# aws-tag-driven-app-install
Repo to demonstrate AWS tag driven application installation using EventBridge, Lambda and SSM Documents.
Should be considered a proof of concept, in customer envrionmetns I would expect a centrally driven, cross account approach.

Please see [blog](https://markrosscloud.medium.com/) for more deatils


<!--- BEGIN_TF_DOCS --->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

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