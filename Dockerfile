FROM ghcr.io/home-assistant/base:latest

# Install requirements
RUN apk --no-cache add jq openvpn

# Copy the rootfs folder into the container root
COPY rootfs /

# Ensure the 'run' script is executable
RUN chmod a+x /etc/s6-overlay/s6-rc.d/openvpn-client/run