provider "krutrim" {
    base_url = "https://cloud.olakrutrim.com"
    account_id = "bastionzero"
    access_key = "bastionzero"
    secret_key = "bastionzero"

    email = var.krutrim_email
    password = var.krutrim_password
    is_root_user = var.krutrim_is_root_user
}