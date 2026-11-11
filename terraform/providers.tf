provider "krutrim" {
    base_url = "https://cloud.olakrutrim.com"
    account_id = var.krutrim_account_id
    access_key = var.krutrim_access_key
    secret_key = var.krutrim_secret_key

    email = var.krutrim_email
    password = var.krutrim_password
    is_root_user = var.krutrim_is_root_user
}
