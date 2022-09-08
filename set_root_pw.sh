#!/bin/bash

if [ -f /.root_pw_set ]; then
	echo "Root password already set!"
	exit 0
fi

PASS=${ROOT_PASS:-$(pwgen -s 12 1)}
_word=$( [ ${ROOT_PASS} ] && echo "preset" || echo "random" )
echo "=> Setting a ${_word} password to the root user"
echo "root:$PASS" | chpasswd

echo "=> Done!"
touch /.root_pw_set

echo "========================================================================"
echo "You can now connect to this Debian container via SSH using:"
echo ""
echo "    ssh -p <port> root@<host>"
echo "and enter the root password '$PASS' when prompted"
echo ""
echo "Please remember to change the above password as soon as possible!"
echo "========================================================================"


if [ -z "${SSH_KEY}" ]; then
	echo "=> Please pass your public key in the SSH_KEY environment variable"
	exit 1
fi

for MYHOME in /root /home/docker; do
	echo "=> Adding SSH key to ${MYHOME}"
	mkdir -p ${MYHOME}/.ssh
	chmod go-rwx ${MYHOME}/.ssh
	echo "${SSH_KEY}" > ${MYHOME}/.ssh/authorized_keys
	chmod go-rw ${MYHOME}/.ssh/authorized_keys
	echo "=> Done!"
done
chown -R docker:docker /home/docker/.ssh

echo "========================================================================"
echo "You can now connect to this container via SSH using:"
echo ""
echo "    ssh -p <port> <user>@<host>"
echo ""
echo "Choose root (full access) or docker (limited user account) as <user>."
echo "========================================================================"