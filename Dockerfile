FROM ghcr.io/home-assistant/base:latest

# Force a fresh build by changing this date
# LAST_MODIFIED: 2026-05-15
ENV LANG=C.UTF-8

# Install requirements
RUN apk --no-cache upgrade && \
    apk --no-cache add jq openvpn

# Clean up
RUN rm -Rf /tmp/*

# Create S6 service structure
# This is the standard for modern HA Add-ons
RUN mkdir -p /etc/services.d/openvpn-client
COPY run.sh /etc/services.d/openvpn-client/run
RUN chmod a+x /etc/services.d/openvpn-client/run

# Explicitly set the ENTRYPOINT to the S6 init binary.
# This ensures S6 starts as PID 1 and manages our 'run' script as a service.
ENTRYPOINT [ "/init" ]