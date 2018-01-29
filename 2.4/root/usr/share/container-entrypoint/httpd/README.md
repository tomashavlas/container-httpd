Apache 2.4 HTTPd server container image
=======================================

This container image includes Apache HTTPd server version 2.4 based on Debian.

The container image is available on [Docker Hub](https://hub.docker.com/r/tomashavlas/httpd) as
`tomashavlas/httpd:2.4-debian9`.


Description
-----------

[Apache HTTPd](https://httpd.apache.org) is a powerful, efficient, and extensible web server.

This container image provides containerized packaging of Apache HTTPd 2.4 daemon.
This image can be used as a base image for other applications based on Apache HTTPd 2.4, 
image can be extended using [source-to-image](https://github.com/openshift/source-to-image) tool.


Usage
-----

This image can be used as a base image for other applications based on Apache HTTPd server.

This will create container named `httpd` running Apache HTTPd, serving data from `/wwwdata` directory.
Port `8080` will be exposed and mapped to the host.

```
$ docker run -d --name httpd -p 8080:8080 -v /wwwdata:/srv/www:Z tomashavlas/httpd:2.4-debian9
```

This will create new Docker layered image named `httpd-app`, using source-to-image, while using data available in `/wwwdata` on the host.

```
$ s2i build file:///wwwdata tomashavlas/httpd:2.4-debian9 httpd-app
```

To run new image, simply execute:

```
$ docker run -d --name httpd -p 8080:8080 httpd-app
```


S2I source repository layout
----------------------------

This image can be extended using source-to-image tool (see Usage section).

Application source code should be located in the root of the source directory.

**`./.httpd/conf.d`**

Should contain additional Apache HTTPd configuration files (`*.conf`), those will be copied into `/etc/httpd/conf.d`.

**`./.httpd/default.d`**

Should contain additional configuration files for default virtual host (`*.conf`), those will be copied into `/etc/httpd/default.d`.

**`./.httpd/pre-init.d`**

Should contain custom container initialization scripts, those will be copied into `/usr/share/container-entrypoint/httpd/pre-init.d`.


Environment variables
---------------------

This images recognizes the following environment variables that can be set during initialization by passing `-e VAR=VALUE` to the Docker run command.

**`HTTPD_LOG_TO_VOLUME (default: 0)`**

If set to `1`, logs are stored in volume `/var/log/httpd`. Otherwise Apache HTTPd logs are redirected to `stdout` and `stderr`.

**`HTTPD_MODULES`**

List of Apache HTTPd modules that should be enabled (separated by comma).


Volumes
-------

The following mount points can be set by passing `-v /host/path:/container/path` to the Docker run command.

**`/srv/www`**

Apache HTTPd server data directory.

**`/var/log/httpd`**

Apache HTTPd server log directory, used only when `HTTPD_LOG_TO_VOLUME` is set to `1`.


Troubleshooting
---------------

The Apache HTTPd daemon in the container logs to the standard output by default, so the logs are available in container log.
The log can be examined by running:

```
$ docker logs <container>
```


See also
--------

Dockerfile and other sources for this container image are available on https://github.com/tomashavlas/container-httpd.
