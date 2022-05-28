FROM golang:1.18-alpine as base
RUN apk update && apk upgrade


FROM base as builder
WORKDIR /install
COPY go.mod ./
COPY go.sum ./
RUN go mod download
COPY *.go ./
RUN go build -o ./metalclient

FROM builder as runner
WORKDIR /app
COPY --from=builder /install/metalclient ./metalclient 
RUN adduser -D worker
USER worker

CMD [ "./metalclient" ]