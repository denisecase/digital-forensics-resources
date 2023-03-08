# Clear the terminal window
Clear-Host

# Write header to the console
write-output ""
Write-Output "------------------------------------------------------"
Write-Output "Starting CASE 001 FORENSIC COPY script"
Write-Output "------------------------------------------------------"
write-output "In a PowerShell terminal, run:"
Write-Output ".\fc001.ps1"
Write-Output "------------------------------------------------------"
write-output ""

# Set the paths for the evidence, forensic copy, and output folders
$evidencePath = ".\001_Evidence"
$forensicCopyPath = ".\001_Evidence_Copy_$(Get-Date -Format yyyy-MM-dd)"
$forensicCopyOutPath = ".\001_Evidence_Out_$(Get-Date -Format yyyy-MM-dd)"

# Create the forensic copy folder if it doesn't already exist
if (!(Test-Path $forensicCopyPath)) {
    New-Item -ItemType Directory -Path $forensicCopyPath | Out-Null
}
# Create the forensic output folder if it doesn't already exist
if (!(Test-Path $forensicCopyOutPath)) {
    New-Item -ItemType Directory -Path $forensicCopyOutPath | Out-Null
}

Write-Host "Copying contents of $evidencePath to $forensicCopyPath..."

# Copy the contents of the evidence folder to the forensic copy folder
Get-ChildItem -Path $evidencePath -Recurse | Copy-Item -Destination $forensicCopyPath -Recurse -Force

# ------------------------------------------------------------
# Here's a breakdown of the Get-Child command:
# ------------------------------------------------------------

# Get-ChildItem
# Command that lists items (files and folders) in a specified directory. 

# -Path
# Parameter to the Get-ChildItem command that specifies the directory to list items from.
# In this case, the value of the parameter is $evidencePath. 

# -Recurse
# A switch that tells Get-ChildItem to search recursively through all subdirectories.

# |
# The pipeline operator
# Which passes the results of the previous command (Get-ChildItem) 
# to the next command (Copy-Item).

# Copy-Item
# Command that copies an item (file or folder) to a specified location.

# -Destination
# Parameter to the Copy-Item command that specifies the destination path.
# In this case, the value of the parameter is $forensicCopyPath.

# -Recurse
# A switch that tells Copy-Item to copy all subdirectories and files.

# -Force
# A switch that tells Copy-Item to overwrite files if they already exist.


# Verify the integrity of the forensic copy
Write-Host "Verifying integrity of the forensic copy..."

# Recurse through all child items in the evidence folder and 
# call Get-FileHash on each one to return a default hash value (SHA256)
$hashes = Get-ChildItem -Path $evidencePath -Recurse | Get-FileHash

# Pipe the hashes to Export-Csv to save them to a CSV file
$hashes | Export-Csv -Path "$forensicCopyOutPath\hashes.csv" -NoTypeInformation

# ------------------------------------------------------------
# Here's a breakdown of the above command:
# ------------------------------------------------------------

# $hashes
# Variable that stores the results of the Get-FileHash command.

# |
# The pipeline operator
# Which passes the results of the previous command (Get-FileHash)
# to the next command (Export-Csv).

# Export-Csv
# Command that exports objects to a CSV file.

# -Path
# Parameter to the Export-Csv command that specifies the path to the CSV file.
# In this case, the value of the parameter is "$forensicCopyOutPath\hashes.csv".

# -NoTypeInformation
# A switch that tells Export-Csv to not include type information in the CSV file.

$copyHashes = Get-ChildItem -Path $forensicCopyPath -Recurse | Where-Object { -not $_.PSIsContainer } | Get-FileHash

# ------------------------------------------------------------
# Here's a breakdown of the above command:
# ------------------------------------------------------------

# Get-ChildItem
# Command that lists items (files and folders) in a specified directory.

# -Path
# Parameter to the Get-ChildItem command that specifies the directory to list items from.
# In this case, the value of the parameter is $forensicCopyPath.

# -Recurse
# A switch that tells Get-ChildItem to search recursively through all subdirectories.

# |
# The pipeline operator
# Which passes the results of the previous command (Get-ChildItem)
# to the next command (Where-Object).

# Where-Object
# Command that filters objects based on a specified condition.
# In this case, the condition is that the object is not a container (folder).

# $_.PSIsContainer 

# $_ is a variable that represents the current object in the pipeline.
# PSIsContainer is a property of the object that is true if the object is a container (folder).

# |
# The pipeline operator
# Which passes the results of the previous command (Where-Object)
# to the next command (Get-FileHash).
# In this case, the results of the Where-Object command are all files in the forensic copy folder.

# Get-FileHash
# Command that calculates the hash value of a file.
# Uses the default hash algorithm (SHA256).


$hashComparison = Compare-Object -ReferenceObject $hashes -DifferenceObject $copyHashes -Property Hash

# ------------------------------------------------------------
# Here's a breakdown of the above command:
# ------------------------------------------------------------

# Compare-Object
# Command that compares two objects and returns the differences.
# In this case, the two objects are the hashes of the evidence folder and the forensic copy folder.
# The differences are the files that have different hashes.

# -ReferenceObject
# Parameter to the Compare-Object command that specifies the reference object.
# In this case, the value of the parameter is $hashes.

# -DifferenceObject
# Parameter to the Compare-Object command that specifies the difference object.
# In this case, the value of the parameter is $copyHashes.

# -Property
# Parameter to the Compare-Object command that specifies the property to compare.
# In this case, the value of the parameter is Hash.

# Hash 
# Hash is a property of the object that is the hash value of the file.

# $hashComparison
# Variable that stores the results of the Compare-Object command.
# In this case, the results are the files that have different hashes.
# The results are stored as a collection of objects.
# Each object has the following properties:
#   InputObject
#   SideIndicator
#   Position
#   Line
#   SideIndicator

# $hashComparison.Count is the number of differences found.
$diffCount = $hashComparison.Count

if ($diffCount -eq 0) {
  Write-Host "Forensic copy verified successfully!"
  Write-Output "See the forensic copy at $forensicCopyPath."
} else {
  Write-Host "Forensic copy verification failed: $diffCount differences found."

  # Create an array to store the file paths of the files that have differences
  # @() is an array literal
  $diffOutput = @()

  # Loop through the $hashComparison collection of objects
  foreach ($diff in $hashComparison) {

    # Add the file path of the file that has a difference to the $diffOutput array
     $diffOutput += $diff.InputObject.FullName
  }
  Write-Output "The following files/folders have differences:"
  Write-Output $diffOutput
}
