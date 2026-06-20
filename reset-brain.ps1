#!/usr/bin/env pwsh
<#
.SYNOPSIS
    Reset the Second Brain to an empty state by removing all user-generated content.

.DESCRIPTION
    This script removes all user-created files from the PARA folders while preserving:
    - Template files (template-*.md)
    - README.md files in Archives and Inbox
    - Agent configuration (.github/)
    - Root documentation (README.md, plan.md)
    - Log file structure (keeps headers, removes entries)

.NOTES
    WARNING: This operation cannot be undone!
    It is strongly recommended to commit your changes to git before running this script.
#>

# Script configuration
$ErrorActionPreference = "Stop"
$ConfirmPreference = "High"

# Define paths
$ScriptDir = $PSScriptRoot
$Folders = @("People", "Projects", "Areas", "Resources", "Ideas", "Archives", "Inbox")
$LogFiles = @("Logs\activity.log", "Logs\searches.log")

# Statistics
$FilesRemoved = 0
$Errors = 0

# Display warning
Write-Host "`n========================================" -ForegroundColor Yellow
Write-Host "  SECOND BRAIN RESET SCRIPT" -ForegroundColor Yellow
Write-Host "========================================`n" -ForegroundColor Yellow

Write-Host "WARNING: This will permanently delete all user-generated content!" -ForegroundColor Red
Write-Host "`nThis script will remove:" -ForegroundColor Cyan
Write-Host "  - All non-template files from People/, Projects/, Areas/, Resources/, Ideas/"
Write-Host "  - All content from Archives/ and Inbox/ (except README.md)"
Write-Host "  - All logged entries from activity.log and searches.log"
Write-Host "`nThis script will preserve:" -ForegroundColor Green
Write-Host "  - All template-*.md files"
Write-Host "  - README.md files in Archives/ and Inbox/"
Write-Host "  - All agent configuration (.github/)"
Write-Host "  - Root documentation (README.md, plan.md)"
Write-Host "  - Log file headers (frontmatter)"

Write-Host "`nRECOMMENDATION: Commit to git before proceeding!" -ForegroundColor Magenta
Write-Host ""

# Confirmation prompt
$Confirmation = Read-Host "Type 'RESET' to confirm deletion (or anything else to cancel)"

if ($Confirmation -ne "RESET") {
    Write-Host "`nOperation cancelled. No files were modified." -ForegroundColor Yellow
    exit 0
}

Write-Host "`nStarting reset process...`n" -ForegroundColor Green

# Function to safely remove a file
function Remove-SafeFile {
    param([string]$Path)
    
    try {
        if (Test-Path $Path) {
            Remove-Item -Path $Path -Force
            Write-Host "  [REMOVED] $Path" -ForegroundColor Gray
            return $true
        }
    }
    catch {
        Write-Host "  [ERROR] Failed to remove $Path : $_" -ForegroundColor Red
        $script:Errors++
        return $false
    }
    return $false
}

# 1. Remove user files from PARA folders
Write-Host "[1/3] Removing user-generated files from PARA folders..." -ForegroundColor Cyan

foreach ($Folder in $Folders) {
    $FolderPath = Join-Path $ScriptDir $Folder
    
    if (-not (Test-Path $FolderPath)) {
        Write-Host "  [SKIP] Folder not found: $Folder" -ForegroundColor Yellow
        continue
    }
    
    Write-Host "  Processing: $Folder/" -ForegroundColor White
    
    # Get all .md files in the folder
    $Files = Get-ChildItem -Path $FolderPath -Filter "*.md" -File
    
    foreach ($File in $Files) {
        $FileName = $File.Name
        
        # Preserve template files and README.md
        if ($FileName -like "template-*.md" -or $FileName -eq "README.md") {
            Write-Host "  [KEEP] $Folder/$FileName" -ForegroundColor Green
            continue
        }
        
        # Remove user file
        if (Remove-SafeFile -Path $File.FullName) {
            $FilesRemoved++
        }
    }
}

# 2. Truncate log files (keep frontmatter, remove entries)
Write-Host "`n[2/3] Truncating log files..." -ForegroundColor Cyan

foreach ($LogFile in $LogFiles) {
    $LogPath = Join-Path $ScriptDir $LogFile
    
    if (-not (Test-Path $LogPath)) {
        Write-Host "  [SKIP] Log file not found: $LogFile" -ForegroundColor Yellow
        continue
    }
    
    try {
        # Read all lines
        $Lines = Get-Content -Path $LogPath
        
        # Find the line with "---" (marks end of frontmatter)
        $FrontmatterEnd = -1
        for ($i = 0; $i -lt $Lines.Count; $i++) {
            if ($Lines[$i] -match "^---\s*$") {
                $FrontmatterEnd = $i
                break
            }
        }
        
        if ($FrontmatterEnd -ge 0) {
            # Keep only lines up to and including "---"
            $HeaderLines = $Lines[0..$FrontmatterEnd]
            Set-Content -Path $LogPath -Value $HeaderLines -Force
            Write-Host "  [TRUNCATED] $LogFile (kept header, removed entries)" -ForegroundColor Gray
        }
        else {
            Write-Host "  [SKIP] Could not find frontmatter delimiter in $LogFile" -ForegroundColor Yellow
        }
    }
    catch {
        Write-Host "  [ERROR] Failed to truncate $LogFile : $_" -ForegroundColor Red
        $Errors++
    }
}

# 3. Summary
Write-Host "`n[3/3] Reset complete!`n" -ForegroundColor Cyan

Write-Host "========================================" -ForegroundColor Green
Write-Host "  RESET SUMMARY" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host "Files removed: $FilesRemoved" -ForegroundColor White
Write-Host "Errors: $Errors" -ForegroundColor White

if ($Errors -eq 0) {
    Write-Host "`nYour Second Brain has been reset to empty state." -ForegroundColor Green
    Write-Host "Templates and system files have been preserved." -ForegroundColor Green
    exit 0
}
else {
    Write-Host "`nReset completed with errors. Please review the messages above." -ForegroundColor Yellow
    exit 1
}
