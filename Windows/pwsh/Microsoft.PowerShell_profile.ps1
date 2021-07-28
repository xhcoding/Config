[System.Console]::OutputEncoding = [System.Text.Encoding]::GetEncoding(65001)

Import-Module PSReadLine
Import-Module posh-git
Import-Module PSFzf

# Enable Prediction History
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -MaximumHistoryCount 100000
# Advanced Autocompletion for arrow keys
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

Set-PSReadLineOption -EditMode Emacs

Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'

# env
$env:PATH += ";C:\Program Files\mosquitto"

[ScriptBlock]$Prompt = {
  $realLASTEXITCODE = $global:LASTEXITCODE
  if ($realLASTEXITCODE -isnot [int]) {
    $realLASTEXITCODE = 0
  }
  $startInfo = New-Object System.Diagnostics.ProcessStartInfo
  $startInfo.FileName = "D:\Applications\Scoop\shims\oh-my-posh.exe"
  $cleanPWD = $PWD.ProviderPath.TrimEnd("\")
  $startInfo.Arguments = "-config=""D:\Code\Personal\Config\Windows\my-posh-theme.json"" -error=$realLASTEXITCODE -pwd=""$cleanPWD"""
  $startInfo.Environment["TERM"] = "xterm-256color"
  $startInfo.CreateNoWindow = $true
  $startInfo.StandardOutputEncoding = [System.Text.Encoding]::UTF8
  $startInfo.RedirectStandardOutput = $true
  $startInfo.UseShellExecute = $false
  if ($PWD.Provider.Name -eq 'FileSystem') {
    $startInfo.WorkingDirectory = $PWD.ProviderPath
  }
  $process = New-Object System.Diagnostics.Process
  $process.StartInfo = $startInfo
  $process.Start() | Out-Null
  $standardOut = $process.StandardOutput.ReadToEnd()
  $process.WaitForExit()
  $standardOut
  $global:LASTEXITCODE = $realLASTEXITCODE
  Remove-Variable realLASTEXITCODE -Confirm:$false
}
Set-Item -Path Function:prompt -Value $Prompt -Force

function Import-X86 {
  Import-VisualStudioVars 2017
  $env:Path += ";C:\Qt\5.12.10\msvc2017\bin"
}

function Import-X64 {
  Import-VisualStudioVars 2017 amd64
  $env:Path += ";C:\Qt\5.12.10\msvc2017_64\bin;C:\Program Files (x86)\Windows Kits\10\Debuggers\x64"
}

function Import-Qt6 {
  Import-VisualStudioVars 2019 amd64
  $env:Path += ";D:\Code\Project\qt6-build\qtbase\bin"
}

function Import-9 {
  Import-VisualStudioVars 2019
  $env:Path += ";C:\Qt\5.15.2\msvc2019\bin"
}

function Import-96 {
  Import-VisualStudioVars 2019 amd64
  $env:Path += ";C:\Qt\5.15.2\msvc2019_64\bin"
}



function Install-Conan-87D {
  conan install . -if build -s arch=x86 -s build_type=Debug
}

Set-Alias c8d Install-Conan-87D

function Hist {
  $find = $args;
  Write-Host "Finding in full history using {`$_ -like `"*$find*`"}";
  Get-Content (Get-PSReadlineOption).HistorySavePath | ? { $_ -like "*$find*" } | Get-Unique | more
}

function Ssh-Uos {
  ssh xhcoding@172.17.186.24
}

Invoke-Expression (& { (lua D:/Code/Personal/Config/3rdparty/z.lua/z.lua --init powershell echo once enhanced) -join "`n" } )
