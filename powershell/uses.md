# PowerShell Uses

Digital Forensics tasks where PowerShell can be helpful. 

## Retrieving Metadata

Retrieving metadata such as timestamps, file size, and file hashes. 

Some key commands include:

- `Get-ChildItem` to retrieve a list of files in a directory
- `Get-Item`  to retrieve metadata about a specific file
- `Get-Content` to retrieve the contents of a file
- `Get-FileHash` to compute the hash value of a file

## Creating Forensic Evidence Copies

PowerShell can help with creating forensic evidence copies of data on a system for analysis purposes.

Some key commands include:

- `New-Item` to create a directory to store the copy
- `Copy-Item` to copy the data to the new directory
- `Get-ChildItem` to verify that all files were copied successfully
- `Test-Path` to verify the existence of a file or directory, and to check if a file or directory exists at a given path
- `Write-Progress` to provide progress updates during the copying process
- `Compare-Object` to compare the hash values of two files and identify any differences or discrepancies between them. 

## File System Analysis

PowerShell can be used for disk and file system analysis to identify file types, deleted files, and other file system artifacts.

Some key commands include:

- `Get-Volume` to retrieve volume information such as drive letter, size, and file system type.
- `Get-Partition` to retrieve partition information such as disk number, partition size, and partition type.
- `Get-File` to retrieve information about a file such as file attributes, owner, and size.
- `Test-Path` to check the existence of a file or directory and validate a file or directory path.

## User Accounts and Security

PowerShell can help with enumerating and analyzing user accounts and security permissions on a system.

Some key commands include:

- `Get-LocalUser` to retrieve information about local user accounts such as the account name, description, and status.
- `Get-LocalGroup` to retrieve information about local groups such as the group name, description, and membership.
- `Get-Acl` to retrieve information about the access control list (ACL) for a file or directory.
- `Set-Acl` to set or modify the ACL for a file or directory.

## Event Log Analysis

PowerShell can be used to parse and analyze Windows event logs to identify suspicious activity or malware infections.

Some key commands include:

- `Get-EventLog` to retrieve event log data based on specified parameters such as the event log name, event ID, and time frame.
- `Select-Object` to filter and select specific properties from the retrieved event log data.
- `Where-Object` to filter event log data based on specified conditions such as event level or keyword.
- `Export-Csv` to export event log data to a CSV file for further analysis.

## Data Acquisition

PowerShell can help with automating data acquisition tasks such as copying files or extracting data from a system.

Some key commands include:

- `Copy-Item` to copy files or directories from one location to another.
- `Compress-Archive` to compress files or directories into a ZIP or CAB archive.
- `Expand-Archive` to extract files or directories from a compressed archive.
- `Invoke-WebRequest` to download files or web content from a URL.

## Memory Analysis

PowerShell can help with conducting memory analysis and live system triage to identify running processes, open network connections, and other system activity.

Some key commands include:

- `Get-Process` to retrieve information about running processes on a system such as process name, ID, and owner.
- `Get-NetTCPConnection` to retrieve information about open TCP connections on a system such as local and remote addresses and ports.
- `Get-NetUDPEndpoint` to retrieve information about open UDP endpoints on a system such as local and remote addresses and ports.
- `Get-WmiObject` to retrieve system information using Windows Management Instrumentation (WMI).
