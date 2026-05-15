#!/usr/bin/with-contenv bashio
set +u

bashio::log.info "--- OpenVPN Client Starting ---"

# 1. Get config name
OVPNFILE=$(bashio::config 'ovpnfile')

# 2. Local Test Fallback
if [ -z "$OVPNFILE" ] || [ "$OVPNFILE" == "null" ]; then
    bashio::log.yellow "Local Test Mode: Parsing options.json manually..."
    OVPNFILE=$(jq --raw-output '.ovpnfile' /data/options.json)
fi

OPENVPN_CONFIG="/share/${OVPNFILE}"

# 3. Initialize TUN
if [ ! -d /dev/net ]; then
    mkdir -p /dev/net
fi
if [ ! -c /dev/net/tun ]; then
    bashio::log.info "Creating TUN device..."
    mknod /dev/net/tun c 10 200
fi

# 4. Check file existence
if [[ ! -f "${OPENVPN_CONFIG}" ]]; then
    bashio::log.error "Configuration file ${OPENVPN_CONFIG} not found!"
    sleep 30
    exit 1
fi

bashio::log.info "Launching OpenVPN with ${OPENVPN_CONFIG}..."

# We use --dev tun here as a backup in case the .ovpn is missing it
exec openvpn --config "${OPENVPN_CONFIG}" --dev tun --cd /share