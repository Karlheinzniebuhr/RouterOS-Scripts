# Made by Karl 25-01-19
# This scrip tests the radius server on intervals, if it becomes unreachable local existing pppoe profiles get activated.

/system scheduler 
add name="radius checker" on-event=":if ([/ping 192.168.2.12 count=5] = 0) do={\r\
            \n:log info \"Radius is offline!\";\r\
            \n:foreach k,v in=[/ppp secret find] do={\r\
                \n:log info \"activating \$k\";\r\
                \n/ppp secret enable \$k;\r\
            \n}\r\
        \n}" \
    start-date=(put [/system clock get date]) interval=5m comment="Activates local profiles if Radius offline" \
    disabled=no