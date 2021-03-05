#!/bin/bash -x
echo "Creating user login identities"
echo "Loading users list"
user_array=( $(cat scripts/users_list.txt) )

mkdir -p keys/public
mkdir -p keys/private 
if [ "$(ls -A keys/public)" ]; then
	echo "Keys exist from a previous run, deleting old keys"
	rm keys/public/*
	rm keys/private/*
fi

for user in "${user_array[@]}"
do
	echo "Creating key pair for user $user"
	ssh-keygen -C "$user" -f "keys/$user" -t rsa -N "" 
done
mv keys/*.pub keys/public/
mv keys/* keys/private/
mv keys/private/public keys/