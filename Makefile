.PHONY: init
init:
	npm install
	cd webdriver-ts && npm install
	cd webdriver-ts-results && npm install
	for dir in frameworks/*/*; do ( cd $$dir && npm install && npm run build-prod ); done

.PHONY: update
update: framework-arg
	for dir in frameworks/*/$$FRAMEWORK; do ( cd $$dir && npm install && npm run build-prod ); done

.PHONY: bench
bench: framework-arg
	npm run start > /dev/null &
	cd webdriver-ts && npm run selenium -- --headless --count 9 --framework $(FRAMEWORK)
	kill -9 $$(ps aux | grep '\snode /app/node_modules/.bin/http-server -c-1\s' | awk '{print $$2}')
	cd webdriver-ts && npm run results
	cp webdriver-ts-results/table.html results.html

.PHONY: benchall
benchall:
	npm run start > /dev/null &
	cd webdriver-ts && npm run selenium -- --headless --count 9
	kill -9 $$(ps aux | grep '\snode /app/node_modules/.bin/http-server -c-1\s' | awk '{print $$2}')
	cd webdriver-ts && npm run results
	cp webdriver-ts-results/table.html results.html

.PHONY: dockerinit
dockerinit:
	docker run -it --rm -v $$PWD:/app ruphin/webdev make init

.PHONY: dockerupdate
dockerupdate: framework-arg
	docker run -it --rm -v $$PWD:/app -e FRAMEWORK="$(FRAMEWORK)" ruphin/webdev make update

.PHONY: dockerbench
dockerbench: framework-arg
	docker run -it --rm -v $$PWD:/app -e FRAMEWORK="$(FRAMEWORK)" ruphin/webdev make bench

.PHONY: dockerbenchall
dockerbenchall:
	docker run -it --rm -v $$PWD:/app ruphin/webdev make benchall

.PHONY: dev
dev:
	docker run -it --rm -v $$PWD:/app -p 5000:8080 ruphin/webdev npm run start

.PHONY: shell
shell:
	docker run -it --rm -v $$PWD:/app ruphin/webdev bash

.PHONY: framework-arg
framework-arg:
	@ if [ "${FRAMEWORK}" = "" ]; then \
		echo "ERROR: FRAMEWORK ENV variable not set"; \
		exit 1; \
	fi