<#
.SYNOPSIS
    Bulk assign Microsoft 365 licenses to migrated users.
.DESCRIPTION
    This script connects to Microsoft Graph, reads a CSV file containing user Principal Names (UPNs),
    and assigns a specified license (e.g., Business Basic or E3) to all users. 
    Ideal for the cutover phase of a G Suite to M365 migration.
.AUTHOR
    Eslam - System Administrator
#>

# Connect to Microsoft Graph with necessary scopes
Connect-MgGraph -Scopes "User.ReadWrite.All", "Directory.ReadWrite.All"

# Variables
$CsvPath = "C:\Migration\MigratedUsers.csv"
$LicenseSkuId = "resourcename:ENTERPRISEPACK" # Replace with your specific License SkuId (e.g., Office 365 E3)

# Import the CSV file (Expected header: UserPrincipalName)
$Users = Import-Csv -Path $CsvPath

# Loop through each user and assign the license
foreach ($User in $Users) {
    $UPN = $User.UserPrincipalName
    
    try {
        Write-Host "Assigning license to $UPN..." -ForegroundColor Cyan
        
        Set-MgUserLicense -UserId $UPN -AddLicenses @{SkuId = $LicenseSkuId} -RemoveLicenses @()
        
        Write-Host "Successfully assigned license to $UPN" -ForegroundColor Green
    }
    catch {
        Write-Host "Failed to assign license to $UPN. Error: $_" -ForegroundColor Red
    }
}

Write-Host "License assignment process completed." -ForegroundColor Yellow
Disconnect-MgGraph
