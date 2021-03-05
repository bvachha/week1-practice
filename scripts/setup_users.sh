#!/bin/bash -x
echo "Setting up users"
# create the intern group
echo "Creating group: interns"
groupadd intern
# create an array of users
echo "Loading in users list" 
user_array=( $(cat scripts/users_list.txt) ) 
for user in "${user_array[@]}"
do
	echo "Creating user $user"
	useradd -m -G intern $user
	mkdir -p "/home/$user/.ssh" && touch "/home/$user/.ssh/authorized_keys" 
	cat "/home/ubuntu/keys/${user}.pub" >> /home/$user/.ssh/authorized_keys
	chmod 700 "/home/$user/.ssh" && chmod 600 "/home/$user/.ssh/authorized_keys"
	chown -R $user:$user /home/$user/.ssh
done
