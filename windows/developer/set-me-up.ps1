# Git 
winget install -e --id Git.Git

# Visual Studio Code
winget install -e --id Microsoft.VisualStudioCode

# Firefox
winget install -e --id Mozilla.Firefox

# Brave
winget install -e --id Brave.Brave

# Chrome 
winget install -e --id Google.Chrome

# Postman
winget install -e --id Postman.Postman

# Docker
winget install -e --id Docker.DockerDesktop

# IntelliJ
winget install -e --id JetBrains.IntelliJIDEA.Community.EAP

# PyCharm 
winget install -e --id JetBrains.PyCharm.Community.EAP

# Android Studio
winget install -e --id Google.AndroidStudio

# Python 3
winget install -e --id Python.Python.3.11

# Terraform 
winget install -e --id Hashicorp.Terraform

# Notion
winget install -e --id Notion.Notion

# DBeaver
winget install -e --id dbeaver.dbeaver

# Mongo Compass
winget install -e --id MongoDB.Compass.Full

# Bitwarden
winget install -e --id Bitwarden.Bitwarden

# Windows Terminal
winget install -e --id Microsoft.WindowsTerminal

# Enable WSL
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart

# Launch default apps, type "Brave" and make Brave as default
start ms-settings:defaultapps 