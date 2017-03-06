FROM jamesmontalvo3/meza-docker-pre-yum:latest
MAINTAINER James Montalvo
ENV container=docker

RUN git clone https://gerrit.wikimedia.org/r/p/mediawiki/core.git /opt/mediawiki

RUN cd /opt/mediawiki/extensions \
    && git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/ParserFunctions.git \
    && git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/StringFunctionsEscaped.git \
    && git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/ExternalData.git \
    && git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/LabeledSectionTransclusion.git \
    && git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/Cite.git \
    && git clone https://github.com/enterprisemediawiki/ParserFunctionHelper.git \
    && git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/WhoIsWatching.git \
    && git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/CharInsert.git \
    && git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/SemanticForms.git \
    && git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/SemanticInternalObjects.git \
    && git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/SemanticCompoundQueries.git \
    && git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/Arrays.git \
    && git clone https://github.com/enterprisemediawiki/TalkRight.git \
    && git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/AdminLinks.git \
    && git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/DismissableSiteNotice.git \
    && git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/BatchUserRights.git \
    && git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/HeaderTabs.git \
    && git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/WikiEditor.git \
    && git clone https://github.com/jamesmontalvo3/MediaWiki-CopyWatchers.git CopyWatchers \
    && git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/SyntaxHighlight_GeSHi.git \
    && git clone https://github.com/enterprisemediawiki/Wiretap.git \
    && git clone https://github.com/jamesmontalvo3/MediaWiki-ApprovedRevs.git ApprovedRevs \
    && git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/InputBox.git \
    && git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/ReplaceText.git \
    && git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/Interwiki.git \
    && git clone https://github.com/enterprisemediawiki/MasonryMainPage.git \
    && git clone https://github.com/enterprisemediawiki/WatchAnalytics.git \
    && git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/Variables.git \
    && git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/YouTube.git \
    && git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/ContributionScores.git \
    && git clone https://github.com/jamesmontalvo3/MediaWiki-PipeEscape.git PipeEscape\
    && git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/UniversalLanguageSelector.git \
    && git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/VisualEditor.git \
    && git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/Elastica.git \
    && git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/CirrusSearch.git \
    && git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/Echo.git \
    && git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/Thanks.git \
    && git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/UploadWizard \
    && git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/CollapsibleVector \
    && git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/Math.git \
    && git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/DataTransfer.git

# Install node/npm, install parsoid and dependencies
RUN yum --enablerepo epel install -y nodejs npm
RUN git clone https://gerrit.wikimedia.org/r/p/mediawiki/services/parsoid /etc/parsoid \
    && cd /etc/parsoid && git checkout dd8e644d320aec076f76da4e2bd70a8527e0dfd8 \
    && npm install

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

RUN cd /opt/mediawiki && php /tmp/composer.phar install
