$srcPath = Join-Path (Split-Path -Parent $PSScriptRoot) "src"
$outPath = Join-Path $PSScriptRoot "out\ddalggak-firefox"

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
if ($null -ne $manifest.background.service_worker) {
    $manifest.background.psobject.Properties.Remove("service_worker")
}
Set-Content -Path $manifestPath -Value ($manifest | ConvertTo-Json -Compress) -Encoding utf8
Write-Host "[*] manifest.json 수정 완료" -ForegroundColor Cyan

$tempZipPath = ""
do {
    $randomHex = "{0:x8}" -f (Get-Random)
    $tempZipName = "temp_$($randomHex).zip"
    $tempZipPath = Join-Path $PSScriptRoot "out\$tempZipName"
} while (Test-Path $tempZipPath)

Compress-Archive -Path "$outPath\*" -DestinationPath $tempZipPath -Force
Write-Host "[*] 압축 완료" -ForegroundColor Gray

$xpiPath = Join-Path $PSScriptRoot "out\ddalggak-firefox.xpi"
if (Test-Path $xpiPath) {
    $result = $host.ui.PromptForChoice(
        "기존 파일 삭제 확인",
        "이미 파일($xpiPath)이 존재합니다. 삭제하고 새로 만들까요?",
        [System.Management.Automation.Host.ChoiceDescription[]] @(
            New-Object System.Management.Automation.Host.ChoiceDescription "&Yes", "기존 폴더를 삭제하고 진행합니다."
            New-Object System.Management.Automation.Host.ChoiceDescription "&No", "스크립트를 종료합니다."
        ), 1)

    if ($result -ne 0) {
        Remove-Item -Path $tempZipPath -Force
        Write-Host "[!] 스크립트를 종료합니다." -ForegroundColor Yellow
        return
    } else {
        Remove-Item -Path $xpiPath -Recurse -Force
        Write-Host "[-] 기존 파일을 삭제하였습니다." -ForegroundColor Gray
    }
}
Rename-Item -Path $tempZipPath -NewName (Split-Path $xpiPath -Leaf)
Write-Host "[+] xpi 파일 생성 완료." -ForegroundColor Green

Write-Host "[!] 스크립트 완료!" -ForegroundColor Magenta
