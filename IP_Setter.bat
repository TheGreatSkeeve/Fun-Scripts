@echo off
netsh interface ipv4 show config

echo Please enter the name of the interface to configure
set /P interface=
echo [S]tatic or [D]ynamic?
set /P type=

if not x%type:S=%==x%type% goto Static
if not x%type:D=%==x%type% goto DHCP

REM Static IP config
:Static
echo IP Address?
set /P IP=
echo Configure advanced options?  (Y/N)
set /P advanced=
if %advanced%==Y (goto Advanced) else if %advanced%==N (goto Basic) else (goto Whoops)

:Advanced
echo Subnet Mask? (255.255.255.0)
set /P subnet=
echo Default gateway?
set /P gateway=
echo DNS1?
set /P dns=
echo DNS2?
set /P dns2=
goto StaticSet

:Whoops
echo I didn't understand that, it wasn't a capital Y or capital N.
echo Skipping Advanced config, it's probably correct anyhow.

:Basic
REM Pull gateway from IP address, assuming a non-fucky subnet
FOR /F "tokens=1-4 delims=." %%G IN ("%IP%") DO set gateway=%%G.%%H.%%I.1
echo %gateway%
pause
REM Setting a non-fucky subnet
set subnet=255.255.255.0
REM Set DNS
set dns="8.8.8.8"
set dns2=gateway
goto StaticSet


:StaticSet
echo Setting IP config...
echo %interface% %IP% %subnet% %gateway% %dns% %dns2%
netsh interface ipv4 set address name=%interface% static %IP% %subnet% %gateway%
echo Setting DNS server...
netsh interface ip add dns name=%interface% addr=%dns% index=1
netsh interface ip add dns name=%interface% addr=%dns2% index=2


echo All done!
pause
exit

REM DHCP
:DHCP
echo Setting IP config to DHCP...
netsh interface ipv4 set address name=%interface% source=dhcp
echo Setting DNS server to DHCP...
netsh interface ipv4 set dnsservers name=%interface% source=dhcp
echo All done!
pause
exit