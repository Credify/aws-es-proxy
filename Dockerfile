FROM docker-upgrade.artifactory.build.upgrade.com/go-builder:2.0.20230612.0-47.1.20.5-59 as build

WORKDIR /go/src/github.com/abutaha/aws-es-proxy
COPY --chown=upgrade:upgrade . .

RUN GOOS=linux go build -o aws-es-proxy

FROM docker-upgrade.artifactory.build.upgrade.com/container-base:2.0.20230320.0-48
LABEL name="aws-es-proxy"

COPY --from=build /go/src/github.com/abutaha/aws-es-proxy/aws-es-proxy /usr/local/bin/

ENV PORT_NUM 9200
EXPOSE ${PORT_NUM}

ENTRYPOINT ["aws-es-proxy"]
CMD ["-h"]
