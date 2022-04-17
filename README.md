# Description

This Ansible role will setup open-source SAST tools and run code scanning on your own server. They can detect secrets, CVEs, CWEs on source code. I support three languages Javascript, Python and Golang now. If you want to support more languages, inbox me at tuanndd@gmail.com

# User guide

## Step 1: Setup a Linux Ubuntu 20.04 server

I use Vagrant VM here. 

```bash
# vagrant box add bento/ubuntu-20.04 --insecure

# vagrant up ...
# vagranr ssh ...

# install Ansible
sudo apt update
sudo apt install ansible -y
ansible --version

# install Docker: https://docs.docker.com/engine/install/ubuntu/ 
```

## Step 2: Install STATS tools
```bash
git clone https://github.com/tuanndd/ansible-code-scanning.git
cd ansible-code-scanning
ansible-playbook install.yml
```

As a result, you get STATS tools installed in default $HOME/sast directory.

## Step 3: Run code scanning on source code

### Javascript example
```bash
git clone https://github.com/appsecco/dvna.git $HOME/jssrc
$HOME/sast/scan-javascript-code.sh $HOME/jssrc $HOME/jsreport
# view scan results in $HOME/jsreport
```



### Python example
```bash
git clone https://github.com/anxolerd/dvpwa.git $HOME/pysrc
$HOME/sast/scan-python-code.sh $HOME/pysrc $HOME/pyreport
# view scan results in $HOME/pyreport
```

### Golang example
```bash
git clone https://github.com/sqreen/go-dvwa.git $HOME/gosrc
$HOME/sast/scan-go-code.sh $HOME/gosrc $HOME/goreport
# view scan results in $HOME/goreport
```

# References
- https://docs.gitlab.com/ee/user/application_security/sast/