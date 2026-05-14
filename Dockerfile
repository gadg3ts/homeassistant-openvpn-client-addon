FROM ghcr.io/home-assistant/base:latest

ENV LANG=C.UTF-8

# Install requirements for add-on
RUN apk --no-cache --no-progress upgrade && \
    apk --no-cache --no-progress add jq openvpn
RUN rm -Rf /tmp/*

# Copy data for add-on
COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "exec /run.sh" ]
