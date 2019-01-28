# Paste this script in the console to generate night queues for existing pppoe based dynamic queues

# delete all existing night profiles to clean up broken profiles
:foreach i in=[/queue simple find name~"night"] do={/queue simple remove $i}

:foreach i in=[/queue simple find] do={ \
    :local target [/queue simple get $i target]; \
    :local maxlimit [/queue simple get $i max-limit]; \
    :put ("adding " . $target . " " . $maxlimit); \
    /queue simple add name="$target_night" target=$target max-limit=0/0 priority=1/1 queue=pcq-upload-default/pcq-download-default time=00h00m-06h00m,sun,mon,tue,wed,thu,fri,sat disabled=yes; \
}; \
/queue simple move [find name~"night"] 0;

