#!/bin/sh
# $OpenBSD: xinitrc.cpp,v 1.14 2022/07/01 20:42:06 naddy Exp $
userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap
# merge in defaults and keymaps
if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi
if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi
if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi
if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi
# if we have private ssh key(s), start ssh-agent and add the key(s)
if [ -z "$SSH_AGENT_PID" ] && [ -x /usr/bin/ssh-agent ]
then
	for k in id_rsa id_ecdsa id_ecdsa_sk id_ed25519 id_ed25519_sk id_dsa
	do
		if [ -f "$HOME/.ssh/$k" ]; then
			eval `ssh-agent -s`
			ssh-add < /dev/null
			break
		fi
	done
fi

xwallpaper --zoom /home/glenda/wall.jpg
exec i3
