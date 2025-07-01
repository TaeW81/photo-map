@echo off
REM Photomap 배포 자동화 배치 파일

REM 1. 작업 디렉터리로 이동 (C: 경로 변경 가능)
cd /d C:\photomap

REM 2. 모든 변경 파일 스테이징
git add .

REM 3. 커밋 (메시지는 필요에 따라 수정)
git commit -m "Update Photomap files"

REM 4. 원격(main) 브랜치 이력 통합 (충돌 없이 최신 이력 가져오기)
git pull --rebase origin main

REM 5. 원격에 푸시
git push origin main

PAUSE
