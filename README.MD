# ufw_autoblock

Function: Block and Unblock IPs at a special time what you can adjust for every day. Can be used to restrict access for a time for some people to a server with Samba shares or Plex Media Server.

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
