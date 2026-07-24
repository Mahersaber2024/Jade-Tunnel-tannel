# Jade Tunnel

Interactive management script for [Backhaul](https://github.com/Musixal/Backhaul) reverse tunnels — create, monitor, and manage TCP/TCPMUX/WSMUX/WSSMUX tunnels between an Iran server and a foreign (kharej) server, with systemd services, TLS certs, backups, and live logs, all from one menu.

## Install

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/Mahersaber2024/Jade-Tunnel-tannel/main/install.sh)
```

Run it on **both** servers (Iran and kharej). Requires root.

## Usage

After installation, launch the manager anytime with:

```bash
jadetunnel
```

You'll be asked whether the server is the **Iran** (server) or **Kharej** (client) side, then can create a new tunnel, pick a transport (`tcp`, `tcpmux`, `wsmux`, `wssmux`), and the script handles binary install, TLS cert generation (for `wssmux`), systemd service creation, and firewall notes.

## Requirements

- A Linux VPS with root access, on both ends of the tunnel
- `curl` or `wget`, `openssl` (installed automatically if missing)

## Notes

- `wssmux` is recommended if you want the tunnel to look like ordinary HTTPS traffic.
- Config files live under `/etc/backhaul/`; edit or manage them anytime via the menu (`Manage Tunnels`).
