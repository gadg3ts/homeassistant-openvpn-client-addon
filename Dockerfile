FROM ghcr.io/home-assistant/base:latest

# Cache Buster - change this whenever you push a big fix
ENV LAST_FIX_DATE="2026-05-15-V3"
ENV LANG=C.UTF-8

# Install requirements
RUN apk --no-cache upgrade && \
    apk --no-cache add jq openvpn

# Clean up
RUN rm -Rf /tmp/*

# Create S6 service structure
RUN mkdir -p /etc/services.d/openvpn-client
COPY run.sh /etc/services.d/openvpn-client/run
RUN chmod a+x /etc/services.d/openvpn-client/run

# CRITICAL: This ensures the S6 supervisor is the ONLY thing that starts
ENTRYPOINT [ "/init" ]