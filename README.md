This project provides a Dockerfile which will run a BIND9 DNS server on port 53. The default configuration includes allowing for nsupdates from a tsig-key, which can then be used on a DHCP server to automatically update DNS with DHCP entries.

Before running the dockerfile, ensure the following:
1. Port 53 is open and unused on your host machine. Often systemd-resolved is using it, see FAQ below.
2. Edit the 3 config files to suit your environemnt
	1. named.conf.local should have _your_ zone info. Leave the "allow-update" line to ensure DDNS works
	2. named.conf.options should have your preferred options, specifically recursion and forwarding, ACLs, and desired logging
	3. test.home.zone is a sample zone file. Make necessary edits to match your environments domain and IP range
3. If running rootless podman, ensure port 53 can be mapped by a regular user

