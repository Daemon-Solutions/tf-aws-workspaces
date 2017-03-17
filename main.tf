# Workspaces Cloudformation Stack
resource "aws_cloudformation_stack" "workspaces" {
  name       = "${var.envtype}-workspace-${var.name}-stack"
  on_failure = "DELETE"

  parameters {
    customer = "${var.customer}"
    envname  = "${var.envname}"
    envtype  = "${var.envtype}"

    directoryid  = "${var.workspaces_directory_id}"
    bundleid     = "${var.workspaces_bundle_id}"
    username     = "${var.workspaces_ad_username}"
    volumekmskey = "${var.workspaces_volume_kms_key}"
  }

  tags {
    Customer        = "${var.customer}"
    Environment     = "${var.envname}"
    EnvironmentType = "${var.envtype}"
    Service         = "Workspaces"
  }

  template_body = <<STACK
{
  "Parameters" : {
    "directoryid" : {
      "Type" : "String",
      "Description" : "Microsoft Active Directory ID"
    },
    "bundleid" : {
      "Type" : "String",
      "Description" : "AWS Workspace Bundle ID"
    },
    "username" : {
      "Type" : "String",
      "Description" : "Microsoft Active Directory Workspace Username"
    },
    "volumekmskey" : {
      "Type" : "String",
      "Description" : "Volume KMS Encryption Key"
    },
    "customer" : {
      "Type" : "String"
    },
    "envname" : {
      "Type" : "String"
    },
    "envtype" : {
      "Type" : "String"
    }
  },
  "Resources" : {
    "workspace1" : {
      "Type" : "AWS::WorkSpaces::Workspace",
      "Properties" : {
        "BundleId" :    {"Ref" : "bundleid"},
        "DirectoryId" : {"Ref" : "directoryid"},
        "UserName" :    {"Ref" : "username"},
        "RootVolumeEncryptionEnabled" : "true",
        "UserVolumeEncryptionEnabled" : "true",
        "VolumeEncryptionKey" : {"Ref" : "volumekmskey"}
      }
    }
  },
  "Outputs" : {
    "workspaceId" : {
      "Description" : "Workspace ID",
      "Value" : { "Ref" : "workspace1"}
    }
  }
}
STACK
}
