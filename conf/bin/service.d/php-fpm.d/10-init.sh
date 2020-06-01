# setup user env
FPM_POOL_CONF="/opt/docker/etc/php/fpm/pool.d/application.conf"

PHP_UID=www-data
echo "Setting php-fpm user to $PHP_UID"
go-replace --mode=line --regex \
           -s '^[\s;]*user[\s]*='  -r "user = $PHP_UID" \
           -s '^[\s;]*group[\s]*=' -r "group = $PHP_UID" \
           --path=/opt/docker/etc/php/fpm/ \
           --path-pattern='*.conf'


chown -R $PHP_UID:$PHP_UID /var/svn