FROM jamesmontalvo3/meza-docker-test-max:latest
MAINTAINER James Montalvo
ENV container=docker

# Install node/npm, install parsoid and dependencies
# RUN yum --enablerepo epel install -y nodejs npm
# RUN git clone https://gerrit.wikimedia.org/r/p/mediawiki/services/parsoid /etc/parsoid \
#     && cd /etc/parsoid && git checkout dd8e644d320aec076f76da4e2bd70a8527e0dfd8 \
#     && npm install

# Install IUS
RUN yum install -y https://centos7.iuscommunity.org/ius-release.rpm \
    && wget http://dl.iuscommunity.org/pub/ius/IUS-COMMUNITY-GPG-KEY \
    && rpm --import ./IUS-COMMUNITY-GPG-KEY

# Install PHP from IUS
RUN yum install -y \
    php56u \
    php56u-cli \
    php56u-common \
    php56u-devel \
    php56u-gd \
    php56u-pecl-memcache \
    php56u-pspell \
    php56u-snmp \
    php56u-xml \
    php56u-xmlrpc \
    php56u-mysqlnd \
    php56u-pdo \
    php56u-odbc \
    php56u-pear \
    php56u-pecl-jsonc \
    php56u-process \
    php56u-bcmath \
    php56u-intl \
    php56u-opcache \
    php56u-soap \
    php56u-mbstring \
    php56u-mcrypt


# Creates /tmp/composer.phar
RUN cd /tmp \
    && curl -LO https://getcomposer.org/installer \
    && php /tmp/installer

RUN cd /opt/mediawiki && git checkout tags/1.27.1 && php /tmp/composer.phar install
