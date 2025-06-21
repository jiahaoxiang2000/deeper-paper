# Makefile for Awards Viewing System

.PHONY: setup clean help test run

# Default target
help:
	@echo "Available targets:"
	@echo "  setup     - Set up the development environment and install dependencies"
	@echo "  clean     - Clean up temporary files and caches"
	@echo "  help      - Show this help message"

# Setup development environment
setup:
	@echo "Setting up development environment..."
	@echo "Installing dependencies with uv..."
	uv sync
	@echo "Creating necessary directories..."
	@mkdir -p downloads
	@echo "Setup complete!"

# Clean up temporary files
clean:
	@echo "Cleaning up..."
	@find . -type f -name "*.pyc" -delete
	@find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
	@find . -type d -name ".pytest_cache" -exec rm -rf {} + 2>/dev/null || true
	@rm -rf .coverage
	@rm -rf htmlcov/
	@echo "Cleanup complete!"