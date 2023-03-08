# Clear the terminal window
Clear-Host

# Write header to the console
Write-Output ""
Write-Output "------------------------------------------------------"
Write-Output "Starting CASE 001 CREATE EVIDENCE script"
Write-Output "------------------------------------------------------"
Write-Output "In a PowerShell terminal, run:"
Write-Output ".\001create.ps1"
Write-Output "------------------------------------------------------"
Write-Output ""

# Set the path to the evidence folder
$folderPath = ".\001_Evidence"

# Create the evidence folder if it doesn't already exist
if (!(Test-Path $folderPath)) {
    # Test-Path $folderPath is a PowerShell cmdlet 
    # that checks if a file or folder exists at the specified path. 
    # It returns a boolean value (True or False) 
    # depending on whether the file or folder exists. 
    # In this case,
    # it is used to check if a folder already exists at $folderPath.
    # and if not (see the leading !),
    # it creates the folder using the New-Item cmdlet.

    New-Item -ItemType Directory -Path $folderPath | Out-Null
    # The -ItemType parameter specifies the type of item to create. 
    # In this case, it's a directory.
    # The -Path parameter specifies the path where the item should be created.
    # The | Out-Null at the end of the command 
    # is used to suppress the output from the command,
    # so that it doesn't clutter the console or pipeline output.
}

# Create some sample files in the evidence folder
# for i = 1 to less than or equal to 5, increasing by 1 each time
for ($i = 1; $i -le 5; $i++) {

    # Create a file with the name "file_i.txt"
    $fileName = "file_$i.txt"

    # Join the folder path and file name together
    $filePath = Join-Path $folderPath $fileName

    # Create the file
    Set-Content -Path $filePath -Value "This is a sample file number $i"
    # Set-Content is a PowerShell cmdlet that creates a file
    # and writes the specified content to it.
    # The -Path parameter specifies the path to the file to create.
    # The -Value parameter specifies the content to write to the file.

}

Write-Output "Done. See the evidence folder at $folderPath."
