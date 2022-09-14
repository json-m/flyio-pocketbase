FROM golang:1.19.1-alpine3.15 as pbuilder
WORKDIR /opt/pocketbase

# pocketbase version to grab
ENV POCKETBASE_VERSION=0.7.2

# need to build in alpine or get a runtime problem related to musl
RUN apk add --no-cache git
RUN git clone --depth 1 --branch v${POCKETBASE_VERSION} https://github.com/pocketbase/pocketbase .
RUN cd examples/base && CGO_ENABLED=0 go build -o pocketbase -ldflags="-s -w"


# actual image here
FROM alpine:latest
WORKDIR /opt/pocketbase

COPY entrypoint.sh /opt/pocketbase/

# copy from build image
COPY --from=pbuilder /opt/pocketbase/examples/base/pocketbase /opt/pocketbase/pocketbase

# update perms
RUN chmod +x /opt/pocketbase/entrypoint.sh
RUN chmod +x /opt/pocketbase/pocketbase

# exec
EXPOSE 8090
ENTRYPOINT ["/opt/pocketbase/entrypoint.sh", "/opt/pocketbase/pocketbase", "serve", "--http [::]:8090"]
