# Case 200: PowerShell File Recovery

This repository contains PowerShell scripts that can be used to:

1. Create sample evidence for Case 200 as though we've retrieved evidence from the field.
2. Recover deleted evidence.
3. Undo our work and delete all the generated folders.

## Script 200create.ps1

This script creates a sample evidence folder with some test files and subfolders for Case 200.

To run this script:

1. Open PowerShell.
2. Navigate to the directory containing the script.
3. Run the script by entering `.\200create.ps1` and pressing Enter.

The script will create a folder called `200_Evidence` in the same directory as the script.

## Script 200undo.ps1

This script deletes the `200_Evidence` folders created in the previous steps.

To run this script:

1. Open PowerShell.
2. Navigate to the directory where the `001undo.ps1` script is located.
3. Run the command `.\200undo.ps1`.

:warning: Running this script will delete the `200_Evidence folders and all their contents, recursively.
Exercise caution before running it.

