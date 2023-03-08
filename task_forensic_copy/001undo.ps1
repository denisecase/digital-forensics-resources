# Clear the terminal window
Clear-Host

# Write header to the console
Write-Output ""
Write-Output "------------------------------------------------------"
Write-Output "Starting CASE 001 UNDO script"
Write-Output "------------------------------------------------------"
Write-Output "In a PowerShell terminal, run:"
Write-Output ".\001undo.ps1"
Write-Output "------------------------------------------------------"
Write-Output ""

# Set the evidence ID
$evidenceID = "001_Evidence"

# Remove all directories that start with "001_Evidence" recursively
# from the root directory of the PowerShell script being run
Get-ChildItem -Path $PSScriptRoot -Directory -Recurse -Filter "001_Evidence*" | Remove-Item -Recurse -Force

# ------------------------------------------------------------
# Here's a breakdown of the Get-Child command:
# ------------------------------------------------------------
# Get-ChildItem
# Command that lists items (files and folders) in a specified directory. 

# -Path
# Parameter to the Get-ChildItem command that specifies the directory to list items from.
# In this case, the value of the parameter is $PSScriptHost. 

# $PSScriptRoot 
# A built-in variable containing the path to the directory 
# where the PowerShell script is being run.

# -Directory
# A switch that tells Get-ChildItem to only return directories (folders).
# A switch is a parameter that doesn't take a value.

# -Recurse
# A switch that tells Get-ChildItem to search recursively through all subdirectories.

# -Filter
# A parameter that filters the results based on a specified string. 
# In this case, the value is "001_Evidence*".

# "001_Evidence*"
# A regular expression
# Meaning 
# Starts with "001_Evidence" 
# followed by the asterisk, which means "zero or more characters".

# |
# The pipeline operator
# Which passes the results of the previous command (Get-ChildItem) 
# to the next command (Remove-Item).

# Remove-Item
# Command that removes an item (file or folder) from the file system.

# -Recurse
# switch that tells Remove-Item to remove the item and all its contents, 
# including any subdirectories, recursively.

# -Force
# switch that tells Remove-Item to remove the item forcefully,
# without prompting for confirmation.
