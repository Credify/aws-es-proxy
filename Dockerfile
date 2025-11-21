FROM 118455887602.dkr.ecr.us-west-2.amazonaws.com/releases/images/go-builder-2023:20251120102341-0a8c2773 as build

WORKDIR /go/src/github.com/abutaha/aws-es-proxy
COPY --chown=upgrade:upgrade . .

RUN go build -o aws-es-proxy

FROM 118455887602.dkr.ecr.us-west-2.amazonaws.com/releases/images/container-base-2023:20251119100956-8cb95e90
LABEL name="aws-es-proxy"

COPY --from=build /go/src/github.com/abutaha/aws-es-proxy/aws-es-proxy /usr/local/bin/

ENV PORT_NUM 9200
EXPOSE ${PORT_NUM}

ENTRYPOINT ["aws-es-proxy"]
CMD ["-h"]
