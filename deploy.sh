# deploy github runner based on docker
# tested on Debian 8.3 x64
# tested on digitalocean and with Vagrant
# v0.1


# CONFIGURATION - edit before deploy
# if your gitlab web interface uses self-signed certificate, provide its url 
_ci_selfsigned_crt=''
# 'hostname' of your github server (eextracted from URL) 
_ci_selfsigned_hostname=''




# URL of Gitlab CI, like 'https://gitlab.com/ci'
_ci_server=''
# Runner token
_ci_token=''
# Runner description
_ci_desc='ci-vagrant'
# Runner tag(s)
_ci_tags='ci-vagrant'


_ci_executor='docker'
_ci_executor_image='ruby:2.1'








# DO NOT EDIT

echoInfo() {
    echo;echo;
    echo $1;
    echo;
}



sudo apt-get install -y vim aptitude htop curl > /dev/null
echoInfo "Updating system"
sudo apt-get update > /dev/null
sudo apt-get -y upgrade > /dev/null
echoInfo "Installing docker"
curl -sSL https://get.docker.com/ | sudo sh > /dev/null && echo "Docker installed"
curl -s -L https://packages.gitlab.com/install/repositories/runner/gitlab-ci-multi-runner/script.deb.sh > s.sh
echoInfo "Preparing environment for Gitlab runner"
sudo bash s.sh > /dev/null
echoInfo "Installing multi-runner"
sudo apt-get -y install gitlab-ci-multi-runner > /dev/null


if [[ -n "$_ci_selfsigned_crt" ]] ; then
    sudo mkdir /etc/gitlab-runner/certs
    curl -s $_ci_selfsigned_crt | sudo tee -a /etc/gitlab-runner/certs/$_ci_selfsigned_hostname.crt > /dev/null
fi



printf $_ci_server$'\n'$_ci_token$'\n'$_ci_desc$'\n'$_ci_tags$'\n'$_ci_executor$'\n'$_ci_executor_image$'\n' | sudo gitlab-ci-multi-runner register && \
    echoInfo "Gitlab runner installed successfully."