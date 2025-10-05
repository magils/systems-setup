#!/bin/bash

set -e

# Update and upgrade system
echo "Updating system..."
sudo apt update && sudo apt upgrade -y

# Install dependencies
sudo apt install -y curl wget gnupg2 lsb-release apt-transport-https ca-certificates software-properties-common fprintd libpam-fprintd

# Function to add GPG keys and repositories
add_repo_key() {
  curl -fsSL "$1" | sudo gpg --dearmor -o /usr/share/keyrings/"$2"
}

# Install VS Code
echo "Installing VS Code..."
add_repo_key https://packages.microsoft.com/keys/microsoft.asc microsoft.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" | sudo tee /etc/apt/sources.list.d/vscode.list
sudo apt update && sudo apt install -y code

# Install Emacs
echo "Installing Emacs..."
sudo apt install -y emacs

# Install Chrome
echo "Installing Google Chrome..."
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb || sudo apt -f install -y
rm google-chrome-stable_current_amd64.deb

# Install Brave
echo "Installing Brave..."
curl -fsS https://dl.brave.com/install.sh | sh

# Install Terminator
echo "Installing Terminator..."
sudo apt install -y terminator

# Install tmux
echo "Installing tmux..."
sudo apt install -y tmux

# Install Docker
echo "Installing Docker..."
sudo apt-get install ca-certificates curl gnupg lsb-release
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo systemctl enable docker
sudo usermod -aG docker $USER

# Install Minikube
echo "Installing Minikube..."
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
rm minikube-linux-amd64

# Install NVM and Node.js LTS
echo "Installing NVM and Node.js..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
export NVM_DIR="$HOME/.nvm"
source "$NVM_DIR/nvm.sh"
nvm install --lts

# Install Go
echo "Installing Go..."
GO_VERSION=$(curl -s https://go.dev/VERSION?m=text | head -n1)
wget https://go.dev/dl/${GO_VERSION}.linux-amd64.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf ${GO_VERSION}.linux-amd64.tar.gz
rm ${GO_VERSION}.linux-amd64.tar.gz
echo "export PATH=\$PATH:/usr/local/go/bin" >> ~/.bashrc
export PATH=$PATH:/usr/local/go/bin

# Install Ruby
echo "Installing Ruby..."
sudo apt install -y ruby-full

# Install GIMP
echo "Installing GIMP..."
sudo apt install -y gimp

# Update Firefox
echo "Updating Firefox..."
sudo apt install -y firefox

# Install Git
echo "Installing Git..."
sudo apt install -y git

# Setting Up Git
echo "Setting up git username and email..."
git config --global user.email "moisesgilsantana@gmail.com"
git config --global user.name "magils"

# Install Python
echo "Installing Python 3 and pip..."
sudo apt install -y python3 python3-pip

# Install Java 21 (Temurin from Adoptium)
echo "Installing Java 21..."
sudo apt install -y gnupg
wget -O - https://packages.adoptium.net/artifactory/api/gpg/key/public | gpg --dearmor | sudo tee /usr/share/keyrings/adoptium-archive-keyring.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/adoptium-archive-keyring.gpg] https://packages.adoptium.net/artifactory/deb jammy main" | sudo tee /etc/apt/sources.list.d/adoptium.list
sudo apt update && sudo apt install -y temurin-21-jdk

# Install Terraform
echo "Installing Terraform..."
TERRAFORM_VERSION=$(curl -s https://checkpoint-api.hashicorp.com/v1/check/terraform | jq -r .current_version)
TERRAFORM_DOWNLOAD_URL=$(echo https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip)
wget -O terraform.zip $TERRAFORM_DOWNLOAD_URL
unzip terraform.zip -d terraform
sudo mkdir -p /opt/terraform/bin && sudo mv terraform/terraform /opt/terraform/bin/
echo "export PATH=\$PATH:/opt/terraform/bin/" >> ~/.bashrc
rm -fr terraform.zip terraform/

# Install JetBrains Toolbox for PyCharm and IntelliJ
echo "Installing JetBrains Toolbox (for PyCharm & IntelliJ)..."
TOOLBOX_URL='https://download.jetbrains.com/toolbox/jetbrains-toolbox-2.9.1.58121.tar.gz'
wget -O jetbrains-toolbox.tar.gz $TOOLBOX_URL --show-progress
mkdir -p toolbox && tar -xzvf jetbrains-toolbox.tar.gz -C toolbox --strip-components=1
rm -rf jetbrains-toolbox.tar.gz

# Install Postman
echo "Installing Postman..."
flatpak install -y postman

echo "Installing Slack..."
flatpak install -y flathub com.slack.Slack

# Install Zed
flatpak install -y flathub dev.zed.Zed

# Install VLC 
echo "Installing VLC..."
flatpak install flathub -y org.videolan.VLC

# Install Chromium
echo "Installing Chromium..."
flatpak install -y flathub org.chromium.Chromium

# Install Impression
echo "Installing Impression..."
flatpak install -y flathub io.gitlab.adhami3310.Impression

# Install CPU-X
echo "Installing CPU-X..."
flatpak install -y flathub io.github.thetumultuousunicornofdarkness.cpu-x

# Install DBeaver
echo "Installing DBeaver..."
flatpak install -y flathub io.dbeaver.DBeaverCommunity

# Install HTTPie
echo "Installing HTTPie..."
flatpak install -y flathub io.httpie.Httpie

# Install Ghostty
wget -O ghostty.deb https://github.com/mkasberg/ghostty-ubuntu/releases/download/1.2.0-0-ppa2/ghostty_1.2.0-0.ppa2_amd64_24.04.deb --show-progress
sudo dpkg -i ghostty.deb
rm  ghostty*.deb

echo "All tools installed. You may need to restart your system or log out/in for some changes to take effect."
