resource "aws_ssm_document" "event_driven_install" {
  name            = var.ssm_document_install
  document_type   = "Command"
  document_format = "YAML"

  content = <<DOC
        schemaVersion: "2.2"
        description: Command Document to install Apache in CentOS and RHEL
        mainSteps:
          - action: "aws:runShellScript"
            name: "deregister"
            inputs:
              runCommand:
                - "sudo yum -y install httpd"
DOC
  tags    = merge({ Name = var.ssm_document_install }, var.tags)
}

resource "aws_ssm_document" "event_driven_uninstall" {
  name            = var.ssm_document_uninstall
  document_type   = "Command"
  document_format = "YAML"

  content = <<DOC
        schemaVersion: "2.2"
        description: Command Document to uninstall Apache in CentOS and RHEL
        mainSteps:
          - action: "aws:runShellScript"
            name: "deregister"
            inputs:
              runCommand:
                - "sudo yum -y remove httpd"
DOC
  tags    = merge({ Name = var.ssm_document_uninstall }, var.tags)
}