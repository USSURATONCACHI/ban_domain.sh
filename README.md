# ban_domain.sh

A simple utility to ban and redirect specific domains and subdomains in linux.

## Redirect domain traffic to specific network device:

Usage:
```bash
./redirect_all_subdomains.sh <to_net_device> <to_gateway> <top_domain>
```

Example (network devices are specified by name, you can check them in `ifconig` of `if show`):
```bash
$ sudo ./redirect_all_subdomains.sh enp5s0 192.168.0.1 vk.com

Received nothing for domain ams.cloud.vk.com
Received 0 errors and 1 lines for domain corp.mvk.com
...all subdomains...
Received nothing for domain www.ads.vk.com
Received 0 errors
Full list of IPs stored at /tmp/tmp.gC2abWvnn2
net.ipv4.ip_forward = 1
Redirecting 172.28.84.1 to enp5s0...
...all domains...
Redirecting 95.213.27.42 to enp5s0...
```

Undo later by using `./unredirect_all_subdomains.sh` with exact same parameters


## Ban specific domains on specific network device:

Usage:
```bash
./ban_all_subdomains.sh <network_device> <top_domain>
```

Example:
```bash
$ sudo ./ban_all_subdomains.com DaringWaxwing vk.com
...
```

Undo later by using `./unban_all_subdomains.sh` with exact same parameters.

## Other utils:
 - Get full list of subdomains per domain: 
	```bash
		$ ./get_domains.sh ipify.org 2> /dev/null
		api.ipify.org
		ipify.org
		lb.ipify.org
		www.api.ipify.org
		www.ipify.org
	```



