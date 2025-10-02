# Import user data from csv file
$users = Import-Csv -Path "./users.csv"

# Ensure mock_directory exists
if (!(Test-Path "./mock_directory")) {
    New-Item -ItemType Directory -Path "./mock_directory" | Out-Null
}

# Output log file
$logFile = "./user_creation_log.txt"
"User Creation Log - $(Get-Date)" | Out-File $logFile

foreach ($user in $users){
    $username = $user.UserPrincipalName

    # Normalize Department (capitalize first letter)
    $department = (Get-Culture).TextInfo.ToTitleCase($user.Department.ToLower())

    # Enabled check
    $status = if ($user.Enabled -match "^true$") { "Enabled" } else { "Disabled" }

    if (Test-Path "./mock_directory/$username.txt") {
        "$username already exists. Overwriting..." | Tee-Object -FilePath $logFile -Append
    } else {
        "$username does not exist. Creating new file..." | Tee-Object -FilePath $logFile -Append
    }

    try {
        # Always overwrite user file
        $userDetails = @"
FirstName: $($user.FirstName)
LastName: $($user.LastName)
Department: $department
Status: $status
Created: $(Get-Date)
"@

        $userDetails | Out-File "./mock_directory/$username.txt"

        "$username created/updated successfully." | Tee-Object -FilePath $logFile -Append
    }
    catch {
        $errorMsg = $_.Exception.Message
        "Error creating/updating ${username}: $errorMsg" | Tee-Object -FilePath $logFile -Append
    }
}

"Process finished. See $logFile for details."
