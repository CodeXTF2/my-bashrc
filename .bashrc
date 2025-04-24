#CodeX's bashrc
export VPNSTATUS=$(ifconfig | grep "tun0")
if [ -z "$VPNSTATUS" ]
then
	export IP=$(ifconfig eth0 | grep "inet " | cut -d " " -f 10)
else
	export IP=$(ifconfig tun0 | grep "inet " | cut -d " " -f 10)
	echo "Connected to OpenVPN : "$IP
fi
PS1='\[\e[0;1;2m\][\[\e[0;1;38;5;51m\]\u\[\e[0;1;2m\]@\[\e[0;1;93m\]\h\[\e[0;1;2m\]]\[\e[0;1;92m\]-\[\e[0;1;2m\][\[\e[0;1;92m\]'$IP'\[\e[0;1;2m\]]\[\e[0;1;92m\]-\[\e[0;1;2m\][\[\e[0;1;38;5;50m\]\W\[\e[0;1;2m\]]\[\e[m\] \[\e[0;1;2m\]\$\[\e[m\] \[\e0'
export GOPATH=/root/go-workspace
export GOROOT=/usr/local/go
PATH=$PATH:$GOROOT/bin/:$GOPATH/bin


alias certutil-oneliner='download_and_serve'

download_and_serve() {
    if [ "$#" -ne 3 ]; then
        echo "Usage: download_and_serve <ip> <port> <filename>"
        return 1
    fi

    local ip="$1"
    local port="$2"
    local filename="$3"

    # Generate certutil command
    local certutil_command="certutil.exe -urlcache -f http://$ip:$port/$filename $filename"
    echo "Certutil command:"
    echo $certutil_command

    # Generate wget command
    local wget_command="wget http://$ip:$port/$filename -o $filename"
    echo "Wget command:"
    echo $wget_command

    # Start Python HTTP server
    echo "Starting Python HTTP server on 0.0.0.0:$port"
    python3 -m http.server $port --bind 0.0.0.0
}


##Add the following to the .bashrc file
function set-title() {
  if [[ -z "$ORIG" ]]; then
    ORIG=$PS1
  fi
  TITLE="\[\e]2;$*\a\]"
  PS1=${ORIG}${TITLE}
}

# Created by `pipx` on 2024-01-04 09:19:21
export PATH="$PATH:/root/.local/bin"
alias burpsuite_pro='/usr/lib/jvm/java-17-openjdk-amd64/bin/java --add-opens=java.desktop/javax.swing=ALL-UNNAMED --add-opens=java.base/java.lang=ALL-UNNAMED --add-opens=java.base/jdk.internal.org.objectweb.asm=ALL-UNNAMED --add-opens=java.base/jdk.internal.org.objectweb.asm.tree=ALL-UNNAMED --add-opens=java.base/jdk.internal.org.objectweb.asm.Opcodes=ALL-UNNAMED -javaagent:/usr/bin/burploader.jar -noverify -jar /usr/bin/burpsuite_pro_v2023.11.1.2.jar'

alias penelope='python /root/github/penelope/penelope.py'
alias mkvenv='python3 -m venv venv && source venv/bin/activate'
alias vscode-ns='vscode --no-sandbox'
alias socatfwd='function _socatfwd(){ \
  if [ "$#" -ne 4 ]; then \
    echo "Usage: socatfwd <SRC_IP> <SRC_PORT> <DEST_IP> <DEST_PORT>"; \
    return 1; \
  fi; \
  echo "socat TCP4-LISTEN:$2,bind=$1,fork TCP4:$3:$4"; \
}; _socatfwd'
alias gobust-cmd='function _gobustcmd(){ echo "gobuster dir -e -u $1 -w /usr/share/wordlists/dirbuster/directory-list-lowercase-2.3-medium.txt -t 50 -k -x php,html,txt"; }; _gobustcmd'

feroxbust-cmd() {
    if [ -z "$1" ]; then
        echo "Usage: feroxbust-cmd <URL>"
        return 1
    fi

    URL="$1"
    WORDLIST="/usr/share/wordlists/dirbuster/directory-list-lowercase-2.3-medium.txt"
    EXTENSIONS="php,html,txt,yml,conf"
    THREADS=50

    echo "feroxbuster -u \"$URL\" -w \"$WORDLIST\" -t $THREADS -x $EXTENSIONS -k -e"
}

