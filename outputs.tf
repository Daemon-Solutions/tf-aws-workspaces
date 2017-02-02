output "workspace_id" {
  value = "${aws_cloudformation_stack.workspaces.outputs["workspaceId"]}"
}
