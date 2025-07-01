#!/bin/bash
set -x
if [ $# -lt 2 ]; then
	echo "miss argument"	
	exit 1
fi
MACHINES=$1
USERNAME=$2
pssh -l $USERNAME -H $MACHINES "cd /home/$USERNAME; rm -fr ~/.vim"
prsync -avzr -l $USERNAME -H "$MACHINES" -X '--exclude="*.tar.xz" --exclude="*.pack"' ~/.vim /home/$USERNAME/
prsync -avzr -l $USERNAME -H "$MACHINES" /usr/local/zsh-master /home/$USERNAME/
prsync -avzr -l $USERNAME -H "$MACHINES" /usr/local/tmux-master /home/$USERNAME/
prsync -avzr -l $USERNAME -H "$MACHINES" /usr/local/vim-8.x /home/$USERNAME/
prsync -avzr -l $USERNAME -H "$MACHINES" /usr/local/ctags-5.8 /home/$USERNAME/
prsync -avzr -l $USERNAME -H "$MACHINES" /usr/local/pssh-2.3.1 /home/$USERNAME/
pssh -l $USERNAME -H "$MACHINES" -t0 -Px '-A -tt' "sudo cp -fr /home/$USERNAME/tmux-master /usr/local && rm -fr /home/zhangjiguo/tmux-master"
pssh -l $USERNAME -H "$MACHINES" -t0 -Px '-A -tt' "sudo cp -fr /home/$USERNAME/zsh-master /usr/local && rm -fr /home/zhangjiguo/zsh-master"
pssh -l $USERNAME -H "$MACHINES" -t0 -Px '-A -tt' "sudo cp -fr /home/$USERNAME/vim-8.x /usr/local && rm -fr /home/zhangjiguo/vim-8.x"
pssh -l $USERNAME -H "$MACHINES" -t0 -Px '-A -tt' "sudo cp -fr /home/$USERNAME/ctags-5.8 /usr/local && rm -fr /home/zhangjiguo/ctags-5.8"
pssh -l $USERNAME -H "$MACHINES" -t0 -Px '-A -tt' "sudo cp -fr /home/$USERNAME/pssh-2.3.1 /usr/local && rm -fr /home/zhangjiguo/pssh-2.3.1"
pssh -l $USERNAME -H "$MACHINES" -t0 -Px '-A -tt' "sudo chown -R root:root /usr/local/tmux-master /usr/local/zsh-master /usr/local/vim-8.x /usr/local/ctags-5.8"
pssh -l $USERNAME -H "$MACHINES" -t0 -Px '-A -tt' "cd /home/$USERNAME/.vim; sh deploy.sh"
pssh -l $USERNAME -H "$MACHINES" -t0 -Px '-A -tt' "sudo chsh -s /usr/local/zsh-master/bin/zsh $USERNAME"
