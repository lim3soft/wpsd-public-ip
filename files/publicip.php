<?php

header('Content-Type: text/plain; charset=utf-8');
header('Cache-Control: no-cache, no-store, must-revalidate');

$ip = @shell_exec(
    '/usr/bin/curl -4 -fsS --connect-timeout 5 --max-time 10 https://ipv4.icanhazip.com'
);

$ip = trim($ip);

if (filter_var($ip, FILTER_VALIDATE_IP, FILTER_FLAG_IPV4)) {
    echo $ip;
} else {
    http_response_code(503);
    echo 'Unavailable';
}
