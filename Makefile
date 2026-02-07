JOBS ?= 4

.PHONY: iwyu
iwyu:
	docker run --rm -v "$(PWD)":/code -w /code vim-centos10-dev \
		/usr/local/bin/iwyu_tool.py -p build/compile_commands.json -j $(JOBS)
