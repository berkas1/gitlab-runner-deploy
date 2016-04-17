# deploy github runner based on docker
# tested on Debian 8.3 x64
# tested on digitalocean and with Vagrant


_ci_server='https://git.hosting.berkasimon.com:1001'
_ci_token='Kf1G2gbtWrRrr3vHNzig'
_ci_tags='ci-vagrant'
_ci_executor='docker'
_ci_executor_image='ruby:2.1'

sudo apt-get install vim aptitude htop curl
sudo aptitude update
sudo aptitude upgrade
sudo curl -sSL https://get.docker.com/ | sh
sudo curl -L https://packages.gitlab.com/install/repositories/runner/gitlab-ci-multi-runner/script.deb.sh >s.sh
sudo bash s.sh
sudo aptitude install gitlab-ci-multi-runner

printf $_ci_server$'\n'$_ci_token$'\n'_ci_tags$'\n'$_ci_executor$'\n'$_ci_executor_image$'\n'