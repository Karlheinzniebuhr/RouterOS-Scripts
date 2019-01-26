# Paste this script in the console to generate night queues for existing pppoe based dynamic queues

:foreach i in=[/queue simple find] do={ \
    :local target [/queue simple get $i target]; \
    :local maxlimit [/queue simple get $i max-limit]; \
    :put ("adding " . $target . " " . $maxlimit); \
    /queue simple add name="$target_night" target=$target max-limit=10M/10M priority=1/1 time=00h00m-06h00m,sun,mon,tue,wed,thu,fri,sat disabled=yes; \
}; \
/queue simple move [find name~"night"] 0;

# loop over night queues. Replace the print function with whatever you need.
:foreach i in=[/queue simple find name~"night"] do={:local name [/queue simple get $i name]; :put $name}