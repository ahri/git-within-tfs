$stripped_branch = "TFS-Stripped"
$strip_commit = "[[[[[ TFS BINDINGS STRIPPED ]]]]]"

Function Invoke-NativeCommand {
  $command = $args[0]
  $arguments = $args[1..($args.Length)]
  & $command @arguments
  if ($LastExitCode -ne 0) {
    #Write-Error "Exit code $LastExitCode while running $command $arguments"
    Exit $LastExitCode
  }
}

Function Invoke-GitTolerant {
    git @args
}

Function Invoke-Git {
    Invoke-NativeCommand git @args
}

Function Exit-IfGitNotClean {
    # Don't continue if there are changes
    $status = Invoke-Git status
    if (!($status | select-string "nothing to commit")) {
        $status
        Exit 1
    }
}

Function Invoke-GitTfsPull {
    Write-Host "Pulling from TFS..."
    Invoke-Git tfs pull
}

Function Invoke-GitCheckoutStripped {
    Invoke-Git checkout $stripped_branch
}

Function Invoke-GitCommitStripped {
    Invoke-GitTolerant commit -am $strip_commit
}

Function Invoke-GitRebaseStripped {
    Invoke-Git rebase $stripped_branch
}

Function Invoke-GitCheckoutOffBranch ($branch_to, $branch_from = "") {
    If ($branch_from -eq "") {
        $branch_from = $stripped_branch
    }

    Write-Host "Creating branch" $branch_to "from" $branch_from
    Invoke-Git checkout -b $branch_to $branch_from
}

Function Invoke-GitFeatureCheckin {
    Invoke-Git rebase $stripped_branch --onto master
    Invoke-GitTolerant tfs checkintool
    Invoke-Git rebase master --onto $stripped_branch
}

Function Get-GitBranch {
    Return (Invoke-Git symbolic-ref HEAD) -replace "^.*/", ""
}

Export-ModuleMember -Function Invoke-NativeCommand, Invoke-Git, Exit-IfGitNotClean, Invoke-GitTfsPull, Invoke-GitCheckoutStripped, Invoke-GitCommitStripped, Invoke-GitRebaseStripped, Invoke-GitCheckoutOffBranch, Invoke-GitFeatureCheckin, Get-GitBranch