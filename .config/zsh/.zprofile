if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
    /usr/lib/plasma-dbus-run-session-if-needed /usr/bin/startplasma-wayland
fi
