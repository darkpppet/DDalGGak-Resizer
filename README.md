# 딸깍 Resizer

클릭 한번으로 브라우저 크기를 저장해뒀던 값으로 변경해주는 익스텐션입니다. 옵션에서 크기를 지정할 수 있습니다. (기본값 1920x1080)

이 가난한 개발자는 $5이 없어 마켓에 등록을 하지 못합니다... 따라서 crx/xpi 설치가 아닌 unpacked 폴더로 설치해야 합니다.

#### 설치 방법
 1. 소스 폴더를 다운로드합니다. (src 폴더)
 - Chrome
   2. <chrome://extensions/> 으로 이동합니다.
   3. [개발자 모드]를 켭니다.
   4. [압축해제된 확장 프로그램 로드] - 폴더 선택
      - firefox 지원 때문에 ['background.scripts' requires manifest version of 2 or lower.] 경고가 뜹니다. 무시하셔도 됩니다.
   
 - Edge
   2. <edge://extensions/> 으로 이동합니다.
   3. 좌측 중단 [개발자 모드]를 켭니다.
   4. [압축 풀린 파일 로드] - 폴더 선택
      - firefox 지원 때문에 ['background.scripts' requires manifest version of 2 or lower.] 오류가 뜹니다. 무시하셔도 됩니다.

 - FireFox
   2. <about:debugging#/runtime/this-firefox> 로 이동합니다.
   3. [임시 부가 기능 로드] - manifest.json 선택

 - 다른 브라우저
   - 고려하지 않았습니다.

---

#### Resources
 - [[link]](https://github.com/picocss/pico) pico
 - [[link]](https://www.flaticon.com/free-icon/maximize_3413667?term=size&page=1&position=2&origin=search&related_id=3413667) Flaticon

---

### history

#### ver 0.1
 - 출시