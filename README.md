# UserProvisioner

A simple PowerShell automation script for batch user provisioning, simulating Microsoft 365 / Active Directory workflows.  
This project demonstrates **automation, overwrite logic, data normalization, and account status management**.

---

## Features
- Import user data from CSV  
- Create or update user accounts (overwrite if existing)  
- Normalize department names (capitalize first letter)  
- Handle account status (`TRUE/FALSE` → Enabled/Disabled)  
- Log all operations (new, overwrite, errors)  

---

## Example CSV (`users.csv`)
```csv
FirstName,LastName,UserPrincipalName,Department,Enabled
Alice,Smith,alice.smith@abc.com,hr,TRUE
Bob,Johnson,bob.johnson@abc.com,IT,FALSE
Charlie,Black,charlie.black@abc.com,Finance,TRUE
```

## Usage

1. Place ```Create-MockUsers.ps1``` and ```users.csv``` in the same directory.
2. Open PowerShell and navigate to the project folder: ```cd "C:\path\to\project"```
3. Allow script execution for the session: ```Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass```
4. Run the script: ```.\Create-MockUsers.ps1```

## Output

- mock_directory/ → Contains generated user files.
- user_creation_log.txt → Detailed log of new, updated, or failed operations.

Example log:
```
alice.smith@abc.com does not exist. Creating new file...
alice.smith@abc.com created/updated successfully.
bob.johnson@abc.com does not exist. Creating new file...
bob.johnson@abc.com created/updated successfully.
charlie.black@abc.com does not exist. Creating new file...
charlie.black@abc.com created/updated successfully.
Process finished. See ./user_creation_log.txt for details.
```

Notes

- This is a simulation project (no real M365/AD integration).

- For real environments, replace mock file operations with ```New-MgUser```, ```Set-MgUser```, or ```Enable/Disable-ADUser```.
