FROM docker-upgrade.artifactory.build.upgrade.com/go-builder:2.0.20200722.0-212.1.15.2-214 as build

WORKDIR /go/src/github.com/abutaha/aws-es-proxy
COPY . .

RUN GOOS=linux go build -o aws-es-proxy

FROM docker-upgrade.artifactory.build.upgrade.com/container-base:2.0.20200722.0-212
LABEL name="aws-es-proxy"

COPY --from=build /go/src/github.com/abutaha/aws-es-proxy/aws-es-proxy /usr/local/bin/

ENV PORT_NUM 9200
EXPOSE ${PORT_NUM}

ENTRYPOINT ["aws-es-proxy"]
CMD ["-h"]
