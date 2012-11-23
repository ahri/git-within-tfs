$path = Split-Path ($MyInvocation.MyCommand.Definition) -Parent
Import-Module $path\TFS-Git-Ilb

Exit-IfGitNotClean

$branch = Get-GitBranch
Invoke-Git checkout master
Invoke-GitTfsPull
Invoke-GitCheckoutStripped

# Grab the changes since the branch was taken that we need to strip
$changes = Invoke-Git log TFS-Stripped..master --name-only --format="%n" | Where { $_ -match "(\.sln|\.csproj|\.vdproj|scc)$" }
Invoke-Git rebase master
$changes | & $path\tfs-strip.ps1
Invoke-GitCommitStripped

Invoke-Git checkout $branch