# ansible-inventory-from-ssh-config
Simple Bash and AWK script to generate Ansible inventory from SSH config file, it's really simple and assume you have "Host", "Hostname", "Port", "User" in separated lines, and valid SSH config file (there are no checks or tests done at all).

How to use?
--------------
```
./generate_ansible_inventory_from_ssh_config.sh -h

Description:
  Simple Bash and AWK script to generate Ansible inventory from SSH config file.
  This script assumes you have "Host", "Hostname", "Port", "User" in separated lines,
  and valid SSH config file (there are no checks or tests done at all).

Syntax:
  ./generate_ansible_inventory_from_ssh_config.sh [-s ansible_version] [-f ssh_config_file]

Options:
  -h/--help
    Display this help message.
  -s/--syntax
    Ansible syntax, e.g. v1 or v2 (default: v2).
  -f/--file
    The path of SSH config file (default: ~/.ssh/config).

```


You can run it directly, and it will use your default ssh config file (~/.ssh/config) and using Ansible v2.x syntax:
```
./generate_ansible_inventory_from_ssh_config.sh
```

You can specify ssh config file using "-f" or Ansible v1.x using "-s v1":
```
./generate_ansible_inventory_from_ssh_config.sh -s v1 -f ~/any_ssh_config_file
```

Output example?
--------------

If you have ssh config file like this:
```
Host Server1
  Hostname 10.0.0.1
  Port 22
  User xuser

Host Server2
  Hostname 10.0.0.2
  Port 22
  User xuser
  ```

You will get that:
Ansible v2.0 syntax:
```
Server1 ssh_host=10.0.0.1 ssh_port=22 ssh_user=xuser
Server2 ssh_host=10.0.0.2 ssh_port=22 ssh_user=xuser
```

Ansible v1.0 syntax:
```
Server1 ansible_ssh_host=10.0.0.1 ansible_ssh_port=22 ansible_ssh_user=xuser
Server2 ansible_ssh_host=10.0.0.2 ansible_ssh_port=22 ansible_ssh_user=xuser
```


