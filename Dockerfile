FROM ghcr.io/home-assistant/base:latest

ENV LANG=C.UTF-8

# Install requirements 
RUN apk --no-cache --no-progress upgrade && \
    apk --no-cache --no-progress add jq openvpn

# Clean up
RUN rm -Rf /tmp/*

# Create the S6 service directory
RUN mkdir -p /etc/services.d/openvpn-client

# Copy the script as the S6 'run' file
COPY run.sh /etc/services.d/openvpn-client/run
RUN chmod a+x /etc/services.d/openvpn-client/run

# No CMD or ENTRYPOINT needed; the base image handles it.
