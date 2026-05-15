#!/usr/bin/with-contenv bashio
# Ensure there are NO blank lines or comments before the shebang above.

set +u

# Fetch config using bashio
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
# Use 'exec' here to replace the shell process with OpenVPN
exec openvpn --config "${OPENVPN_CONFIG}"
