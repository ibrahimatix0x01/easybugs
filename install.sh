#!/usr/bin/env bash
# Ibrahimatix how to find bugs

if [[ $(id -u) != 0 ]]; then
    echo -e "\n[!] Install.sh requires root privileges"
    exit 0
fi

installGo() {
	if command -v go version >/dev/null ; then
		echo -e "\033[1;32m[+] Go is already installed!\033[m"
	else
		bannerInstall Go
		if [ "$os" == "arch" ]; then
			sudo pacman -S go
		elif [ "$os" == "kali" ]; then
			sudo apt install golang -y
		else
			sudo apt install golang-go -y
		fi
	fi

	if ! command -v go version >/dev/null;then
		wget "https://golang.org/dl/go${VERSION}.linux-{$ARCH}.tar.gz" -o $SCRIPTPATH/go${VERSION}.linux-${ARCH}.tar.gz
		tar -C $HOME -xf "go${VERSION}.linux-${ARCH}.tar.gz"
		rm -f $SCRIPTPATH/go${VERSION}.linux-${ARCH}.tar.gz
	fi
	if command -v go version >/dev/null;then
		echo -e "\033[1;32m[+] Go installed!\033[m"
	else
		echo -e "\033[1;31m[-] An error occurred when trying to install Golang :(\033[m"
		exit
	fi
	export GOPATH=$HOME/go
	export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin
}

apt-get update
apt-get install gunzip -y
apt-get install zip -y
apt-get install git -y
apt-get install python3-pip

mkdir -p ./tools
cd tools/
git clone https://github.com/Cyber-Guy1/Subdomainer.git
cd Subdomainer
chmod +x install && ./install

echo [*] Installing Nuclei vulnerability scanner...
go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest
