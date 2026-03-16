# RemyScoop

A custom Scoop bucket for installing specific applications.

## How to Make Scoop Packages Easily (Short Summary)

Creating a Scoop package (manifest) is surprisingly easy. It is essentially writing a simple JSON file that tells Scoop where to download a program and how to install it.

### 1. The Structure
Every package manifest requires at least three fields:
- `version`: The program's version.
- `url`: Direct link to download the installer or zip.
- `hash`: The SHA256 checksum of the file (to verify it hasn't been tampered with).

### 2. Basic JSON (Portable App)
For apps packaged in a `.zip` file, scoop will extract it naturally:
```json
{
    "version": "1.0",
    "url": "https://example.com/app.zip",
    "hash": "YOUR_SHA_256_HASH_HERE",
    "bin": "MyProgram.exe"
}
```
The `bin` field tells Scoop to add this executable to your system PATH.

### 3. Installing Exe/Msi (Silent Installations)
If the program comes as an `.exe` installer (like InnoSetup, NSIS), you need to tell Scoop how to run it silently so it installs without prompting you.

```json
{
    "version": "1.0",
    "architecture": {
        "64bit": {
            "url": "https://example.com/installer-64.exe",
            "hash": "YOUR_SHA_256_HASH_HERE"
        }
    },
    "installer": {
        "args": [
            "/VERYSILENT",
            "/DIR=\"$dir\""
        ]
    }
}
```
- `installer`: Passes arguments like `/VERYSILENT` to bypass the setup wizard.
- `$dir`: A special variable Scoop uses to tell the installer to install the app into Scoop's default directory rather than `C:\Program Files`. 

### 4. How to Test Your Package
- Use PowerShell to check your file hash: `(Get-FileHash app.exe).Hash`
- Put the `.json` file in a repository (or local folder).
- Run `scoop install .\mypackage.json` locally to verify it works!

### Adding Your Bucket to Scoop
To use this bucket from elsewhere:
```powershell
scoop bucket add RemyScoop https://github.com/RemySkye/RemyScoop.git
scoop install RemyScoop/kushview.element
```