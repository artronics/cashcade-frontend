clean:
	rm -rf build dist

build: clean
	npm run build
	cp -r public dist
