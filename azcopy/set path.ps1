# set a variable pointing at your AzCopy directory
$azCopyPath = 'C:\Program Files (x86)\Microsoft SDKs\Azure\AzCopy\'

# AS ADMIN, appends $azCopyPath variable contents to system PATH variable
[Environment]::SetEnvironmentVariable("PATH", "$($env:PATH);$azCopyPath", "Machine")

# if you've got chocolatey, this is a handy way to clear cached variables and refresh them within the same process
refreshenv