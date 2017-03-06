Meza Docker Test-Max
====================

[![Docker Automated build](https://img.shields.io/docker/automated/jamesmontalvo3/meza-docker-test-max.svg?maxAge=2592000)](https://hub.docker.com/r/jamesmontalvo3/meza-docker-test-max/)

Docker image for [meza](https://github.com/enterprisemediawiki/meza) installations, based upon [jamesmontalvo3/meza-docker-pre-yum](https://github.com/jamesmontalvo3/meza-docker-pre-yum), which aims to do whatever possible to speed up installation for the sake of fast testing, without compromising the quality of the tests. Currently that includes:

* git-clone MediaWiki into another directory, such that tests can simply move the files into place. Then the meza installation will simply verify the repo is in the correct config.
* git-clone many extensions
