# Clear the terminal window
Clear-Host

# Write header to the console
write-output ""
Write-Output "------------------------------------------------------"
Write-Output "Starting CASE 001 FORENSIC COPY script"
Write-Output "------------------------------------------------------"
write-output "In a PowerShell terminal, run:"
Write-Output ".\001fc.ps1"
Write-Output "------------------------------------------------------"
write-output ""

# Set the paths for the evidence, forensic copy, and output folders
$evidencePath = ".\001_Evidence"
$evidenceCopyPath = ".\001_Evidence_Copy_$(Get-Date -Format yyyy-MM-dd)"
$evidenceOutPath = ".\001_Evidence_Out_$(Get-Date -Format yyyy-MM-dd)"

# Create the forensic copy folder if it doesn't already exist
if (!(Test-Path $evidenceCopyPath)) {
    New-Item -ItemType Directory -Path $evidenceCopyPath | Out-Null
}
# Create the forensic output folder if it doesn't already exist
if (!(Test-Path $evidenceOutPath)) {
    New-Item -ItemType Directory -Path $evidenceOutPath | Out-Null
}

Write-Host "Copying contents of $evidencePath to $evidenceCopyPath..."

# Copy the contents of the evidence folder to the forensic copy folder
Get-ChildItem -Path $evidencePath -Recurse | Copy-Item -Destination $evidenceCopyPath -Recurse -Force

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
# In this case, the value of the parameter is $evidenceCopyPath.

# -Recurse
# A switch that tells Copy-Item to copy all subdirectories and files.

# -Force
# A switch that tells Copy-Item to overwrite files if they already exist.


# Verify the integrity of the forensic copy
Write-Host "Verifying integrity of the forensic copy..."

# Calculate the hashes of the evidence along with the short file name
$fileHash = @{Name='Hash';Expression={(Get-FileHash $_.FullName).Hash}} 
$baseName = @{Name='BaseName';Expression={$_.BaseName}}
$evidenceItems = Get-ChildItem -Path $evidencePath -Recurse
$hashes = $evidenceItems | Select-Object $baseName, $fileHash

# Calculate the hashes of the forensic copy along with the short file name
$copyHashes = Get-ChildItem -Path $evidenceCopyPath -Recurse | Where-Object { -not $_.PSIsContainer } | Select-Object $baseName, $fileHash

# Write the hashes to csv files in the output folder
$hashes | Export-Csv -Path "$evidenceOutPath\hashes_evidence.csv" -NoTypeInformation
$copyHashes | Export-Csv -Path "$evidenceOutPath\hashes_copy.csv" -NoTypeInformation

# Compare the hashes between the evidence and forensic copy
$hashComparison = Compare-Object -ReferenceObject $hashes -DifferenceObject $copyHashes -Property Hash, BaseName

# Write the differences to a csv file in the output folder
$hashComparison | Export-Csv -Path "$evidenceOutPath\hashes_diff.csv" -NoTypeInformation

# Count the number of differences (one line for each hash or each side of the comparison)
$diffCount = $hashComparison.Count /2 
Write-Output "Differences found: $diffCount"

if ($diffCount -eq 0) {
  Write-Host "Evidence copy verified successfully!"
  Write-Output "See the evidence copy at $evidenceCopyPath."
} else {
  Write-Host "Evidence copy verification failed: $diffCount differences found."
  $diffOutput = @()
  foreach ($diff in $hashComparison) {
     $diffOutput += $diff
  }
  Write-Output "The following differences were found:"
  Write-Output $diffOutput
}