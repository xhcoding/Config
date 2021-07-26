# 日志函数
function Write-Log-Info {
    Write-Host "$($args[0])" -f Yellow
}

function Write-Log-Success {
    Write-Host "$($args[0])" -f Green
}

function Write-Log-Fatal {
    Write-Host "$($args[0])" -f Red
}

function Test-Command {
    $(Get-Command $args[0] -ErrorAction SilentlyContinue)
}

# 设置 HOME 目录
$env:HOME = "C:\Users\xhcoding"
[Environment]::SetEnvironmentVariable("HOME", $env:HOME, "User")


# 开始安装 scoop
Write-Log-Info "Start install scoop ..."

# scoop 安装目录
$env:SCOOP = "D:\Applications\Scoop"
[Environment]::SetEnvironmentVariable("SCOOP", $env:SCOOP, "User")

# scoop 全局安装目录
$env:SCOOP_GLOBAL = 'D:\Applications\GlobalScoopApps'
[Environment]::SetEnvironmentVariable('SCOOP_GLOBAL', $env:SCOOP_GLOBAL, 'Machine')

if (-Not $(Test-Command "scoop")) {
    Set-ExecutionPolicy RemoteSigned -scope CurrentUser
    Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')
}

Write-Log-Success "Install scoop successful "

Write-Log-Info "scoop add extras bucket"
scoop bucket add extras


Write-Log-Info "scoop add zapps bucket"
scoop bucket add zapps https://github.com/kkzzhizhou/scoop-zapps

Write-Log-Info "scoop add dorado bucket"
scoop bucket add dorado https://github.com/chawyehsu/dorado


function Install-With-Scoop {
    Write-Log-Info "Start install $($args[0]) ..."
    scoop install $($args[0])
    Write-Log-Success "Install $($args[0]) successful !"
}

function Install-With-Winget {
    $packageId = $($args[0])
    winget list --id $packageId
    if ($?) {
        Write-Log-Info "${packageId} already install!"
    } else {
        Write-Log-Info "Start install ${packageId} ..."
        winget install ${packageId}
        Write-Log-Success "Install ${packageId} successful !"
    }

}


function Install-With-Scoop-Global {
    Write-Log-Info "Start install $($args[0]) ..."
    scoop install $($args[0]) -g
    Write-Log-Success "Install $($args[0]) successful !"
}

# 安装软件
Install-With-Scoop "git"
$sshConfigPath = "${env:HOME}\.ssh\config"
if (-Not $(Test-Path ${sshConfigPath})) {
    New-Item -Path $sshConfigPath
    $sshConfig = @"
Host github.com
    HostName github.com
    User xhcoding
    IdentityFile C:/Users/xhcoding/.ssh/id_ed25519_github
"@
    $sshConfig | Out-File $sshConfigPath -Encoding UTF8NoBOM
}

# 安装 vscode
Install-With-Scoop "vscode"
if (-Not $(Test-Command "code")) {
    D:\Applications\Scoop\apps\vscode\current\vscode-install-context.reg
}

# 安装 perl
Install-With-Scoop "perl"

# 安装坚果云
Install-With-Winget "Nutstore.Nutstore"

# 安装 emacs
Install-With-Scoop "emacs"
$emacsConfigPath = "${env:HOME}\.emacs.d"
if (-Not $(Test-Path ${emacsConfigPath})) {
    git clone --recursive git@github.com:xhcoding/.emacs.d.git ${emacsConfigPath}
    Copy-Item -Filter *.dll -Path "${emacsConfigPath}\lib\*" -Recurse -Destination "$env:SCOOP\apps\emacs\current\bin"
}
if (-Not $env:EMACS_SERVER_FILE) {
    [environment]::SetEnvironmentvariable("EMACS_SERVER_FILE", "C:\Users\xhcoding\.emacs.d\server\emacs-server-file", "User")
}

# caps to ctrl
$hexified = "00,00,00,00,00,00,00,00,02,00,00,00,1d,00,3a,00,00,00,00,00".Split(',') | % { "0x$_" }
$kbLayout = 'HKLM:\System\CurrentControlSet\Control\Keyboard Layout'
New-ItemProperty -Path $kbLayout -Name "Scancode Map" -PropertyType Binary -Value ([byte[]]$hexified) -ErrorAction SilentlyContinue


# 安装 pwsh
Install-With-Scoop "pwsh"

# 安装 pandoc
Install-With-Scoop "pandoc"

# 安装 hugo
Install-With-Scoop "hugo"
Install-With-Scoop "cwrsync"

# 安装等距更纱黑体
Install-With-Scoop "SarasaGothic-SC"

# 搜索工具
Install-With-Scoop "ripgrep"
Install-With-Scoop "fd"