resource "local_file" "inventory_yaml" {
  content = templatefile("inventory.yaml.tmpl",
    {
      hosts           = aws_instance.minecraft.*,
      ssh_private_key = var.ssh_private_key
    }
  )
  filename = "inventory.yaml"
}

