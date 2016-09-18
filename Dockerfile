FROM trenpixster/elixir:1.3.2
EXPOSE 4000
ADD . /app
WORKDIR /app
RUN mix local.hex --force
RUN mix deps.get --only-prod
RUN MIX_ENV=prod mix compile
CMD MIX_ENV=prod ["mix", "phoenix.server"]
