$path = Split-Path ($MyInvocation.MyCommand.Definition) -Parent
Import-Module $path\TFS-Git-Ilb

Exit-IfGitNotClean
Invoke-GitFeatureCheckin