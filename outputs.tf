resource "local_file" "inventory_yaml" {
  content = templatefile("inventory.yaml.tmpl",
    {
      hosts           = aws_instance.minecraft.*,
      ssh_private_key = var.ssh_private_key
    }
  )
  filename = "inventory.yaml"
}

resource "local_file" "aws_cli_credentials" {
  content  = <<EOF
aws_access_key_id = ${aws_iam_access_key.minecraft.id}
aws_secret_access_key = ${aws_iam_access_key.minecraft.secret}
EOF
  filename = "credentials"
}
