$evidencePath = ".\200evidence"
$folderNames = @("inbox", "sent", "drafts", "software", "jobs","school", "hobby","vault","work","home")

foreach ($folder in $folderNames) {
    # Get the folder path
    $folderPath = Join-Path $evidencePath $folder
    
    # Confirm the deletion with the user
    $confirmMessage = "Are you sure you want to delete folder '$folderPath' and its contents? (Y/N)"
    $userChoice = Read-Host -Prompt $confirmMessage
    
    if ($userChoice -eq "Y" -or $userChoice -eq "y") {
        # Delete the folder and its contents recursively
        if (Test-Path -Path $folderPath -PathType Container) {
            Remove-Item -Path $folderPath -Recurse -Force
        }
    } else {
        Write-Host "Deletion of folder '$folderPath' cancelled by user."
    }
}
