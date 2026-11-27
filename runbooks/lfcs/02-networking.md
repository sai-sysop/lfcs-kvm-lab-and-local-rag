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


## Linux Sockets (`ss`) & `curl` Diagnostics
- Socket = `Protocol + IP:Port` endpoint managed by the kernel (`ss` replaces legacy `netstat`).
- Core audit command: `sudo ss -tulpn` (`-t` TCP, `-u` UDP, `-l` listening, `-p` process/PID, `-n` numeric) or filtered `sudo ss -tlnp 'sport = :8099'`.
- Bind scope: `127.0.0.1:<port>` is loopback-only; `0.0.0.0:<port>` / `[::]:<port>` listens on all interfaces.
- `curl` checks: `-I` (headers only), `-i` (headers + body), `-v` (full TCP/HTTP trace), `-L` (follow 301/302 redirects), `-s -o /dev/null -w "%{http_code}\n"` (status code only).
- Failure distinction: `Connection refused` = no listening socket on that port; `HTTP 404` = socket reachable, resource path missing.
- Reference: `man 8 ss`, `man 1 curl`.
