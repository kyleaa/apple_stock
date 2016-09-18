FROM trenpixster/elixir:1.3.2
EXPOSE 4000
ADD . /app
WORKDIR /app
ENV MIX_ENV=prod
ENV URL_PATH=/apple-stock
RUN mix local.hex --force
RUN mix deps.get --only-prod
RUN mix compile
CMD ["mix", "phoenix.server"]
