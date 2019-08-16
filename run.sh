#!/bin/sh

mkdir /var/lib/tor/hidden_service
echo $TOR_SERVICE_KEY | base64 -d > /var/lib/tor/hidden_service/hs_ed25519_secret_key
chmod 700 /var/lib/tor/hidden_service

envsubst < /root/default.conf > /etc/nginx/conf.d/default.conf;

nginx

exec "$@"