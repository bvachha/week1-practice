# Week1-practice
### List of project files for topics and excercises of week 1 

#### Project server deployment
1. modify the users to add in the server using the scripts/users_list.txt file. The names configured here will be added to the relevant group and will be configured for ssh access.
2. Run the packer command to build the server using the ubuntu2004.json file 
```
packer build ubuntu2004.json
```
3. Once the server build completes in about 20 minutes or so, the server output files are stored in output_ubuntu_server. 
4. To run the server, use the run_server.sh script. Ensure that it is run with super user privileges as it requires additional privileges for the network configuration.
```sudo ./run_server.sh``` 
5. To log in as a specific user, look for the private key of the user in keys/private and use the following command
```
ssh -i <path to user private key> <username>@<serverip> 
```
6. To test the webserver, try curl once logged in on the local address and the one assigned by dhcp. It should only be accessible through the DHCP assigned IP address and should also be accessible from the host. A startup script will configure apache to listen on the IP assigned at boot. 
#TODO set up a monitoring mechanism to trigger config change on lease expiry, or go with static IP assignments over MAC 

#### Some useful commands for administering linux

**1. Find the processes running on a linux machine**
* To get a snapshot of the list of running processes on a linux machine, you can use the ```ps``` command.
To get a list of all the processes running for all users, use
```
$ ps au
```
To get a list of processes irrespective of whether they were launched over a tty use 
```
$ ps aux
```
* Another option is to use the ```top``` or ```htop``` command to see a dynamic list of processes and their system resource utilization details 
* ```pstree``` provides a list of the processes running in a hierarchial structure 
* ```pgrep``` allows you to search the list of processes for ones that match a specified string in their  process information.

2. Find the users currently logged in
* The ```w``` command will list out the list of logged in users with details about current processes being run by them 
* The ```who``` command also lists out currently logged in users and tty numbers 

3. find the uptime of the machine
* the ```uptime``` command provides the uptime for the machine, along with additional information like the number of users logged on, the CPU load averages for 1,5 and 15 mins and the current time.

4. find the ram usage
* The proc/meminfo file maintains the information about memory usage and can be viewed with ```cat /proc/meminfo```
* ```free``` command will provide details of the memory and swap space like total available, used and free 
* ```vmstat``` also provides memory usage information along with CPU load and block IO loads 

5. find the disk usage
* the ```du``` command will display the disk usage information for a specified directory 
* the ```df``` command will provide information of the amount of disk space used and free for a system 

6. find the inode usage
* the ```df -i``` command will provide details of used and free inodes 

7. find the ulimit of a user
* Use ```sudo -u <username> bash -c "ulimit -Sa"``` to find the soft limits for a given user
* Use ```sudo -u <username> bash -c "ulimit -Ha"``` to find the hard limits for a given user

8. find the ulimit of a process
* To get the ulimits of a process, get the PID of the process using ```ps aux | grep <process_name>```
* Then use ```cat /proc/$pid/limits``` to view the limits set for the process

9. find the file descriptors used by a process
* ```pid=$(pidof mysqld) && sudo ls -l /proc/$pid/fd``` will provide a list of the file descriptors in use by a process. NOTE this command only works if there is a single Pid returned. Multiple PIDs will not work 


10. find the top 5 process by memory usage
* ```ps aux | sed 1d | sort -nr -k4 | head -n 5```


11. find the top 5 process by cpu usage
* ```ps aux | sed 1d | sort -nr -k3 | head -n 5```

12. find the top 5 process by network usage

Todo

13. find the top 5 process by disk iops usage

Todo

14. find the network traffic and bandwidth usage of the machine
* To get the overall bandwith usage we can use the ```vnstat``` command to get a per interface usage
* To get a look at overall network traffic in real time use ```nethogs```
* You can also get this information from other tools like ```netload```,```netwatch```,```bwm-ng```,```iptraf``` but they need to be installed separately

15. Given a file as input, find the processes using that file
* This can be achieved using the ```fuser``` command by providing the filename as an argument 


16. list files opened by a process (ex: sshd, httpd)
* ```pid=$(pidof mysqld) && sudo ls -l /proc/$pid/fd``` will provide a list of the file descriptors in use by a process. NOTE this command only works if there is a single Pid returned. Multiple PIDs will not work 

17. list processes listening on a specific port (ex: 22)
* ```sudo netstat -tulpn | grep :<port_number>``` lists out all the processes listening on a given port. Run it with sudo to ensure that all the service names are retrieved correctly 


18. find the status of a service (ex: httpd)
* ```sudo service <service_name> status``` will give you the status of a service  
19. find zombie processes on a machine
* ```ps aux | grep ' Z '``` will find and return list of zombie processes 
20. find the environment variables set on a machine
* ```env``` or ```printenv``` will list out all the gloabal environment variables 
21. Display processes started by a user
* ```ps -u <username>``` will list out all the processes started by a user 
22. kill a process
* use ```kill -<signal> <pid>``` if you know the pid of the process to kill. The signal can be a value of 1 for hup,2 for keyboard interrupt, 9 for kill or 15 for terminate. A more comprehensive list can be found with the command ```kill -l```
* use ```killall -<signal> <process_name>``` to kill all the processes that match the process name.
23. list open ports
* ```netstat -lntu``` will list out all the tcp and udp port numbers that processes on the server are currently listening to.
24. find the permissions set for a file
* ```ls -l <filename>``` will output the longform listing of the file where the permissions will be displayed in the first column 