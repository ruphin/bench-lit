.PHONY: init
init:
	npm run build-prod

.PHONY: bench
bench: framework-arg
	npm run start > /dev/null &
	cd webdriver-ts && npm run selenium -- --headless --count 9 --framework $(FRAMEWORK)
	cd webdriver-ts && npm run results
	cp webdriver-ts-results/table.html results.html

.PHONY: benchall
benchall:
	npm run start > /dev/null &
	cd webdriver-ts && npm run selenium -- --headless --count 9
	cd webdriver-ts && npm run results
	cp webdriver-ts-results/table.html results.html

.PHONY: dockerinit
dockerinit:
	docker run -it --rm -v $$PWD:/app ruphin/webdev make init

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
ifndef FRAMEWORK
  $(error FRAMEWORK is undefined)
endif