FROM httpd:latest
RUN apt update && \
apt install -y libapache2-mod-auth-openidc libnss3-tools curl && \
curl -JLO "https://dl.filippo.io/mkcert/latest?for=linux/amd64" && \
chmod +x mkcert-v*-linux-amd64 && \
cp mkcert-v*-linux-amd64 /usr/local/bin/mkcert

RUN mkcert -install

#RUN mkcert -key-file /root/key.pem -cert-file /root/cert.pem localhost
RUN mkcert -key-file /usr/local/apache2/conf/server.key -cert-file /usr/local/apache2/conf/server.crt localhost

COPY ./hl-httpd.conf /usr/local/apache2/conf/httpd.conf
COPY ./hl-httpd-ssl.conf /usr/local/apache2/conf/extra/httpd-ssl.conf
