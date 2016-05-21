# ufw_autoblock

FUNCTION: Unblock IPs at a defined time and block it again at a defined time. It can also use a different time at the weekend.

## INSTALL
### ------------------------------------
```
  1 = make folder /opt/ufw_autoblock/ (mkdir /opt/autoblock)
  2 = copy autoblock.sh and daemon.sh into this folder
  3 = change in ab.conf the IPs 10.0.0.xx and time to what you want
  4 = make this files executeable (chmod +x autoblock.sh daemon.sh)
  5 = copy ufw_autoblock into /etc/systemd/system/
  6 = activate the service (systemctl enable ufw_autoblock)
```
### --------------------------------------

to start the server use > systemctl start ufw_autoblock <br />
to stop the server use > systemctl stop ufw_autoblock
