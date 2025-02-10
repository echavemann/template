.PHONY: install
install:
	conan install . --build=missing

.PHONY: build
build: install
	cd build && cmake .. -DCMAKE_TOOLCHAIN_FILE=Release/generators/conan_toolchain.cmake -DCMAKE_BUILD_TYPE=Release -G Ninja
	cd build && cmake --build . -j

.PHONY: test
test: build
	cd build && ./template_tests

.PHONY: lint-check
lint-check:
	run-clang-tidy -j $(shell nproc) -p build

.PHONY: format-check
format-check:
	find src tst -name '*.cpp' -o -name '*.hpp' | xargs clang-format --style=file --Werror --dry-run

.PHONY: format
format:
	find src tst -name '*.cpp' -o -name '*.hpp' | xargs clang-format --style=file -i
	run-clang-tidy -fix -j $(shell nproc) -p build

.PHONY: clean
clean:
	rm -rf build

