# deploy github runner based on docker
# tested on Debian 9 x64
# tested on digitalocean and with Vagrant
# v0.2


# CONFIGURATION - edit before deploy
# if your gitlab web interface uses self-signed certificate, provide its url 
_ci_selfsigned_crt=''
# 'hostname' of your github server (extracted from URL) 
_ci_selfsigned_hostname=''




# URL of Gitlab CI, like 'https://gitlab.com/'
_ci_server=''

# Runner token
_ci_token=''

# Runner description
_ci_desc='ci-vagrant'

# Runner tag(s)
_ci_tags='ci-vagrant'

# Run untagged builds
#_ci_untagged='true'

# Lock Runner to current project
#_ci_lock='false'

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
sudo aptitude update > /dev/null
sudo aptitude -y upgrade > /dev/null

echoInfo "Installing docker"
curl -sSL https://get.docker.com/ | sudo sh > /dev/null && echo "Docker installed"
sudo usermod -aG docker vagrant
curl -s -L https://packages.gitlab.com/install/repositories/runner/gitlab-ci-multi-runner/script.deb.sh > s.sh
echoInfo "Preparing environment for Gitlab runner"
sudo bash s.sh > /dev/null

echoInfo "Installing multi-runner"
sudo aptitude -y install gitlab-ci-multi-runner > /dev/null


if [[ -n "$_ci_selfsigned_crt" ]] ; then
    sudo mkdir /etc/gitlab-runner/certs
    curl -s $_ci_selfsigned_crt | sudo tee -a /etc/gitlab-runner/certs/$_ci_selfsigned_hostname.crt > /dev/null
fi



sudo gitlab-ci-multi-runner register -n --url="$_ci_server" --registration-token="$_ci_token" \
  --description="$_ci_desc" --tag-list="[$_ci_tags]" --executor="$_ci_executor" \
  --docker-image="$_ci_executor_image" --run-untagged