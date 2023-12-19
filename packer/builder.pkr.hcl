packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "~> 1"
    }
  }
}

variable "aws_region" {
  type    = string
  default = "eu-central-1"
}

source "amazon-ebs" "wordpress" {
  region     = var.aws_region
  instance_type = "t2.micro"
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    owners      = ["099720109477"] // Canonical
    most_recent = true
  }
  ssh_username = "ubuntu"
  ami_name = "wordpress-nginx-php-${replace(timestamp(), ":", "-")}"
}

build {
  sources = [
    "source.amazon-ebs.wordpress"
  ]

  // Upload the Nginx config file
  provisioner "file" {
    source      = "./config/wordpress.conf"
    destination = "/tmp/wordpress.conf"
  }

  provisioner "shell" {
  inline = [
    "export DEBIAN_FRONTEND=noninteractive",
    "sudo apt-get clean",
    "sudo rm -rf /var/lib/apt/lists/*",
    "sudo apt-get update -y",
    "sudo apt-get upgrade -y",
    "sudo apt-get install -y nginx",
    "sudo apt-get update -y",
    "sudo apt-get install -y nginx php7.4-fpm php-mysql php-redis php-opcache php-gd php-xml php-mbstring",
    "sudo systemctl start php7.4-fpm",
    "sudo systemctl enable php7.4-fpm",
    "sudo systemctl start nginx",
    "sudo systemctl enable nginx",
    # Download and configure WordPress
    "curl -O https://wordpress.org/latest.tar.gz",
    "tar -xzf latest.tar.gz",
    "sudo mv wordpress /var/www/html/",
    "sudo chown -R www-data:www-data /var/www/html/wordpress",
    "sudo chmod -R 755 /var/www/html/wordpress",
    "sudo mv /var/www/html/wordpress/wp-config-sample.php /var/www/html/wordpress/wp-config.php",
    # Move the Nginx configuration file to sites-available and create a symbolic link in sites-enabled
    "sudo mv /tmp/wordpress.conf /etc/nginx/sites-available/wordpress",
    "sudo ln -s /etc/nginx/sites-available/wordpress /etc/nginx/sites-enabled/",
    "sudo unlink /etc/nginx/sites-enabled/default",
    "sudo nginx -t",
    "sudo systemctl restart nginx"
  ]
}

}
