FROM dockercloud/hello-world:latest
#COPY index.html /var/www/html
RUN rm -rf /www
RUN mkdir -p /www
COPY index.html /www/
