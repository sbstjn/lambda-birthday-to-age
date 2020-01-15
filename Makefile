.PHONY: deps test clean build deploy

deps:
	@ go get -u ./...

test:
	@ go test ./...

clean:
	@ rm -rf ./dist
	
build: clean
	@ CGO_ENABLED=0 GOOS=linux GOARCH=amd64 \
		go build \
		-a -installsuffix cgo -ldflags="-w -s" \
		-o ./dist/handler ./src

deploy:
	@ sam deploy