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

Write-Log-Info "scoop add versions bucket"
scoop bucket add versions

Write-Log-Info "scoop add nerd-fonts bucket"
scoop bucket add nerd-fonts

Write-Log-Info "scoop add java bucket"
scoop bucket add java

Write-Log-Info "scoop add zapps bucket"
scoop bucket add zapps https://github.com/kkzzhizhou/scoop-zapps

Write-Log-Info "scoop add dorado bucket"
scoop bucket add dorado https://github.com/chawyehsu/dorado

function Install-With-Scoop {
    Write-Log-Info "Start install $($args[0]) ..."
    scoop install $($args[0])
    Write-Log-Success "Install $($args[0]) successful !"
}


function Install-With-Scoop-Global {
    Write-Log-Info "Start install $($args[0]) ..."
    scoop install $($args[0]) -g
    Write-Log-Success "Install $($args[0]) successful !"
}

# 安装软件
Install-With-Scoop "git"
Install-With-Scoop-Global "vcredist2019"
Install-With-Scoop "wox"
Install-With-Scoop "python"
Install-With-Scoop "python27"
Install-With-Scoop "emacs"
Install-With-Scoop "windows-terminal"
Install-With-Scoop "pwsh"
Install-With-Scoop "keeweb"
Install-With-Scoop "Foxmail"
Install-With-Scoop "sarasagothic"
Install-With-Scoop "ripgrep"
Install-With-Scoop "fd"
Install-With-Scoop "pandoc"
Install-With-Scoop "vscode"
Install-With-Scoop "nvm-windows"
Install-With-Scoop "cmake"
Install-With-Scoop "https://github.com/JanDeDobbeleer/oh-my-posh3/releases/latest/download/oh-my-posh.json"
Install-With-Scoop "universal-ctags"
Install-With-Scoop-Global "wechatwork"
Install-With-Scoop "wechat"
Install-With-Scoop "neteasemusic"
Install-With-Scoop "hugo"
Install-With-Scoop "cwrsync"
Install-With-Scoop "rustup-msvc"
Install-With-Scoop "adoptopenjdk-hotspot-jre"
Install-With-Scoop "plantuml"
Install-With-Scoop-Global "zeal"

# caps to ctrl
$hexified = "00,00,00,00,00,00,00,00,02,00,00,00,1d,00,3a,00,00,00,00,00".Split(',') | % { "0x$_" }
$kbLayout = 'HKLM:\System\CurrentControlSet\Control\Keyboard Layout'
New-ItemProperty -Path $kbLayout -Name "Scancode Map" -PropertyType Binary -Value ([byte[]]$hexified) -ErrorAction SilentlyContinue

# 安装 emacs 配置

$emacsConfigPath = "${env:HOME}\.emacs.d"
if (-Not $(Test-Path ${emacsConfigPath})) {
    git clone --recursive git@github.com:xhcoding/.emacs.d.git ${emacsConfigPath}
}

# 安装 choco
if (-Not $(Test-Command "choco")) {
    Set-ExecutionPolicy Bypass -Scope Process -Force
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}
