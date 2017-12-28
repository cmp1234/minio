FROM cmp1234/alpine-base:3.6

ENV GOPATH /go
ENV PATH $PATH:$GOPATH/bin
ENV CGO_ENABLED 0

WORKDIR /go/src/github.com/minio/

RUN  \
     apk add --no-cache ca-certificates su-exec && \
     apk add --no-cache --virtual .build-deps git go musl-dev && \
     go get -v -d github.com/cmp1234/minio && \
     cd /go/src/github.com/minio/minio && \
     go install -v -ldflags "-X github.com/cmp1234/minio/cmd.Version=2017-04-29T00:40:27Z -X github.com/cmp1234/minio/cmd.ReleaseTag=RELEASE.2017-04-29T00-40-27Z -X github.com/minio/minio/cmd.CommitID=eb50175ad911d496bf583a599de89547f0c9be89" && \
     rm -rf /go/pkg /go/src /usr/local/go && apk del .build-deps

EXPOSE 9000
ENTRYPOINT ["minio"]
VOLUME ["/export"]
