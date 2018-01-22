#!/bin/bash

if [ -n "${HTTPD_MODULES}" ]; then
    docker-httpd-module-enable $( echo "${HTTPD_MODULES}" | tr ',' ' ' )
fi
