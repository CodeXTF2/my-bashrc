#CodeX's bashrc
export VPNSTATUS=$(ifconfig | grep "tun0")
if [ -z "$VPNSTATUS" ]
then
	export IP=$(ifconfig eth0 | grep "inet " | cut -d " " -f 10)
else
	export IP=$(ifconfig tun0 | grep "inet " | cut -d " " -f 10)
	echo "Connected to OpenVPN : "$IP
fi
source ~/.bash/settings
source ~/.bash/alias
source ~/.bash/functions
PS1='\[\e[0;1;2m\][\[\e[0;1;38;5;51m\]\u\[\e[0;1;2m\]@\[\e[0;1;93m\]\h\[\e[0;1;2m\]]\[\e[0;1;92m\]-\[\e[0;1;2m\][\[\e[0;1;92m\]'$IP'\[\e[0;1;2m\]]\[\e[0;1;92m\]-\[\e[0;1;2m\][\[\e[0;1;38;5;50m\]\W\[\e[0;1;2m\]]\[\e[m\] \[\e[0;1;2m\]\$\[\e[m\] \[\e0'
export GOPATH=/root/go-workspace
export GOROOT=/usr/local/go
PATH=$PATH:$GOROOT/bin/:$GOPATH/bin

##Add the following to the .bashrc file
function set-title() {
  if [[ -z "$ORIG" ]]; then
    ORIG=$PS1
  fi
  TITLE="\[\e]2;$*\a\]"
  PS1=${ORIG}${TITLE}
}
