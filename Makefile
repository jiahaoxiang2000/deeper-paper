# Makefile for Awards Viewing System

# Variables
PYTHON = python
BROWSER = open
EXTRACT_SCRIPT = utils/extract_awards.py
HTML_VIEWER = data/awards_viewer.html
CSV_OUTPUT = data/awards.csv
HTML_INPUT = temp/bestpapers.html
PORT = 8080

# Default target
.PHONY: all
all: extract view

# Extract awards data from HTML to CSV
.PHONY: extract
extract:
	@echo "Extracting awards data..."
	@cd $(dir $(EXTRACT_SCRIPT)) && $(PYTHON) $(notdir $(EXTRACT_SCRIPT))
	@echo "Extraction complete. Data saved to $(CSV_OUTPUT)"

# Start a Python HTTP server and open the awards viewer in the browser
.PHONY: view
view:
	@echo "Starting Python HTTP server on port $(PORT)..."
	@echo "Open your browser and navigate to: http://localhost:$(PORT)/data/awards_viewer.html"
	@echo "Press Ctrl+C to stop the server"
	@cd $$(pwd) && $(PYTHON) -m http.server $(PORT)

# Clean generated files
.PHONY: clean
clean:
	@echo "Cleaning up generated files..."
	@rm -f $(CSV_OUTPUT)
	@echo "Cleanup complete."

# Help target
.PHONY: help
help:
	@echo "Available targets:"
	@echo "  all      - Extract data and start server for viewing (default)"
	@echo "  extract  - Extract awards data from HTML to CSV"
	@echo "  view     - Start Python HTTP server to view awards in browser"
	@echo "  clean    - Remove generated CSV file"
	@echo "  help     - Display this help message"