Write-Host "Stripping provided files..."

Foreach ($file in $input) {
    Write-Host $file
    $file = Get-Item $file

    If ($file.Name -Like "*scc") {
        Remove-Item $file.FullName
    }

    If ($file.Name -Like "*.csproj") {
        (Get-Content $file.FullName) | Where-Object { $_ -NotMatch "^ +\<Scc" } | Set-Content $file.FullName
    }

    If ($file.Name -Like "*.sln") {
        $p = 1
        (Get-Content $file.FullName) | Foreach-Object {
            If ($_ -Match "GlobalSection\(TeamFoundationVersionControl\)") {
                $p = 0
            }

            If ($p -Eq 1) {
                Write-Output $_
            }

            If (($p -Eq 0) -And ($_ -Match "EndGlobalSection")) {
                $p = 1
            }
        } | Set-Content $file.FullName
    }

    If ($file.Name -Like "*.vdproj") {
        (Get-Content $file.FullName) | Foreach-Object {
            If ($_ -Match "Scc") {
                $_ = $_ -Replace '"8:[^"]+"', '"8:"'
            }
            Write-Output $_
        } | Set-Content $file.FullName
    }
}
