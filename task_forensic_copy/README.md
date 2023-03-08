# Case 001: Creating a Forensic Copy

This repository contains three PowerShell scripts that can be used to:

1. Create sample evidence for Case 001 as though we've retrieved evidence from the field.
2. Generate and verify a valid forensic copy of the evidence, so we don't risk the original.
3. Recheck our working copy to ensure it still matches the original evidence.
4. Undo our work and delete all the generated folders.

## Script 001create.ps1

This script creates a sample evidence folder with some test files and subfolders for case 001.

To run this script:

1. Open PowerShell.
2. Navigate to the directory containing the script.
3. Run the script by entering `.\001create.ps1` and pressing Enter.

The script will create a folder called `001_Evidence` in the same directory as the script.

## Script 001fc.ps1

This script creates a forensic copy of the 001_Evidence folder and 
verifies its integrity by comparing it to the original folder using file hashes.

To run this script:

1. Open PowerShell.
2. Navigate to the directory containing the script.
3. Run the script by entering `.\001fc.ps1` and pressing Enter.

The script will:

1. Create a folder called `001_Evidence_Copy_<date>` in the same directory as the script.
1. Copy all contents of the `001_Evidence` folder to the `001_Evidence_Copy_<date>` folder.
1. Verify the integrity of the forensic copy.
1. Create a folder called `001_Evidence_Out_<date>` in the same directory as the script.
1. Create an output file named hashes.csv with the results.

## Script 001recheck.ps1

This script will recheck our forensic copy still exactly matches the evidence. 
If not it'll report on the differences. 

To run this script:

1. Open PowerShell.
2. Navigate to the directory containing the script.
3. Run the script by entering `.\001recheck.ps1` and pressing Enter.

## Script 001undo.ps1

This script deletes the `001_Evidence` and `001_Forensic_Copy_<date>` folders created in the previous steps.

To run this script:

1. Open PowerShell.
2. Navigate to the directory where the `001undo.ps1` script is located.
3. Run the command `.\001undo.ps1`.

Running this script will permanently delete the `001_Evidence` and `001_Forensic_Copy_<date>` folders and all their contents. 
Make sure you've verified the contents of the forensic copy 
and no longer need the evidence, the copy, or the output results before running it.

