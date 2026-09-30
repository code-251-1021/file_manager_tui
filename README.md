# Bash TUI File Manager

A minimal terminal-based file manager written in pure Bash. It uses an event loop and ANSI sequences to navigate directories without external libraries.

## Logic Overview

1. Event Loop: Captures raw keyboard input using `read -srn1` and parses escape sequences for arrow keys.
2. State Management: Uses indexed arrays to store directory contents and tracks position with a pointer variable.
3. Safe Globbing: Handles empty folders and filenames with spaces using `shopt -s nullglob` and strict variable quoting.

## Controls

* Up / Down: Navigate files
* Enter: Open directory
* Backspace: Go to parent directory
* h: Show help
* q: Exit

## Practice Exercises (Code Challenges)

Improve your Bash skills by implementing these features:

1. Toggle hidden files using `shopt -s dotglob` with a dedicated hotkey.
2. Add safe boundary checks for empty directories (`${#array[@]} -eq 0`).
3. Display file sizes using `stat` or `wc -c`.
4. Handle terminal resizing events by trapping `SIGWINCH`.
5. Add a pagination system to avoid visual overflow when a directory contains many files.

## Usage
```bash
chmod +x file_manager.sh
./file_manager.sh
