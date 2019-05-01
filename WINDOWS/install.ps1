Write-Output 'Start Installing Symantec on Windows...'
Write-Output 'Getting AWS Region'
$region = (Invoke-WebRequest -UseBasicParsing -Uri http://169.254.169.254/latest/dynamic/instance-identity/document | ConvertFrom-Json | Select region).region

Write-Output 'Setting AWS Region'
Write-Output $region
Set-DefaultAWSRegion -Region $region


Write-Output 'Getting S3Bucket from SSM '
$S3BUCKETLOCATION=(Get-SSMParameter -Name AgentInstallLocation).value
Write-Output $S3BUCKETLOCATION


#Hard Coded CID
Write-Output 'Downloading Agent'

$S3URL="https://s3.amazonaws.com/"
$FILENAME="/scwp_agent_windows_package.zip"
$S3URL=$S3URL + $S3BUCKETLOCATION + $FILENAME
 
(New-Object System.Net.WebClient).DownloadFile($S3URL,"C:\Windows\Temp\scwp_agent_windows_package.zip")

#Read-S3Object -BucketName $S3BUCKETLOCATION -Key scwp_agent_windows_package.zip -File c:\Windows\Temp\scwp_agent_windows_package.zip

Write-Output 'Extract Agent'

[System.Reflection.Assembly]::LoadWithPartialName("System.IO.Compression.FileSystem") | Out-Null
[System.IO.Compression.ZipFile]::ExtractToDirectory("c:\Windows\Temp\scwp_agent_windows_package.zip", "c:\Windows\Temp\")

# Not PS 5 Expand-Archive -LiteralPath c:\Windows\Temp\scwp_agent_windows_package.zip -DestinationPath c:\Windows\Temp\


Write-Output 'Install Agent'

Set-Location -Path "C:\Windows\Temp\"

.\installagent.bat


Write-Output 'Agent Install Done'

Write-Output 'Restarting'


Restart-Computer

# Add command to call installer.  For example "msiexec /i .\ExamplePackage.deb /quiet"