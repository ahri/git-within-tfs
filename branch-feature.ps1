Param(
    [Parameter(Mandatory=$True, Position=1)]
    [string]$to_branch,

    [Parameter(Mandatory=$False, Position=2)]
    [string]$from_branch
)

$path = Split-Path ($MyInvocation.MyCommand.Definition) -Parent
Import-Module $path\TFS-Git-Ilb

Exit-IfGitNotClean
Invoke-GitCheckoutOffBranch $to_branch $from_branch