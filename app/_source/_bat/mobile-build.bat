@echo off

rem ���ñ���
set batDirDrive=%~dp0
set batDirPath=%~p0
set batName=%~n0
set configDir=..\_config
set configName=%batName%.rb
set configRb=%batDirDrive%%configDir%\%configName%

rem ����.config����Ŀ¼
cd %batDirPath%
cd ..\..\

rem ѡ�����ֻ���
echo ����ģʽ����d,����ģʽ����p,ȡ������n
choice /c dpn /M "development,production,end"
if errorlevel 3 goto end
if errorlevel 2 goto production
if errorlevel 1 goto development

rem ����ģʽ
:development
echo ����ģʽ������sourcemap
call compass watch -c %configRb%
goto end

rem ����ģʽ
:production
echo ����ģʽ��ȫѹ��
call compass compile -c %configRb% -e development --force
call compass compile -c %configRb% -e production --force
goto end

rem �����˳�
:end
rem pause
cmd /k
