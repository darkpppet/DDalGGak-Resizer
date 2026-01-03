chrome / firefox 별 맞춤으로 수정된 소스를 생성해주는 PowerShell 스크립트들입니다.

Hierarchy가 달라지면 작동하지 않습니다. 폴더 구조는 그대로 유지해서 사용해주세요.

그대로 복사뜬 후, manifest.json만 수정합니다. 그다음, 파이어폭스의 경우 xpi 패키징까지 진행해줍니다.

edge는 chrome용이랑 동일합니다.

---

#### build.chrome.ps1
 - backgroud.scripts 속성을 제거해줍니다. (경고/오류 제거)
 - browser_specific_settings 속성을 없애줍니다.
 - out/ddalggak-chrome/ 에 들어갑니다.

#### build.firefox.ps1
 - background.service_worker 속성을 제거해줍니다.
 - out/ddalggak-firefox/ 에 들어갑니다.
 - out/ddalggak-firefox.xpi 를 생성합니다.

