# should this work out what branch it's come off? i.e. go off and rebase an Epic and then the Story?

$path = Split-Path ($MyInvocation.MyCommand.Definition) -Parent
Import-Module $path\TFS-Git-Ilb

Invoke-GitRebaseStripped