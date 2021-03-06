#Basic makefile

default: build

build: clean vet
	@echo "Building application"
	@go build -o marble-go

doc:
	@godoc -http=:6060 -index

lint:
	@golint ./...

debug_server: 
	@watcher
debug_assets:
	@gulp watch

#run 'make -j2 debug' to launch both servers in parallel
debug: clean debug_server debug_assets 

run: build
	./marble-go

test:
	@go test ./...

vet:
	@go vet ./...

clean:
	@echo "Cleaning binary"
	@rm -f ./marble-go

stop: 
	@echo "Stopping marble_go service"
	@sudo systemctl stop marble_go

start:
	@echo "Starting marble_go service"
	@sudo systemctl start marble_go

pull:
	@echo "Pulling origin"
	@git pull origin master

pull_restart: stop pull clean build start