#+++++++++++++++++++++++++++++++++++++++
# Dockerfile for webdevops/php-apache:5.6
#    -- automatically generated  --
#+++++++++++++++++++++++++++++++++++++++

FROM webdevops/php:5.6

ENV WEB_DOCUMENT_ROOT=/app \
    WEB_DOCUMENT_INDEX=index.php \
    WEB_ALIAS_DOMAIN=*.vm \
    WEB_PHP_TIMEOUT=600 \
    WEB_PHP_SOCKET=""
ENV WEB_PHP_SOCKET=127.0.0.1:9000

RUN rm -f /etc/apt/sources.list
COPY apt/sources.list /etc/apt/

COPY conf/ /opt/docker/

COPY web/iF_SVNAdmin/ /app/svnadmin/
RUN chmod -R 777 /app/svnadmin/

RUN set -x \
    # Install apache & SVN
    && apt-install \
        apache2 \
        subversion \
        libapache2-mod-svn \
    && sed -ri ' \
        s!^(\s*CustomLog)\s+\S+!\1 /proc/self/fd/1!g; \
        s!^(\s*ErrorLog)\s+\S+!\1 /proc/self/fd/2!g; \
        ' /etc/apache2/apache2.conf \
    && rm -f /etc/apache2/sites-enabled/* \
    && a2enmod actions proxy proxy_fcgi ssl rewrite headers expires \
    # Install SVN 
    && docker-run-bootstrap \
    && docker-image-cleanup

EXPOSE 80 443 36
