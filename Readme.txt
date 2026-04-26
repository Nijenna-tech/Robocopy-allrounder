# Nijenna Robocopy Allrounder

! USE AT YOUR OWN RISK !
I am not responsible for any data loss or damage caused by using this script.

A robust and easy-to-use Windows Batch script for automated file synchronization and backups using the powerful Microsoft Robocopy engine.

## Key Features
* **User-Friendly:** Simple prompts for Source and Destination paths.
* **Automatic Logging:** Creates a dedicated log folder in your Documents and saves detailed timestamps for every run.
* **High Performance:** Uses Multi-Threading (`/MT:16`) for faster data transfer.
* **Resilient:** Includes retry logic for locked files and ignores Junction Points to prevent infinite loops.
* **Metadata Preservation:** Copies all file attributes, timestamps, and security ACLs.

## How to Use
1. Right-click `Nijenna Robocopy Allrounder.bat` and **Run as Administrator** (required for copying system attributes/ACLs).
2. Enter the **Source Path** (where the files are).
3. Enter the **Destination Path** (where the backup should go).
4. The script will start the process and show a live status in the console.

## Customization: Switching /E to /MIR
The script is currently configured with the `/E` flag for safety. You can find these flags in the `robocopy` line at the bottom of the script.

### Option 1: `/E` (Default - Safe Backup)
* **What it does:** Copies all subdirectories, including empty ones.
* **The Result:** It only adds or updates files at the destination. It **never deletes** anything from the destination, even if you deleted it from the source.

### Option 2: `/MIR` (Mirroring - Synchronization)
* **How to change:** Replace `/E` with `/MIR` in the code.
* **What it does:** Mirrors a directory tree (equivalent to `/E` plus `/PURGE`).
* **The Result:** **CAUTION!** This will delete files at the destination if they no longer exist in the source. It ensures the destination is an exact 1:1 copy of the source.

## Important Switches Explained
* `/ZB`: Uses "Restartable" mode; if a transfer is interrupted, it can pick up where it left off.
* `/COPYALL`: Copies Data, Attributes, Timestamps, Security (ACLs), Owner info, and Auditing info.
* `/MT:16`: Enables multi-threaded copying with 16 threads for better speed.
* `/XJ`: Excludes Junction Points (prevents errors with recursive system folders).

---
*Created by Nijenna-tech*