```powershell
# generate-tfvars.ps1
# Generates terraform.tfvars from Book1.csv

$csvFile = "$(Build.SourcesDirectory)\Book1.csv"
$tfvarsFile = "$(Build.SourcesDirectory)\terraform.tfvars"

# Import CSV data
$data = Import-Csv $csvFile

# Start Terraform variables content
$tfvarsContent = "resource_groups = {`n"

# Process each CSV row
foreach ($row in $data) {

    $rgName = $row.Name.Trim()
    $location = $row.Location.Trim()

    $tfvarsContent += "  `"$rgName`" = {`n"
    $tfvarsContent += "    location = `"$location`"`n"
    $tfvarsContent += "  }`n"
}

# Close resource_groups block
$tfvarsContent += "}`n"

# Write terraform.tfvars file
Set-Content -Path $tfvarsFile -Value $tfvarsContent -Encoding UTF8

# Display success message
Write-Host "terraform.tfvars generated successfully:"
Write-Host "----------------------------------------"

# Display generated file content
Get-Content $tfvarsFile
```
