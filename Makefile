bootstrap:
	mix deps.get && mix deps.compile

deps.update:
	mix deps.clean --unused && mix deps.get && mix deps.compile

format:
	mix format

credo:
	mix credo

.PHONY: test
test:
	MIX_ENV=test mix test

coverage:
	MIX_ENV=test mix coveralls.html --umbrella

coverage.show:
	command -v sensible-browser &> /dev/null \
	&& sensible-browser ./cover/excoveralls.html \
	|| open ./cover/excoveralls.html
