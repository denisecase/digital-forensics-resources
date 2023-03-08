# Clear the terminal window
Clear-Host

# Write header to the console
Write-Output ""
Write-Output "------------------------------------------------------"
Write-Output "Starting CASE 200 CREATE EVIDENCE script"
Write-Output "------------------------------------------------------"
Write-Output "In a PowerShell terminal, run:"
Write-Output ".\200create.ps1"
Write-Output "------------------------------------------------------"
Write-Output ""


# Create the CASE200\documents folder representing
# evidence siezed from the suspect's computer
$count = 5
$evidencePath = ".\200evidence"
$folderNames = @("inbox", "sent", "drafts", "software", "jobs", "school", "hobby", "vault", "work", "home")
$subjects = @('Riley', 'Casey', 'she', 'he', 'Pat')
$nouns = @('car', 'house', 'book', 'computer', 'phone')
$verbs = @('run', 'jump', 'sing', 'read', 'write')
$adjectives = @('happy', 'sad', 'angry', 'tired', 'excited')
$prepositions = "with", "on", "for", "to", "from", "by", "about", "of"
$subject = $noun.Substring(0, 1).ToUpper() + $noun.Substring(1)
$predicate = $verb + "s"
$object = $adjective
$adverbs = @('barely', 'slowly', 'loudly', 'quietly', 'happily')
$folderMessage = @( "Hey, did you see this news article?", "Thanks for meeting with me today.", "I'm running late, can we reschedule?", "Got the goods - let's leave tonight!",
  "This is a rough draft of my proposal.", "I need your help with a project.", "I'm sorry for the confusion, let me clarify.", "Goods are six Ducati Superleggera V4.",
  "I have a new idea I want to run by you.", "I think we need to adjust our approach." )

foreach ($folder in $folderNames) {
  # Create the folder if it doesn't exist
  $folderPath = Join-Path $evidencePath $folder
  if (-not (Test-Path -Path $folderPath -PathType Container)) {
    New-Item -ItemType Directory -Path $folderPath # | Out-Null
  }
    
  # Create random files in the folder
  for ($i = 1; $i -le $count; $i++) {
    # Generate a random message for the file
    $subject = $subjects | Get-Random
    $noun = $nouns | Get-Random
    $verb = $verbs | Get-Random
    $adjective = $adjectives | Get-Random
    $adverb = $adverbs | Get-Random
    $subject = $subject.Substring(0, 1).ToUpper() + $subject.Substring(1)
    $predicate = $adverb + " " + $verb + "s"
    $object = $adjective + " " + $noun
    $preposition = $prepositions | Get-Random

    switch (Get-Random -Minimum 0 -Maximum 5) {
      0 { $message = "$subject $predicate $preposition $object." }
      1 { $message = "$subject $predicate $object." }
      2 { $message = "$subject $verb $preposition $object." }
      3 { $message = "$subject $verb $object." }
      4 { $message = "$preposition $object $verb $subject." }
    }
    $message = $message.Substring(0, 1).ToUpper() + $message.Substring(1)

    # Create the file with a random message as content
    $fileName = Join-Path $folderPath "$($i).txt"
    New-Item -ItemType File -Path $fileName #| Out-Null
    Set-Content -Path $fileName -Value $message
  }
    
  # Choose a random file to replace with the folder message
  $index = Get-Random -Minimum 1 -Maximum $count
  $fileName = Join-Path $folderPath "$($index).txt"
  Set-Content -Path $fileName -Value $folderMessage[$folderNames.IndexOf($folder)]
}

$targetFolder1 = Join-Path $evidencePath "software"
$targetFolder2 = Join-Path $evidencePath "vault"
Remove-Item -Path $targetFolder1 -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path $targetFolder2 -Recurse -Force -ErrorAction SilentlyContinue

