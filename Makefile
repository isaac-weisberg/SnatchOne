BUILD_DIR=./.build

default: build

build:
	swift build

test:
	swift test

update:
	swift package update

release:
	swift build -c release

clean:
	-rm -rf $(BUILD_DIR)/*