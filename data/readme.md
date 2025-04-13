# Data Viewer

## Viewing Awards

To view the awards, you can use Python's built-in HTTP server. This will serve the files in the current directory, making them accessible through a web browser.

### Steps:

1. Open a terminal or command prompt
2. Navigate to the directory containing the award files:
   ```
   cd /path/to/awards/directory
   ```
3. Start the Python HTTP server:
   ```
   python -m http.server
   ```
   If you're using Python 2, use:
   ```
   python -m SimpleHTTPServer
   ```
4. Open your web browser and navigate to:
   ```
   http://localhost:8000
   ```

The server will run until you stop it (using Ctrl+C in the terminal). You can access any HTML files or other web content in the directory through your browser.

## Additional Information

- By default, the server runs on port 8000. To use a different port, specify it after the command:
  ```
  python -m http.server 80
  ```
- The server provides directory listings, allowing you to navigate through the file structure.
