# file_manager.sh

A simple terminal file manager written in Bash.
You can browse folders and check file info — no mouse needed.

## What it does

- Shows all files and folders in the current directory
- You can move up and down the list with arrow keys
- Enter a folder by pressing Enter
- Go back to the parent folder with Backspace
- Shows read, write, and execute permissions for each item
- Shows the file extension type

## How to use

Make the script executable first:
```bash
chmod +x file_manager.sh

Then run it:

bash
./file_manager.sh

## Keyboard shortcuts

| Key        | Action                    |
|------------|---------------------------|
| ↑ / ↓      | Move up or down the list  |
| Enter      | Open a folder             |
| Backspace  | Go to parent folder       |
| h          | Show help screen          |
| q          | Quit                      |

## Requirements

- Bash 4.0 or higher
- A standard Unix terminal (Linux or macOS)

## Known limits

- Hidden files (dotfiles) are not shown
- Empty folders may cause display issues
- Backspace key may not work on all systems

## Planned features

- Open and view text files
- Rename and delete files
- Create new fil
- Empty folders may cause display issues
- Backspace key may not work on all systems

## Planned features

- Open and view text files
- Rename and delete files
- Create new file
