#!/bin/bash
# Mettre à jour la liste des paquets
sudo yum update -y

# Installer Docker
sudo amazon-linux-extras install docker -y
sudo service docker start
sudo usermod -a -G docker ec2-user

# Installer Git
sudo yum install git -y

# Cloner votre dépôt API
git clone https://github.com/twyxii/your-api-repo.git /home/ec2-user/your-api-repo
cd /home/ec2-user/your-api-repo

# Construire et exécuter votre conteneur Docker
sudo docker build -t your-api-image .
sudo docker run -d -p 8080:8080 your-api-image

# Installer et configurer Nginx
sudo amazon-linux-extras install nginx1.12 -y
sudo systemctl start nginx
sudo systemctl enable nginx

# Configurer Nginx pour faire le proxy des requêtes vers votre API
cat << 'EOF' | sudo tee /etc/nginx/conf.d/api.conf
server {
    listen 80;
    location / {
        proxy_pass http://localhost:8080;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
EOF

sudo systemctl restart nginx
