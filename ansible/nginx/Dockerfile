FROM nginx

RUN apt update && \
apt install libnss3-tools curl -y
#apt install libnss3-tools curl -y && \
#curl -JLO "https://dl.filippo.io/mkcert/latest?for=linux/amd64" && \
#chmod +x mkcert-v*-linux-amd64 && \
#cp mkcert-v*-linux-amd64 /usr/local/bin/mkcert

#RUN mkcert -install

#RUN mkcert -key-file /root/key.pem -cert-file /root/cert.pem localhost
openssl req -x509 -newkey rsa:4096 -sha256 -days 3650 -nodes -keyout /root/key.pem -out cert.pem -subj "/CN=keycloak-hylastix.uksouth.cloudapp.azure.com"  -addext "subjectAltName=DNS:keycloak-hylastix.uksouth.cloudapp.azure.com,DNS:keycloak-hylastix.uksouth.cloudapp.azure.com"
