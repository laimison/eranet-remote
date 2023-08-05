# Down 127
echo -ne "\x0\x0\x`printf "%x\n" 127`\x0" > /dev/hidg1
