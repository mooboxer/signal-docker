FROM openjdk
#FROM ibmjava

# Install signald
ARG SIGNALD_VERSION=0.6.2
    
#RUN wget https://github.com/AsamK/signal-cli/releases/download/v${SIGNALD_VERSION}/signal-cli-${SIGNALD_VERSION}.tar.gz \
RUN curl -fLo signal-cli-${SIGNALD_VERSION}.tar.gz https://github.com/AsamK/signal-cli/releases/download/v${SIGNALD_VERSION}/signal-cli-${SIGNALD_VERSION}.tar.gz \
    && tar xf signal-cli-${SIGNALD_VERSION}.tar.gz -C /opt \
    && ln -sf /opt/signal-cli-${SIGNALD_VERSION}/bin/signal-cli /usr/local/bin/ \
    && rm signal-cli-${SIGNALD_VERSION}.tar.gz

# Add signal user so we aren't running as root.
RUN useradd --home-dir /signal --no-create-home signal
WORKDIR /signal

# Create configuration for signald-bash
RUN chown signal:signal /signal -R

USER signal
RUN mkdir attachents

#ENTRYPOINT ["/usr/local/bin/signal-cli"]
CMD ["/usr/local/bin/signal-cli"]