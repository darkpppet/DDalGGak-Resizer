chrome / firefox 별 맞춤으로 수정된 소스를 생성해주는 PowerShell 스크립트들입니다.

Hierarchy가 달라지면 작동하지 않습니다. 폴더 구조는 그대로 유지해서 사용해주세요.

굳이 안돌려도 실행에는 문제 없습니다.

기본적으로 그대로 복사뜬 후, manifest.json만 수정하는 식으로 동작합니다.

edge는 chrome용이랑 동일합니다.

---

#### build.chrome.ps1
 - backgroud.scripts 속성을 제거해줍니다. (경고/오류 제거)
 - browser_specific_settings 속성을 없애줍니다.
 - out/ddalggak-chrome/ 에 들어갑니다.

#### build.firefox.ps1
 - background.service_worker 속성을 제거해줍니다.
 - out/ddalggak-firefox/ 에 들어갑니다.

