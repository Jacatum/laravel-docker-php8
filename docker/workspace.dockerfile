FROM ubuntu:latest
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -y software-properties-common
RUN add-apt-repository ppa:ondrej/php -y
RUN apt update && apt install -y build-essential curl
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt install -y nginx php8.0-fpm php8.0-mysql php8.0-mbstring php8.0-xml php8.0-bcmath php8.0-zip php8.0-cli php8.0-curl nodejs && \
	rm -rf /var/lib/apt/lists/* && \
    apt clean
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer
COPY ./nginx/default /etc/nginx/sites-enabled/default
WORKDIR /var/www
STOPSIGNAL SIGTERM
CMD service php8.0-fpm start && nginx -g "daemon off;"
EXPOSE 80
