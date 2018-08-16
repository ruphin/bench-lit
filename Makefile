.PHONY: dev
dev:
	docker run -it --rm -v $$PWD:/app -p 5000:8080 ruphin/webdev npm run start

.PHONY: shell
shell:
	docker run -it --rm -v $$PWD:/app ruphin/webdev bash
