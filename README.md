# Princity Agent Auto-Deploy for Linux (Docker & Bare Metal)

This repository provides a streamlined bash script to deploy the **Princity Agent** on any Debian-based system, including fresh Ubuntu/Debian server installs and Docker containers. It automates dependency handling, enables **Remote Panel** support, and manages the initial activation.

## 🚀 One-Line Deployment

To deploy the agent in a single command, open your terminal and run:

```bash
apt update && apt install -y wget && bash <(wget -qO- https://raw.githubusercontent.com/pepijnklaver/Princity-Installation-Linux/refs/heads/main/deploy.sh)

```

---

## 🛠 What this script does

1. **Installs Dependencies:** Downloads `openjdk-17-jre-headless`, `wget`, and `unzip`.
2. **Configures Remote Panel:** Creates an `agent.config` file with `remotePanel=true` before initialization to ensure the feature is active on the first boot.
3. **Downloads Agent:** Fetches the latest agent package directly from the Princity production servers.
4. **Handles Activation:** Launches the official `install_linux.sh` to securely encrypt and store your Agent Key.
5. **Service Startup:** Sets execution permissions and launches the Princity background service.

---

## 📋 Prerequisites

* **Operating System:** Ubuntu, Debian, or other Debian-based distributions (Proxmox, Raspberry Pi OS, etc.).
* **Agent Key:** You must have your Princity Agent Key ready (Format: `XXXX-XXXX-XXXX-XXXX`).
* **Connectivity:** * **Bare Metal:** Ensure ports used by Princity are not blocked by `ufw` or `iptables`.
* **Docker:** Use **Host Mode** networking to ensure local printer discovery and Remote Panel stability.



---

## 📂 Post-Installation Management

The agent is installed in `/opt/princity-agent`. Use the following commands for manual management:

| Action | Command |
| --- | --- |
| **Check Status** | `cd /opt/princity-agent && ./princity-agent status` |
| **Restart Agent** | `cd /opt/princity-agent && ./princity-agent restart` |
| **Stop Agent** | `cd /opt/princity-agent && ./princity-agent stop` |
| **View Logs** | `tail -f /opt/princity-agent/logs/agent.log` |

---

## 🔄 Persistence & Auto-Start

### For Bare Metal / Standard Linux

To ensure the agent starts automatically after a server reboot, add it to your crontab:

1. Run `crontab -e`.
2. Add the following line at the bottom:
`@reboot /opt/princity-agent/princity-agent start`

### For Docker Containers

To ensure the agent starts when the container boots:

1. Set the **Entrypoint** or **Execution Command** to: `sh /opt/princity-agent/run.sh`
2. **Persistence:** Map the internal `/opt/princity-agent` folder to a persistent volume on your host to keep your license/key safe during container updates.

---

## ⚠️ Troubleshooting

* **Key Rejected:** The installer requires the dashes `-`. Ensure the format is exactly `XXXX-XXXX-XXXX-XXXX`.
* **Input Stuck:** If you cannot type your key, ensure you used the `bash <(wget ...)` syntax. Regular piping (`| bash`) blocks interactive keyboard input.
* **Remote Panel Support:** If the dashboard shows "Unsupported," verify the config file:
`cat /opt/princity-agent/agent.config` (Should contain `remotePanel=true`).
* **Discovery Issues:** On Linux servers, ensure your firewall allows SNMP (UDP 161) and the agent's communication ports.
