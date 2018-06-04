sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

sh -c 'echo deb https://apt.dockerproject.org/repo ubuntu-trusty main > /etc/apt/sources.list.d/docker.list'

# Install docker
sudo apt-get update
sudo apt-get purge lxc-docker
sudo apt-get install linux-image-extra-$(uname -r)
sudo apt-get install docker-engine
sudo service docker start

sudo usermod -aG docker $USER
