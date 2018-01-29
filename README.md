Apache HTTPd server container image
===================================

[![Build Stauts](https://api.travis-ci.org/tomashavlas/container-httpd.svg?branch=master)](https://travis-ci.org/tomashavlas/container-httpd/)

This repository contains Dockerfiles and scripts for Apache HTTPd container images based on Debian.


Versions
--------

Apache HTTPd versions provided:

* [HTTPd 2.4](2.4)

Debian versions supported:

* Debian 9 "Stretch"


Installation
------------

* **Debain 9 based image**

    This image is available on DockerHub. To download it run:
    
    ```
    $ docker pull tomashavlas/httpd:2.4-debian9
    ```
    
    To build latest Debian based Apache HTTPd image from source run:
    
    ```
    $ git clone --recursive https://github.com/tomashavlas/container-httpd
    $ cd container-httpd
    $ git submodule update --init
    $ make build TARGET=debian9 VERSION=2.4
    ```
    
To build other version of Apache HTTPd just replace `2.4` value by particular version in commands above.

    
Usage
-----

For information about usage of Dockerfile for Apache HTTPd 2.4 see [usage documentation](2.4).


Test
----

This repository also provides a test framework, which checks basic functionality of Apache HTTPd image.

* **Debain 9 based image**

    ```
    $ cd container-httpd
    $ make test TARGET=debian9 VERSION=2.4
    ```


Credits
-------

This project is derived from [`httpd-container`](https://github.com/sclorg/httpd-container) by
[SoftwareCollections.org](https://www.softwarecollections.org).
