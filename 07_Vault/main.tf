provider "aws"{
    region = "ap-south-1"
}

provider "vault" {
  address = "http://3.7.254.64:8200"
  skip_child_token = true

  auth_login {
    path = "auth/approle/login"

    parameters = {
      role_id = "b285a986-e0a7-c543-d1a0-7446f03c5f48"
      secret_id = "8de439cd-3da6-8414-c3b8-92f70ea49d08"
    }
  }
}

data "vault_kv_secret_v2" "example" {
  mount = "kv"  # Adjust based on your Vault KV path
  name  = "test-secret"  # Path to your secret in Vault
}

resource "aws_instance" "name" {
    ami = "ami-00bb6a80f01f03502"
    instance_type = "t2.micro"
    tags = {
        Secret = data.vault_kv_secret_v2.example.data["username"]
    }
}

#Sometimes it causes error "Error making API request - Invalid secret id" is due to TTL configuration of secrets_id in the AppRole which is set to 10 mins during the AppRole configuration and hence after 10 mins the secrets are invalidated.
# so just increase time before or remove it.
