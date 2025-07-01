@echo off
chcp 65001 > nul
setlocal enabledelayedexpansion

REM 📁 작업 디렉터리 (필요시 경로 수정)
cd /d C:\photomap

echo ===============================
echo 📄 index.html 자동 생성 중...
echo ===============================

:: index.html 시작 부분 생성
(
    echo ^<!DOCTYPE html^>
    echo ^<html lang="ko"^>
    echo ^<head^>
    echo     ^<meta charset="UTF-8"^>
    echo     ^<meta name="viewport" content="width=device-width, initial-scale=1.0"^>
    echo     ^<title^>Photo Map Index^</title^>
    echo     ^<style^>
    echo         body { font-family: Arial, sans-serif; padding: 2em; }
    echo         h1 { color: #333; }
    echo         ul { line-height: 1.8; }
    echo     ^</style^>
    echo ^</head^>
    echo ^<body^>
    echo     ^<h1^>📌 배포된 지도 링크 목록^</h1^>
    echo     ^<ul^>
) > index.html

:: HTML 파일들을 순회하며 링크 추가
for %%f in (*.html) do (
    if /I not "%%f"=="index.html" (
        set "filename=%%f"
        set "encodedName=!filename: =%%20!"
        set "url=http://taew81.github.io/photo-map/!encodedName!"

        echo         ^<li^>^<a href="!url!" target="_blank"^>%%f^</a^>^</li^> >> index.html
    )
)

:: index.html 닫기
(
    echo     ^</ul^>
    echo ^</body^>
    echo ^</html^>
) >> index.html

echo ✅ index.html 생성 완료

echo ===============================
echo 🔄 Git 최신 상태로 동기화 중...
echo ===============================

git pull --rebase origin main
git add .
git commit -m "📍 자동 배포: html 및 index.html 업데이트"
git push origin main

echo ===============================
echo 🎉 완료!
echo 👉 http://taew81.github.io/photo-map/index.html
echo ===============================
pause
