Write-Host "Stripping provided files..."

Foreach ($file in $input) {
    Write-Host $file
    $file = Get-Item $file

    If ($file.name -Like "*scc") {
        Remove-Item $file.fullname
    }

    If ($file.name -Like "*.csproj") {
        (Get-Content $file.fullname) | Where-Object { $file -NotMatch "Scc" } | Set-Content $file.fullname
    }

    If ($file.name -Like "*.sln") {
        $p = 1
        (Get-Content $file.fullname) | Foreach-Object {
            If ($_ -Match "GlobalSection\(TeamFoundationVersionControl\)") {
                $p = 0
            }

            If ($p -Eq 1) {
                Write-Output $_
            }

            If (($p -eq 0) -And ($_ -Match "EndGlobalSection")) {
                $p = 1
            }
        } | Set-Content $file.fullname
    }

    If ($file.name -Like "*.vdproj") {
        (Get-Content $file.fullname) | Foreach-Object {
            If ($_ -Match "Scc") {
                $_ = $_ -Replace '"8:[^"]+"', '"8:"'
            }
            Write-Output $_
        } | Set-Content $file.fullname
    }
}
