FROM docker-upgrade.artifactory.build.upgrade.com/go-builder:2.0.20230307.0-44.1.20.2-54 as build

WORKDIR /go/src/github.com/abutaha/aws-es-proxy
COPY --chown=upgrade:upgrade . .

RUN GOOS=linux go build -o aws-es-proxy

FROM docker-upgrade.artifactory.build.upgrade.com/container-base:2.0.20230307.0-44
LABEL name="aws-es-proxy"

COPY --from=build /go/src/github.com/abutaha/aws-es-proxy/aws-es-proxy /usr/local/bin/

ENV PORT_NUM 9200
EXPOSE ${PORT_NUM}

ENTRYPOINT ["aws-es-proxy"]
CMD ["-h"]
