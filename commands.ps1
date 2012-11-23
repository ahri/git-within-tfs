$self = $MyInvocation.MyCommand.Definition
$path = Split-Path $self -Parent

Write-host "Setting aliases:"
Get-ChildItem $path | Where-Object { $_.Name -like '*.ps1' } | Foreach-Object {
    # Can't just use a "continue" to reduce nesting; http://poshoholic.com/2007/08/31/essential-powershell-understanding-foreach-addendum/
    if (($_.FullName -ne $self) -and ($_.Name -ne "init-repo.ps1")) {
        $alias = $_.Name -Replace '\.ps1$', ''
        Write-Host "    "$alias
        Set-Alias $alias $_.FullName
    }
}