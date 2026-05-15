#!/usr/bin/with-contenv bashio
set +u

# Fetch config using bashio for better stability in HA
OVPNFILE=$(bashio::config 'ovpnfile')
OPENVPN_CONFIG="/share/${OVPNFILE}"

# Initialize the tun interface
if [ ! -d /dev/net ]; then
    mkdir -p /dev/net
fi
if [ ! -c /dev/net/tun ]; then
    mknod /dev/net/tun c 10 200
fi

# Wait for file to exist
bashio::log.info "Searching for: ${OPENVPN_CONFIG}"
while [[ ! -f "${OPENVPN_CONFIG}" ]]; do
    bashio::log.yellow "Waiting for config file... check your /share folder."
    sleep 10
done

bashio::log.info "Starting OpenVPN connection..."
openvpn --config "${OPENVPN_CONFIG}"
