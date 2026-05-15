FROM ghcr.io/home-assistant/base:latest
RUN apk --no-cache add jq openvpn
COPY rootfs /
RUN chmod a+x /etc/s6-overlay/s6-rc.d/openvpn-client/run
