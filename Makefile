BUILD_DIR=./.build

default: build

build:
	swift build

test:
	swift test

update:
	swift package update

clean:
	-rm -rf $(BUILD_DIR)/*