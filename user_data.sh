#!/bin/bash
yum update -y
yum install -y httpd mysql aws-cli

# Start and enable Apache
systemctl start httpd
systemctl enable httpd

# Get database credentials from Secrets Manager
DB_SECRET=$(aws secretsmanager get-secret-value --secret-id ${secret_arn} --region us-east-1 --query SecretString --output text)
DB_ENDPOINT=$(echo $DB_SECRET | jq -r .endpoint)
DB_NAME=$(echo $DB_SECRET | jq -r .dbname)
DB_USERNAME=$(echo $DB_SECRET | jq -r .username)

# Create a simple index page with database connection info
cat > /var/www/html/index.html << EOF
<!DOCTYPE html>
<html>
<head>
    <title>Application Server</title>
</head>
<body>
    <h1>Application Server Running</h1>
    <p>Database Endpoint: $DB_ENDPOINT</p>
    <p>Database Name: $DB_NAME</p>
    <p>Database Username: $DB_USERNAME</p>
    <p>Server: $(hostname)</p>
</body>
</html>
EOF

# Set proper permissions
chown apache:apache /var/www/html/index.html