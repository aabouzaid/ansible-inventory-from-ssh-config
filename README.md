# ansible-inventory-from-ssh-config
Simple Bash and AWK script to generate Ansible inventory from SSH config file, it's really simple and assume you have "Host", "Hostname", "Port", "User" in separated lines, and valid SSH config file (there are no checks or tests done at all).

How to use?
--------------

You can run it directly, and it will use your default ssh config file (~/.ssh/config):
```
bash ./generate_ansible_inventory_from_ssh_config.sh
```

Also you can use specific ssh config file by passing it to the script:
```
bash ./generate_ansible_inventory_from_ssh_config.sh ~/any_ssh_config_file
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
```
Server1 ansible_ssh_host=10.0.0.1 ansible_ssh_port=22 ansible_ssh_user=xuser
Server2 ansible_ssh_host=10.0.0.2 ansible_ssh_port=22 ansible_ssh_user=xuser
```
