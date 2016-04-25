#! /bin/bash
#This snippet assume each "Host", "Hostname", "Port", "User" in separated line, and valid ssh config file.

# Main vars.
config_file=~/.ssh/config

# Help message.
help_message () { cat << EOF
Syntax:
  ./$0 [-s ansible_version] [-f ssh_config_file]

Options:
  -h/--help
    Display this help message.
  -s/--syntax
    Ansible syntax, e.g. v1 or v2 (default: v2).
  -f/--file
    The path of SSH config file (default: ~/.ssh/config).

EOF
}

# Check arguments of the script.
while test -n "$1"; do
    case "$1" in
        --help|-h)
            help_message
            exit 0
            ;;
        --syntax|-s)
            ansible_version="$2"
            shift
            ;;
        --file|-f)
            config_file="$2"
            shift
            ;;
        *)
            echo "Unknown argument: $1"
            help_message
            exit 1
            ;;
        esac
    shift
done

# Check config var is not empty.
if [[ -z ${config_file} ]]; then
    help_message
    exit 1
fi 

# Check Ansible version.
if [[ ${ansible_version} == "v1" ]]; then
    ansible_syntax="ansible_"
else
    ansible_syntax=""
fi 

# Set Ansible syntax.
ansible_host="${ansible_syntax}ssh_host="
ansible_port="${ansible_syntax}ssh_port="
ansible_user="${ansible_syntax}ssh_user="

# Replace SSH config style with Ansible style.
ssh_conf_to_ansible () {
awk -v host="${ansible_host}" -v port="${ansible_port}" -v user="${ansible_user}" \
  'BEGIN{IGNORECASE=1}
   {
      gsub(/\s+/," ");
      gsub("Host ","");
      gsub("Hostname ",host);
      gsub("Port ",port);
      gsub("User ",user);
   };
   NR%4{printf $0" ";
      next;
   }1'
}

# Get "Host", "Hostname", "Port", and "User" from SSH config file.  
grep -P -i "^(Host|\s*Hostname|\s*Port|\s*User)" ${config_file} | ssh_conf_to_ansible
