$path = Split-Path ($MyInvocation.MyCommand.Definition) -Parent
Import-Module $path\TFS-Git-Ilb

### roll out master
Invoke-NativeCommand git checkout -f master # ~ 239s

### Get the latest copy of the source
Invoke-GitTfsPull

### first time we create the TFS-Stripped branch
Invoke-GitBranchStripped # ~ 1s
Invoke-GitCheckoutStripped # ~ 1s
Invoke-Git ls-files *.sln *.csproj *.vdproj *scc | & $path\tfs-strip.ps1 # ~48s
Invoke-GitCommitStripped # ~3s