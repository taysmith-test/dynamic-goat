resource "aws_instance" "web_host" {
  # ec2 have plain text secrets in user data
  ami           = "${var.ami}"
  instance_type = "t2.nano"

  user_data = <<EOF
#! /bin/bash
sudo apt-get update
sudo apt-get install -y apache2
sudo systemctl start apache2
sudo systemctl enable apache2
export AWS_ACCESS_KEY_ID=AKIAIOSFODNN7EXAMAAA
export AWS_SECRET_ACCESS_KEY=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
export AWS_DEFAULT_REGION=us-west-2
export export ARTIFACTORY_URL=http://localhost:8081/artifactory
export ARTIFACTORY_TOKEN=AKCp5bueTFpfypEqQbGJPp7eHFi28fBivfWczrjbPb9erDff9LbXZbj6UsRExVXA8asWGc8fM
curl -H"Authorization: Bearer eyJ2ZXIiOiIyIiwidHlwIjoiSldUIiwiYWxnIjoiUlMyNTYiLCJraWQiOiJ1RmdMYkV6RlhVQUZXYkhMcUcxNmJmVE9SSmhBdHJuSEM1V3RueUdYc1drIn0.eyJzdWIiOiJqZmZlQDAwMC91c2Vycy9oZWxsb0BnaXRndWFyZGlhbi5jb20iLCJzY3AiOiJhcHBsaWVkLXBlcm1pc3Npb25zL2FkbWluIGFwaToqIiwiYXVkIjoiamZ4ckAqIiwiaXNzIjoiamZmZUAwMDAiLCJpYXQiOjkwMDI3MTk4MCwianRpIjoiNjk1ZDQwZWQtNGY2Zi00ZDk4LWE0NzYtYjExZTQ3MGNjM2EyIn0.ZpGDcUAebnd1sn5zXL0BYd6-Rv-6fKhEdJvKnYzsC28J0wJW0MU5MACmNx_HKWw-Ffr7_06fYJuhphy1XdTjZR6vIfUiQBQRmpFwLScC70MFgD8V-wjh04PkrnHyu6NPjVIg4NCS9IUOltPO3Pd3pzjLxbMG5evyoJ8O5Ucwhug" \
cat https://gitguardian.jfrog.io/router/api/v1/system/ping
echo "<h1>Deployed via Terraform</h1>" | sudo tee /var/www/html/index.html
EOF
  tags = merge({
    Name = "${local.resource_prefix.value}-ec2"
    }, {
    git_commit           = "d68d2897add9bc2203a5ed0632a5cdd8ff8cefb0"
    git_file             = "terraform/aws/ec2.tf"
    git_last_modified_at = "2020-06-16 14:46:24"
    git_last_modified_by = "nimrodkor@gmail.com"
    git_modifiers        = "nimrodkor"
    git_org              = "bridgecrewio"
    git_repo             = "terragoat"
    yor_trace            = "347af3cd-4f70-4632-aca3-4d5e30ffc0b6"
  })
}
