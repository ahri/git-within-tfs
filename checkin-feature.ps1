$path = Split-Path ($MyInvocation.MyCommand.Definition) -Parent
Import-Module $path\Git-Within-Tfs

Exit-IfGitNotClean
Invoke-GitFeatureCheckin
