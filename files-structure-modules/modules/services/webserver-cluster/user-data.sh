#!/bin/bash

cat > index.html <<EOF
<h1>Hello, World</h1>
<p>DB address: ${db_address}</p>
<p>DB port: ${db_port}</p>
EOF

echo "<BR>" >> index.html
echo "Hostname: $(hostname)" >> index.html
echo "<BR>" >> index.html
echo "EC2 IP Address: $(hostname -i)" >> index.html 

nohup busybox httpd -f -p ${server_port} &
