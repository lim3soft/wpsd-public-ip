# wpsd-public-ip
Inject API to your WPSD dashboard for Public IP Display

#How to install the script
ssh to your wpsd
Once all four files are present, SSH into your WPSD device and run:

curl -fsSL https://raw.githubusercontent.com/lim3soft/wpsd-public-ip/main/install.sh | sudo bash

#Then check by typing the command below

systemctl is-active wpsd-public-ip-apply.timer
grep -c 'reloadPublicIP' /var/www/dashboard/index.php
curl -s http://127.0.0.1/api/publicip.php

#Expected output

active
1
your.public.ip.address
