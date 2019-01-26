# A daily FTP backup schedule

/system scheduler 
add name="backup" on-event=":log info \"Creating backups\";\r\
    \n:local day ([:pick [/system clock get date] 4 6]);\r\
    \n:local mon ([:pick [/system clock get date] 0 3]);\r\
    \n:local yer ([:pick [/system clock get date] 7 11]);\r\
    \n:local date \"\$day-\$mon-\$yer\";\r\
    \n:local iden [/system identity get name];\r\
    \n:local name \"\$date_\$iden\";\r\
    \nexport compact file= \$name\r\
    \nsystem backup save dont-encrypt=yes name= \$name\r\
    \n\r\
    \n:local rec1 \"\$name.rsc\";\r\
    \n:local rec2 \"\$name.rsc\";\r\
    \n\r\
    \n:local bk1 \"\$name.backup\";\r\
    \n:local bk2 \"Backup/\$name.backup\";\r\
    \n\r\
    \n:log info \"Uploading backups\";\r\
    \n/tool fetch address=192.168.2.12 src-path= \$rec1 user=radftp_user mode=ftp password=let_me_upload dst-path= \$rec2 upload=yes\r\
    \n/tool fetch address=192.168.2.12 src-path= \$bk1 user=radftp_user mode=ftp password=let_me_upload dst-path= \$bk2 upload=yes\r\
    \n\r\
    \n:delay 30s;\r\
    \n:log info \"Removing backups\";\r\
    \n/file remove \$rec1\r\
    \n/file remove \$bk1" \
    start-date=(put [/system clock get date]) start-time=00:00:00 interval=1d comment="Daily backup via ftp" \
    disabled=no