#!/bin/bash

[ -n "${_LIBHTTPD}" ] && return || readonly _LIBHTTPD=1

function httpd_config_log_to_volume() {
    sed -Ei 's!^(\s*ErrorLog)\s+\S+!\1 "'"${HTTPD_LOG_PATH}"'/error_log"!g' "${HTTPD_CONF_PATH}/httpd.conf"
    sed -Ei 's!^(\s*CustomLog)\s+\S+(\s+\S+)!\1 "'"${HTTPD_LOG_PATH}"'/access_log"\2!g' "${HTTPD_CONF_PATH}/httpd.conf"
}

function httpd_module_disable() {
    local module="$1"; shift

    if [ -f "${HTTPD_MODULESD_PATH}/${module}.load" ]; then
        rm "${HTTPD_MODULESD_PATH}/${module}.load"

        if [ -f "${HTTPD_MODULESD_PATH}/${module}.conf" ]; then
            rm "${HTTPD_MODULESD_PATH}/${module}.conf"
        fi
    fi
}

function httpd_module_enable() {
    local module="$1"; shift

    if [ -f "${HTTPD_MODULESD_PATH}/../modules.available.d/${module}.load" ]; then
        ln --symbolic "../modules.available.d/${module}.load" "${HTTPD_MODULESD_PATH}/${module}.load"

        if [ -f "${HTTPD_MODULESD_PATH}/../modules.available.d/${module}.conf" ]; then
            ln --symbolic "../modules.available.d/${module}.conf" "${HTTPD_MODULESD_PATH}/${module}.conf"
        fi
    fi
}

function httpd_process_config_files() {
    local directory="${1:-.}"

    if [ -d "${directory}/conf.d" ]; then
        if [ "$( ls -A "${directory}/conf.d"/*.conf )" ]; then
            cp --verbose "${directory}/conf.d"/*.conf "${HTTPD_CONFD_PATH}"
            rm --force --recursive "${directory}/conf.d"
        fi
    fi

    if [ -d "${directory}/default.d" ]; then
        if [ "$( ls -A "${directory}/default.d"/*.conf )" ]; then
            cp --verbose "${directory}/default.d"/*.conf "${HTTPD_DEFAULTD_PATH}"
            rm --force --recursive "${directory}/default.d"
        fi
    fi
}

function httpd_process_hook_files() {
    local directory="${1:-.}"

    if [ -d "${directory}/pre-init.d" ]; then
        if [ "$( ls -A "${directory}/pre-init.d"/*.sh )" ]; then
            cp --verbose "${directory}/pre-init.d"/*.sh "${CONTAINER_ENTRYPOINT_PATH}/httpd/pre-init.d"
            rm --force --recursive "${directory}/pre-init.d"
        fi
    fi
}
