@echo off

rem 设置变量
set batDirDrive=%~dp0
set batDirPath=%~p0
set batName=%~n0
set configDir=..\_config
set configName=%batName%.rb
set configRb=%batDirDrive%%configDir%\%configName%

rem 进入.config父级目录
cd %batDirPath%
cd ..\..\

rem 选择哪种环境
echo 开发模式输入d,生产模式输入p,取消输入n
choice /c dpn /M "development,production,end"
if errorlevel 3 goto end
if errorlevel 2 goto production
if errorlevel 1 goto development

rem 开发模式
:development
echo 开发模式，带有sourcemap
call compass watch -c %configRb%
goto end

rem 生产模式
:production
echo 生产模式，全压缩
call compass compile -c %configRb% -e development --force
call compass compile -c %configRb% -e production --force
goto end

rem 结束退出
:end
rem pause
cmd /k
