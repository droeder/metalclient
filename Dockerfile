FROM golang:1.18-alpine as base
RUN apk update && apk upgrade


FROM base as build
WORKDIR /install
COPY go.mod ./
COPY go.sum ./
RUN go mod download
COPY *.go ./
RUN go build -o metalclient

FROM build as runner
COPY --from=build /install/metalclient metalclient 
WORKDIR /app
RUN adduser -D worker
USER worker

CMD [ "./metalclient" ]