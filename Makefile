VERSION := rust-v0.19.1
URL := https://github.com/Stranger6667/css-inline/archive/refs/tags/$(VERSION).zip
SRC_DIR := css-inline-$(VERSION)
LIB_DIR := css-inline

ifeq ($(shell uname),Darwin)
	EXT := dylib
else ifeq ($(OS),Windows_NT)
	EXT := dll
else
	EXT := so
endif

LIB := $(LIB_DIR)/bindings/c/target/release/libcss_inline.$(EXT)

all: $(LIB)

$(LIB_DIR):
	curl -sL $(URL) -o css-inline.zip
	unzip -qo css-inline.zip
	rm css-inline.zip
	mv $(SRC_DIR) $(LIB_DIR)

$(LIB): $(LIB_DIR)
	cd $(LIB_DIR)/bindings/c && cargo build --release

clean:
	rm -rf $(LIB_DIR)

.PHONY: all clean
