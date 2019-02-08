FROM elixir

# Set MIX_HOME outside of the user home directory.
ARG MIX_HOME=/.mix
ENV MIX_HOME=$MIX_HOME

# Set MIX_ENV to "dev" by default.
ARG MIX_ENV=dev
ENV MIX_ENV=$MIX_ENV

# Install rebar and hex locally in MIX_HOME.
RUN mix local.rebar --force
RUN mix local.hex --force

# Copy our entrypoint script.
COPY entrypoint.sh /entrypoint.sh

# Set the entrypoint script as our entrypoint.
ENTRYPOINT ["/entrypoint.sh"]
