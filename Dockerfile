FROM golang:1.23 AS build
WORKDIR /app
COPY go.mod main.go ./
COPY templates/ ./templates/
RUN CGO_ENABLED=0 go build -o app .

FROM scratch
COPY --from=build /app/app /app
COPY --from=build /app/templates /templates
ENTRYPOINT ["/app"]
