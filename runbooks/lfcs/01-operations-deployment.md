# Operations Deployment (25%)
Scope: processes, systemd services, cron/timers, packages/repos, system recovery, libvirt VMs, containers, SELinux.
## systemd & journalctl Basics
- Runtime vs. boot state: `systemctl start/stop/restart <svc>` (now) vs. `systemctl enable/disable <svc>` (boot symlink under `/etc/systemd/system/*.wants/`).
- Start + enable in one step: `sudo systemctl enable --now <svc>`.
- Quick checks: `systemctl is-active <svc>` and `systemctl is-enabled <svc>` (always verify after reboot).
- Service logs: `sudo journalctl -u <svc> -n 20 --no-pager`, `--since "5 minutes ago"`, `-p err -b`.
- Reference: `man 1 systemctl`, `man 1 journalctl`.

## systemd Template Units & Self-Healing
- Template unit naming: `<name>@.service` instantiated via `systemctl start <name>@<instance>`.
- Specifiers (`man 5 systemd.unit`): `%i` = escaped instance string; `%I` = unescaped instance string.
- Auto-recovery: `Restart=on-failure` + `RestartSec=2` restarts crashed/SIGKILLed processes while honoring intentional `systemctl stop`.
- Inspect expanded unit properties: `systemctl show -p WorkingDirectory -p ExecStart lab-backend@2`.
