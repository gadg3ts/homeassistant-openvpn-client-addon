FROM ghcr.io/home-assistant/base:latest

ENV LANG=C.UTF-8

# Install requirements for add-on
RUN apk --no-cache --no-progress upgrade && \
    apk --no-cache --no-progress add jq openvpn

# Clean up
RUN rm -Rf /tmp/*

# Create S6 service directory
# This tells the init system to manage our script as a service
RUN mkdir -p /etc/services.d/openvpn-client

# Copy run.sh to the service directory and rename it to 'run'
COPY run.sh /etc/services.d/openvpn-client/run
RUN chmod a+x /etc/services.d/openvpn-client/run

# No CMD or ENTRYPOINT needed as the base image provides /init