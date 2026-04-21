.PHONY: build clean run install test

# Executable name
BINARY = common-rate

# Installation directory
PREFIX ?= /usr/local
BINDIR = $(PREFIX)/bin

# Build the executable
build: $(BINARY)

$(BINARY): build.lisp common-rate.asd src/*.lisp
	sbcl --non-interactive --load build.lisp

# Run from source (development)
run:
	sbcl --eval "(require :asdf)" \
		 --eval "(load \"~/quicklisp/setup.lisp\")" \
		 --eval "(push #p\"$(PWD)/\" asdf:*central-registry*)" \
		 --eval "(ql:quickload :common-rate)" \
		 --eval "(common-rate:main)"

# Run the built executable
run-bin: $(BINARY)
	./$(BINARY)

# Install to system
install: $(BINARY)
	install -d $(DESTDIR)$(BINDIR)
	install -m 755 $(BINARY) $(DESTDIR)$(BINDIR)/

# Uninstall from system
uninstall:
	rm -f $(DESTDIR)$(BINDIR)/$(BINARY)

# Clean build artifacts
clean:
	rm -f $(BINARY)
	rm -rf ~/.cache/common-lisp/sbcl-*/**/common-rate/

# Load and test in REPL
repl:
	sbcl --eval "(require :asdf)" \
		 --eval "(load \"~/quicklisp/setup.lisp\")" \
		 --eval "(push #p\"$(PWD)/\" asdf:*central-registry*)" \
		 --eval "(ql:quickload :common-rate)"

# Check syntax without running
check:
	sbcl --eval "(require :asdf)" \
		 --eval "(load \"~/quicklisp/setup.lisp\")" \
		 --eval "(push #p\"$(PWD)/\" asdf:*central-registry*)" \
		 --eval "(ql:quickload :common-rate)" \
		 --eval "(sb-ext:exit)"

help:
	@echo "Common-Rate - A LazyGit-style Git TUI in Common Lisp"
	@echo ""
	@echo "Targets:"
	@echo "  build    - Build standalone executable"
	@echo "  run      - Run from source (requires Quicklisp)"
	@echo "  run-bin  - Run the built executable"
	@echo "  install  - Install to $(BINDIR)"
	@echo "  uninstall- Remove from $(BINDIR)"
	@echo "  clean    - Remove build artifacts"
	@echo "  repl     - Start SBCL with common-rate loaded"
	@echo "  check    - Check if code compiles"
	@echo "  help     - Show this help"
