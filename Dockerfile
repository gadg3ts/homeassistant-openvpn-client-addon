FROM ghcr.io/home-assistant/base:latest

# Install requirements
RUN apk --no-cache add jq openvpn

# Copy root filesystem
COPY rootfs /

# Ensure the 'run' script is executable (NEW PATH)
RUN chmod a+x /etc/services.d/openvpn-client/run