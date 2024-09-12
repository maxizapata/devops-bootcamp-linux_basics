#!/bin/bash

# Script to install java and check if the version is greater than 11

GREEN="\033[0;32m"
RED="\033[0;31m"
NC='\033[0m'
BOLD=$(tput bold)
NORMAL=$(tput sgr0)

PRINT_MSG() {
	printf "${GREEN}${BOLD}**** $1 ****${NORMAL}${NC}\n"
}

PRINT_ERR_MSG() {
	printf "${RED}${BOLD}**** $1 ****${NORMAL}${NC}\n"
}

PRINT_MSG "Checking if Java is installed."
which java > /dev/null 2>&1

if [[ $? -ne 0 ]]; then
	echo "Java is not installed, sending command to install the latest version. This operation can take some minutes, please wait!"
	echo "You can see installation details in java_install.log file."
	apt-get install default-jdk -y > java_install.log 2>&1
	if [[ $? -eq 0 ]]; then
		echo "Java was installed successfully. You can see details in java_install.log file."
	else
		PRINT_ERR_MSG "Error installing Java. See java_install.log for details."
		exit 1
	fi
else
	echo "Java is already installed"
fi

PRINT_MSG "Checking java version."
JAVA_VERSION=$(java --version 2> /dev/null | head -n 1 | awk '{print $2}' | awk -F '.' '{print $1}')

echo -n "Your Java version is $JAVA_VERSION, "

if [[ $JAVA_VERSION -ge 11 ]]; then
	echo "it is equal or higher than Java 11"
else
	echo "it is lower than Java 11"
fi
