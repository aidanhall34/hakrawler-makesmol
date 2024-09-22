FROM golang:1.17 AS build

WORKDIR /go/src/hakrawler
COPY . .

RUN go get -d -v ./...
RUN go install -v ./...

FROM gcr.io/distroless/static-debian12 AS release
COPY --from=build /go/bin/hakrawler /bin/hakrawler
ENTRYPOINT ["/bin/hakrawler"]
