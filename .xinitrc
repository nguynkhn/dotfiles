while true; do
  xsetroot -name "$(date +"%F %r")"
  sleep 1
done &
xcompmgr &
~/.fehbg &
xset r rate 400 30
exec dwm
