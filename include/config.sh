# Copyright (C) 2013 - 2021 Teddysun <i@teddysun.com>
# 
# This file is part of the LAMP script.
#
# LAMP is a powerful bash script for the installation of 
# Apache + PHP + MySQL/MariaDB and so on.
# You can install Apache + PHP + MySQL/MariaDB in an very easy way.
# Just need to input numbers to choose what you want to install before installation.
# And all things will be done in a few minutes.
#
# Website:  https://lamp.sh
# Github:   https://github.com/teddysun/lamp

load_config(){

#Install location
apache_location=/usr/local/apache
mysql_location=/usr/local/mysql
mariadb_location=/usr/local/mariadb
php_location=/usr/local/php
openssl_location=/usr/local/openssl

#Install depends location
depends_prefix=/usr/local

#Web root location
web_root_dir=/data/www/default

#Download root URL
download_root_url="https://dl.lamp.sh/files/"

#parallel compile option,1:enable,0:disable
parallel_compile=1

##Software version
#nghttp2
nghttp2_filename="nghttp2-1.42.0"
nghttp2_filename_url="https://github.com/nghttp2/nghttp2/releases/download/v1.42.0/nghttp2-1.42.0.tar.gz"
#openssl
openssl_filename="openssl-1.1.1i"
openssl_filename_url="https://www.openssl.org/source/openssl-1.1.1i.tar.gz"
#apache2.4
apache2_4_filename="httpd-2.4.46"
apache2_4_filename_url="http://ftp.jaist.ac.jp/pub/apache//httpd/httpd-2.4.46.tar.gz"
#mysql5.6
mysql5_6_filename="mysql-5.6.50"
#mysql5.7
mysql5_7_filename="mysql-5.7.32"
#mysql8.0
mysql8_0_filename="mysql-8.0.22"
#mariadb10.1
mariadb10_1_filename="mariadb-10.1.48"
#mariadb10.2
mariadb10_2_filename="mariadb-10.2.36"
#mariadb10.3
mariadb10_3_filename="mariadb-10.3.27"
#mariadb10.4
mariadb10_4_filename="mariadb-10.4.17"
#mariadb10.5
mariadb10_5_filename="mariadb-10.5.8"
#php5.6
php5_6_filename="php-5.6.40"
php5_6_filename_url="https://www.php.net/distributions/php-5.6.40.tar.gz"
#php7.0
php7_0_filename="php-7.0.33"
php7_0_filename_url="https://www.php.net/distributions/php-7.0.33.tar.gz"
#php7.1
php7_1_filename="php-7.1.33"
php7_1_filename_url="https://www.php.net/distributions/php-7.1.33.tar.gz"
#php7.2
php7_2_filename="php-7.2.34"
php7_2_filename_url="https://www.php.net/distributions/php-7.2.34.tar.gz"
#php7.3
php7_3_filename="php-7.3.26"
php7_3_filename_url="https://www.php.net/distributions/php-7.3.26.tar.gz"
#php7.4
php7_4_filename="php-7.4.14"
php7_4_filename_url="https://www.php.net/distributions/php-7.4.14.tar.gz"
#php8.0
php8_0_filename="php-8.0.1"
php8_0_filename_url="https://www.php.net/distributions/php-8.0.1.tar.gz"
#phpMyAdmin
phpmyadmin_filename="phpMyAdmin-4.9.7-all-languages"
phpmyadmin_filename_url="https://files.phpmyadmin.net/phpMyAdmin/4.9.7/phpMyAdmin-4.9.7-all-languages.tar.gz"
phpmyadmin_filename2="phpMyAdmin-5.0.4-all-languages"
phpmyadmin_filename2_url="https://files.phpmyadmin.net/phpMyAdmin/5.0.4/phpMyAdmin-5.0.4-all-languages.tar.gz"
#Adminer
adminer_filename="adminer-4.7.8"
adminer_filename_url="https://github.com/vrana/adminer/releases/download/v4.7.8/adminer-4.7.8.php"
#X-Prober
x_prober_url="https://github.com/kmvan/x-prober/releases/latest/download/prober.php"
#kodexplorer
kod_version="$(wget --no-check-certificate -qO- https://api.github.com/repos/kalcaddle/kodfile/releases/latest | grep 'tag_name' | cut -d\" -f4)"
[ -z "${kod_version}" ] && kod_version="4.35"
kodexplorer_filename="kodfile-${kod_version}"
kodexplorer_filename_url="https://github.com/kalcaddle/kodfile/archive/${kod_version}.tar.gz"
set_hint ${kodexplorer_filename} "kodexplorer-${kod_version}"

#apr
apr_filename="apr-1.7.0"
apr_filename_url="http://ftp.jaist.ac.jp/pub/apache//apr/apr-1.7.0.tar.gz"
#apr-util
apr_util_filename="apr-util-1.6.1"
apr_util_filename_url="http://ftp.jaist.ac.jp/pub/apache//apr/apr-util-1.6.1.tar.gz"
#mod_wsgi
mod_wsgi_filename="mod_wsgi-4.7.1"
mod_wsgi_filename_url="https://github.com/GrahamDumpleton/mod_wsgi/archive/4.7.1.tar.gz"
#mod_jk
mod_jk_filename="tomcat-connectors-1.2.48-src"
mod_jk_filename_url="http://ftp.jaist.ac.jp/pub/apache/tomcat/tomcat-connectors/jk/tomcat-connectors-1.2.48-src.tar.gz"
set_hint ${mod_jk_filename} "mod_jk-1.2.48"
#mod_security
mod_security_filename="modsecurity-2.9.3"
mod_security_filename_url="https://github.com/SpiderLabs/ModSecurity/releases/download/v2.9.3/modsecurity-2.9.3.tar.gz"
set_hint ${mod_security_filename} "mod_security-2.9.3"
#mhash
mhash_filename="mhash-0.9.9.9"
mhash_filename_url="https://sourceforge.net/projects/mhash/files/mhash/0.9.9.9/mhash-0.9.9.9.tar.gz/download"
#libmcrypt
libmcrypt_filename="libmcrypt-2.5.8"
libmcrypt_filename_url="https://sourceforge.net/projects/mcrypt/files/Libmcrypt/2.5.8/libmcrypt-2.5.8.tar.gz/download"
#mcrypt
mcrypt_filename="mcrypt-2.6.8"
mcrypt_filename_url="https://sourceforge.net/projects/mcrypt/files/MCrypt/2.6.8/mcrypt-2.6.8.tar.gz/download"
#pcre
pcre_filename="pcre-8.44"
pcre_filename_url="https://ftp.pcre.org/pub/pcre/pcre-8.44.tar.gz"
#re2c
re2c_filename="re2c-2.0.3"
re2c_filename_url="${download_root_url}/re2c-2.0.3.tar.gz"
#cmake
cmake_filename="cmake-3.18.0"
cmake_filename_url="https://github.com/Kitware/CMake/releases/download/v3.18.0/cmake-3.18.0.tar.gz"
cmake_filename2="cmake-3.18.0-Linux-x86_64"
cmake_filename_url2="https://github.com/Kitware/CMake/releases/download/v3.18.0/cmake-3.18.0-Linux-x86_64.tar.gz"
#libzip
libzip_filename="libzip-1.7.3"
libzip_filename_url="https://libzip.org/download/libzip-1.7.3.tar.gz"
#libiconv
libiconv_filename="libiconv-1.16"
libiconv_filename_url="https://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.16.tar.gz"
#libevent
libevent_filename="libevent-2.1.12-stable"
libevent_filename_url="https://github.com/libevent/libevent/releases/download/release-2.1.12-stable/libevent-2.1.12-stable.tar.gz"
#sqlite3
sqlite3_filename="sqlite-autoconf-3310000"
sqlite3_filename_url="${download_root_url}/sqlite-autoconf-3310000.tar.gz"
#icu4c
icu4c_filename="icu"
icu4c_filename_url="https://github.com/unicode-org/icu/releases/download/release-50-2/icu4c-50_2-src.tgz"
#autoconf
autoconf_filename="autoconf-2.69"
autoconf_filename_url="http://ftp.gnu.org/gnu/autoconf/autoconf-2.69.tar.gz"
#argon2
argon2_filename="argon2-20171227"
argon2_filename_url="${download_root_url}/argon2-20171227.tar.gz"
#xcache
xcache_filename="xcache-3.2.0"
xcache_filename_url="https://xcache.lighttpd.net/pub/Releases/3.2.0/xcache-3.2.0.tar.gz"
#ionCube
ionCube_filename="ioncube_loaders"
ionCube32_filename="ioncube_loaders_lin_x86"
ionCube32_filename_url="https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86.tar.gz"
ionCube64_filename="ioncube_loaders_lin_x86-64"
ionCube64_filename_url="https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz"
#pdflib
pdflib_filename="pdflib-9.3.0"
pdflib32_filename="PDFlib-9.3.0-Linux-x86-php"
pdflib32_filename_url="https://www.pdflib.com/binaries/PDFlib/930/PDFlib-9.3.0-Linux-x86-php.tar.gz"
pdflib64_filename="PDFlib-9.3.0-Linux-x86_64-php"
pdflib64_filename_url="https://www.pdflib.com/binaries/PDFlib/930/PDFlib-9.3.0-Linux-x86_64-php.tar.gz"
#PECL packages
#php extension swoole
swoole_filename="swoole-4.5.10"
swoole_filename_url="https://pecl.php.net/get/swoole-4.5.10.tgz"
#php extension xdebug
xdebug_filename="xdebug-2.5.5"
xdebug_filename_url="https://pecl.php.net/get/xdebug-2.5.5.tgz"
xdebug_filename2="xdebug-2.9.8"
xdebug_filename2_url="https://pecl.php.net/get/xdebug-2.9.8.tgz"
xdebug_filename3="xdebug-3.0.1"
xdebug_filename3_url="https://pecl.php.net/get/xdebug-3.0.1.tgz"
#ImageMagick
ImageMagick_filename="ImageMagick-7.0.10-56"
ImageMagick_filename_url="https://download.imagemagick.org/ImageMagick/download/releases/ImageMagick-7.0.10-56.tar.gz"
#php extension imagick
php_imagemagick_filename="imagick-3.4.4"
php_imagemagick_filename_url="https://pecl.php.net/get/imagick-3.4.4.tgz"
#GraphicsMagick
GraphicsMagick_filename="GraphicsMagick-1.3.35"
GraphicsMagick_filename_url="https://sourceforge.net/projects/graphicsmagick/files/graphicsmagick/1.3.35/GraphicsMagick-1.3.35.tar.gz/download"
#php extension gmagick
php_graphicsmagick_filename="gmagick-1.1.7RC3"
php_graphicsmagick_filename_url="https://pecl.php.net/get/gmagick-1.1.7RC3.tgz"
php_graphicsmagick_filename2="gmagick-2.0.5RC1"
php_graphicsmagick_filename2_url="https://pecl.php.net/get/gmagick-2.0.5RC1.tgz"
#memcached
memcached_filename="memcached-1.6.6"
memcached_filename_url="http://www.memcached.org/files/memcached-1.6.6.tar.gz"
#libmemcached
libmemcached_filename="libmemcached-1.0.18"
libmemcached_filename_url="https://launchpadlibrarian.net/165454254/libmemcached-1.0.18.tar.gz"
#php extension memcached
php_memcached_filename="memcached-2.2.0"
php_memcached_filename_url="https://pecl.php.net/get/memcached-2.2.0.tgz"
php_memcached_filename2="memcached-3.1.5"
php_memcached_filename2_url="https://pecl.php.net/get/memcached-3.1.5.tgz"
#redis
redis_filename="redis-5.0.10"
redis_filename_url="http://download.redis.io/releases/redis-5.0.10.tar.gz"
#php extension redis
php_redis_filename="redis-4.3.0"
php_redis_filename_url="https://pecl.php.net/get/redis-4.3.0.tgz"
php_redis_filename2="redis-5.3.2"
php_redis_filename2_url="https://pecl.php.net/get/redis-5.3.2.tgz"
#php extension mongodb
php_mongo_filename="mongodb-1.9.0"
php_mongo_filename_url="https://pecl.php.net/get/mongodb-1.9.0.tgz"
#libsodium
libsodium_filename="libsodium-1.0.18"
libsodium_filename_url="https://download.libsodium.org/libsodium/releases/libsodium-1.0.18.tar.gz"
#php extension libsodium
php_libsodium_filename="libsodium-2.0.23"
php_libsodium_filename_url="https://pecl.php.net/get/libsodium-2.0.23.tgz"
#php extension yaf
yaf_filename="yaf-3.2.5"
yaf_filename_url="https://pecl.php.net/get/yaf-3.2.5.tgz"
#php extension psr
psr_filename="psr-1.0.1"
psr_filename_url="https://pecl.php.net/get/psr-1.0.1.tgz"
#php extension phalcon
phalcon_filename="phalcon-4.1.0"
phalcon_filename_url="https://pecl.php.net/get/phalcon-4.1.0.tgz"
#php extension apcu
apcu_filename="apcu-5.1.19"
apcu_filename_url="https://pecl.php.net/get/apcu-5.1.19.tgz"
#php extension grpc
grpc_filename="grpc-1.34.0"
grpc_filename_url="https://pecl.php.net/get/grpc-1.34.0.tgz"
#php extension msgpack
msgpack_filename="msgpack-2.1.2"
msgpack_filename_url="https://pecl.php.net/get/msgpack-2.1.2.tgz"
#php extension yar
yar_filename="yar-2.1.2"
yar_filename_url="https://pecl.php.net/get/yar-2.1.2.tgz"

#software array setting
apache_arr=(
${apache2_4_filename}
do_not_install
)

apache_modules_arr=(
${mod_wsgi_filename}
${mod_security_filename}
${mod_jk_filename}
do_not_install
)

mysql_arr=(
${mysql5_6_filename}
${mysql5_7_filename}
${mysql8_0_filename}
${mariadb10_1_filename}
${mariadb10_2_filename}
${mariadb10_3_filename}
${mariadb10_4_filename}
${mariadb10_5_filename}
do_not_install
)

php_arr=(
${php5_6_filename}
${php7_0_filename}
${php7_1_filename}
${php7_2_filename}
${php7_3_filename}
${php7_4_filename}
${php8_0_filename}
do_not_install
)

phpmyadmin_arr=(
${phpmyadmin_filename}
${adminer_filename}
do_not_install
)

kodexplorer_arr=(
${kodexplorer_filename}
do_not_install
)

php_modules_arr=(
${ionCube_filename}
${pdflib_filename}
${xcache_filename}
${apcu_filename}
${php_imagemagick_filename}
${php_graphicsmagick_filename}
${php_memcached_filename}
${php_redis_filename}
${php_mongo_filename}
${php_libsodium_filename}
${swoole_filename}
${yaf_filename}
${yar_filename}
${grpc_filename}
${phalcon_filename}
${xdebug_filename}
do_not_install
)

}
