# Change File Associations back to VSCode

The [Cursor AI Code Editor](https://www.cursor.com/) annoyingly sets all of the file extensions associated with VSCode to open with Cursor and changes all the default file specific icons to the cursor icon on MacOS (see https://github.com/getcursor/cursor/issues/1052). Resetting them all manually is frustrating. So this script automates the process of changing the default application for file extensions associated with the `Cursor` app back to `Visual Studio Code`. It uses macOS utilities such as `lsregister` to identify file associations and `duti` to update them. After making changes, it restarts Finder and Dock to apply the updates immediately.

Even after running the script, Finder will still show the Cursor icon on some of the files. Right click, and select "Get Info". The correct icon should be displayed in the left corner and then will update in the finder. Close and reopen Finder and it should update the rest. If there are some stragglers, rinse and repeat.

---

## Features

- Identifies all file extensions currently associated with the `Cursor` application.
- Updates the default application for these extensions to `Visual Studio Code`.
- Restarts Finder and Dock to ensure the changes take effect.

---

## Prerequisites

1. **macOS Utilities:**
   - Ensure you have `lsregister` available (part of macOS system utilities).
2. **Install `duti`:**
   - Install `duti` via Homebrew:

```bash
brew install duti
```

- Verify `duti` installation:

```bash
duti -v
```

3. **Visual Studio Code:**
   - Ensure `Visual Studio Code` is installed on your system.

---

## Installation

1. Clone or download the script to your local machine.
2. Make the script executable:
   ```bash
   chmod +x reset_exts.sh
   ```

---

## Usage

1. Run the script to update file associations:

```bash
./reset_exts.sh
```

2. The script will:
   - Find all file extensions associated with the `Cursor` app.
   - Change their default application to `Visual Studio Code`.
   - Restart Finder and Dock to apply changes immediately.

---

## Output

The script will output the extensions being processed, for example:

```
Processing extension: .svg
Processing extension: .md
Processing extension: .json
Restarting Finder and Dock to apply changes...
Update complete!
```

---

## Verification

To verify that the changes were successful, use the following command:

```bash
duti -x <extension>
```

For example:

```bash
duti -x svg
```

Expected output:

```
com.microsoft.VSCode
/Applications/Visual Studio Code.app
```

---

## Notes

- The script only updates extensions currently associated with `Cursor`.
- Ensure `Visual Studio Code` is properly installed; otherwise, the changes won't take effect.

---

## Troubleshooting

1. **`duti` Not Found:**
   - Ensure `duti` is installed via Homebrew:

```bash
brew install duti
```

2. **Changes Not Reflected:**
   - Manually restart Finder and Dock:

```bash
killall Finder
killall Dock
```

---

## License

This script is open-source and provided as-is. Feel free to modify and adapt it for your needs.
