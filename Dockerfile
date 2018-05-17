FROM dockercloud/hello-world:latest
#COPY index.html /var/www/html
RUN rm -rf /www/index.php
RUN rm -rf /www/logo.png
#RUN mkdir -p /www
COPY index.html /www/
