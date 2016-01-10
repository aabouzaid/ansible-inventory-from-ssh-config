#! /bin/bash
#This snippet assume each "Host", "Hostname", "Port", "User" in separated line, and valid ssh config file.

if [[ -n $1 ]]; then
  config_file="$1"
else
  config_file=~/.ssh/config
fi
 
ssh_conf_to_ansible () {
awk 'BEGIN{IGNORECASE=1}
     {gsub(/\s+/," ");
      gsub("Host ","");
      gsub("Hostname ","ansible_ssh_host=");
      gsub("Port ","ansible_ssh_port=");
      gsub("User ","ansible_ssh_user=")};
 NR%4{printf $0" ";
      next;
     }1'
}
 
grep -P -i "^(Host|\s*Hostname|\s*Port|\s*User)" ${config_file} | ssh_conf_to_ansible
