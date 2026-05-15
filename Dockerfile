FROM ghcr.io/home-assistant/base:latest

# Install requirements
RUN apk --no-cache add jq openvpn

# Copy rootfs
COPY rootfs /

# Set script location (moving it to / for simplicity)
RUN cp /etc/s6-overlay/s6-rc.d/openvpn-client/run /run.sh && chmod a+x /run.sh

# Explicitly tell Docker to run this script as PID 1
ENTRYPOINT ["/run.sh"]