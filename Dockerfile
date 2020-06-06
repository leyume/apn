FROM alpine:3.10
LABEL Maintainer="L eye <leye@servorien.com>" \
      Description="Lightweight container with Nginx 1.16 & PHP-FPM 7.3 based on Alpine Linux."

# Install packages
RUN apk --no-cache add \
		php7 \
		php7-fpm \
        php7-pdo \
        php7-pdo_mysql \
        php7-mysqli \
		php7-json \
        php7-curl \
        php7-mcrypt \
        php7-mbstring \
        php7-openssl \
        php7-pcntl \
        php7-session \
        php7-dom \
        #
        # php phar for composer
        # php7-phar \
        #
        # php7-zlib \
        # php7-xml \
        # php7-intl \
        # php7-xmlreader \
        # php7-ctype \
        # php7-gd \
        # ca-certificates \
        # git \
        # unzip \
        # php7-cgi \
        # php7-curl \
        # php7-opcache \
        # php7-tokenizer \
        # php7-zip \
        #
        bash \
        curl \
        nginx && \
    rm -rf \
        /var/cache/apk/* \
        /tmp/*

# Configure nginx
COPY config/nginx.conf /etc/nginx/nginx.conf

# Configure PHP-FPM
COPY config/fpm-pool.conf /etc/php7/php-fpm.d/www.conf
COPY config/php.ini /etc/php7/conf.d/zzz_custom.ini


# Install Composer
# RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer


# Make sure files/folders needed by the processes are accessable when they run under the nobody user
RUN chown -R nobody.nobody /run && \
  chown -R nobody.nobody /var/lib/nginx && \
  chown -R nobody.nobody /var/tmp/nginx && \
  chown -R nobody.nobody /var/log/nginx

# Serve
COPY bin/serve /bin/serve

RUN chmod a+x /bin/serve 
RUN mkdir -p /var/run/nginx /nginx/logs 
RUN chmod -R a+w /var/run/nginx
RUN chmod -R a+w /nginx/logs


# Setup document root
RUN mkdir -p /app

# Make the document root a volume
VOLUME /app

# Switch to use a non-root user from here on
USER nobody

# Add application
WORKDIR /app
COPY --chown=nobody src/ /app

# Expose the port nginx is reachable on
EXPOSE 8080


# Entry point
CMD ["serve"]