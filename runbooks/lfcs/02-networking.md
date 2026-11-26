# Networking (25%)
Scope: ip/nmcli/netplan, DNS, chrony/NTP, OpenSSH, firewalls (nftables/ufw/firewalld), bridges/bonding, reverse proxies/load balancers.
## Reverse Proxy, Load Balancing & curl (Nginx)
- Reverse proxy vs. LB: `proxy_pass` forwards client traffic to a backend; `upstream` defines a backend pool (default round-robin; passive failover via `max_fails` and `fail_timeout`, default 10s).
- Preserve client identity: set `proxy_set_header Host $host`, `X-Real-IP $remote_addr`, and `X-Forwarded-For $proxy_add_x_forwarded_for`.
- Stateless scaling rule: never keep user sessions in backend RAM behind round-robin (causes intermittent 401s); externalize state (e.g., Redis) instead of relying on sticky sessions (`ip_hash`).
- Rocky Linux 9 SELinux prerequisite: `sudo setsebool -P httpd_can_network_connect 1` allows `nginx` (`httpd_t`) to proxy to upstream ports without 502 errors.
- Always test config before reload: `sudo nginx -t && sudo systemctl reload nginx`.
- Docker note: prefer `docker network create` (built-in DNS) over deprecated `--link`.
- `curl` essentials: `-s` (silent), `-i` (headers+body), `-I` (headers only), `-v` (verbose), `-c`/`-b` (save/send cookies), `-H` (custom header).
- Reference: `man 8 nginx`, `man 1 curl`, `man 8 setsebool`.

