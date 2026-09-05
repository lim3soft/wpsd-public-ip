# wpsd-public-ip
Inject an API to your WPSD dashboard for Public IP Display

<img width="1874" height="340" alt="image" src="https://github.com/user-attachments/assets/f8bd625f-102e-479a-a6f3-ca2f43ac47b1" />


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
