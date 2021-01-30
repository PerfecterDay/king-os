@REM @echo off
set START_PATH=%cd%
set DISK_IMG=%START_PATH%\target\hd60M.img
set DISK_IMG_LOCK=%START_PATH%\target\hd60M.img.lock
set BXSHARE=D:\applications\Scoop\apps\bochs\2.6.11

mkdir target
nasm -o .\target\mbr.bin .\src\mbr\mbr.asm

if exist %DISK_IMG_LOCK% (
    del /f %DISK_IMG_LOCK%
) else (
    echo %DISK_IMG_LOCK% is not exist!
)

if exist %DISK_IMG% (
    del /f %DISK_IMG%
) else (
    echo %DISK_IMG% is not exist!
)



bximage -q -hd=60M -mode=create %DISK_IMG% 
dd if=.\target\mbr.bin of=%DISK_IMG% bs=512 count=1 conv=notrunc
bochsdbg -f %BXSHARE%\bochsrc.disk

if exist %DISK_IMG_LOCK% (
    del /f %DISK_IMG_LOCK%
) else (
    echo %DISK_IMG_LOCK% is not exist!
)