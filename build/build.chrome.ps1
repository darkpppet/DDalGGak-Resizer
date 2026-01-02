$srcPath = Join-Path (Split-Path -Parent $PSScriptRoot) "src"
$outPath = Join-Path $PSScriptRoot "out\ddalggak-chrome"

if (Test-Path $outPath) {
    $result = $host.ui.PromptForChoice(
        "기존 폴더 삭제 확인",
        "이미 폴더($outPath)가 존재합니다. 삭제하고 새로 만들까요?",
        [System.Management.Automation.Host.ChoiceDescription[]] @(
            New-Object System.Management.Automation.Host.ChoiceDescription "&Yes", "기존 폴더를 삭제하고 진행합니다."
            New-Object System.Management.Automation.Host.ChoiceDescription "&No", "스크립트를 종료합니다."
        ), 1)

    if ($result -ne 0) {
        Write-Host "[!] 스크립트를 종료합니다." -ForegroundColor Yellow
        return
    } else {
        Remove-Item -Path $outPath -Recurse -Force
        Write-Host "[-] 기존 폴더를 삭제하였습니다." -ForegroundColor Gray
    }
}

New-Item -ItemType Directory -Path $outPath -Force | Out-Null
Copy-Item -Path "$srcPath\*" -Destination $outPath -Recurse
Write-Host "[+] 파일 복사 완료" -ForegroundColor Green

$manifestPath = Join-Path $outPath "manifest.json"
if (!(Test-Path $manifestPath)) {
    Write-Host "[!] manifest.json 파일이 없습니다. 스크립트를 종료합니다." -ForegroundColor Red
    return
}

$manifest = Get-Content $manifestPath -Raw -Encoding utf8 | ConvertFrom-Json
if ($null -ne $manifest.background.scripts) {
    $manifest.background.psobject.Properties.Remove("scripts")
}
if ($null -ne $manifest.browser_specific_settings) {
    $manifest.psobject.Properties.Remove("browser_specific_settings")
}
Set-Content -Path $manifestPath -Value ($manifest | ConvertTo-Json -Compress) -Encoding utf8
Write-Host "[*] manifest.json 수정 완료" -ForegroundColor Cyan

Write-Host "[!] 스크립트 완료!" -ForegroundColor Magenta
