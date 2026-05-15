#!/usr/bin/with-contenv bashio
set +u

bashio::log.info "Starting OpenVPN Client Add-on..."

# Fetch the filename from addon options
OVPNFILE=$(bashio::config 'ovpnfile')
OPENVPN_CONFIG="/share/${OVPNFILE}"

# Initialize the TUN interface for the VPN
if [ ! -d /dev/net ]; then
    mkdir -p /dev/net
fi
if [ ! -c /dev/net/tun ]; then
    bashio::log.info "Creating TUN device node..."
    mknod /dev/net/tun c 10 200
fi

# Verify the .ovpn file exists in the /share folder
if [[ ! -f "${OPENVPN_CONFIG}" ]]; then
    bashio::log.error "-------------------------------------------------------"
    bashio::log.error "FATAL: Configuration file ${OPENVPN_CONFIG} not found!"
    bashio::log.error "Please ensure your .ovpn file is in the /share directory."
    bashio::log.error "-------------------------------------------------------"
    sleep 30
    exit 1
fi

bashio::log.info "Launching OpenVPN with configuration: ${OPENVPN_CONFIG}"

# Use exec so OpenVPN becomes the main process of this S6 service
exec openvpn --config "${OPENVPN_CONFIG}" --cd /share