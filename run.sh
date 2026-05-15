#!/usr/bin/with-contenv bashio
set +u

# Fetch configuration using bashio
OVPNFILE=$(bashio::config 'ovpnfile')
OPENVPN_CONFIG="/share/${OVPNFILE}"

bashio::log.info "Starting OpenVPN Client Add-on..."

################################################################################
# Initialize the tun interface
################################################################################
function init_tun_interface(){
    if [ ! -d /dev/net ]; then
        mkdir -p /dev/net
    fi

    if [ ! -c /dev/net/tun ]; then
        bashio::log.info "Creating TUN device..."
        mknod /dev/net/tun c 10 200
    fi
}

################################################################################
# Check if the .ovpn file exists in /share
################################################################################
function check_files_available(){
    if [[ ! -f "${OPENVPN_CONFIG}" ]]; then
        bashio::log.error "File ${OPENVPN_CONFIG} not found in /share"
        return 1
    fi
    return 0
}

################################################################################
# Main Loop: Wait for configuration then start OpenVPN
################################################################################

init_tun_interface

bashio::log.info "Waiting for OpenVPN configuration: ${OPENVPN_CONFIG}"

while ! check_files_available; do
    sleep 10
done

bashio::log.info "Configuration found! Launching OpenVPN..."

# Using exec ensures OpenVPN receives signals directly from the supervisor
exec openvpn --config "${OPENVPN_CONFIG}"