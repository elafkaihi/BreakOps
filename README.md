# 💥 BreakOps

> **Learn DevOps by fixing what's broken.**

BreakOps is an open-source, community-driven platform of hands-on labs where you land inside a broken Linux environment, and your only job is to fix it.

No multiple choice. No tutorials. Just a terminal, a problem, and your skills.

---

## 🧠 Philosophy

Most DevOps learning platforms teach you how things *should* work.

BreakOps teaches you what to do when they *don't*.

Every lab drops you into a realistic broken scenario ; a disk that's full, a service that won't start, permissions that are wrong, the kind of things you'll actually face in production. You diagnose, you fix, you learn.

---

## 🚀 Quick Start

```bash
# Install BreakOps CLI
git clone https://github.com/your-username/breakops.git
cd breakops
./install.sh

# Launch your first lab
breakops start linux-001

# Need a hint?
breakops hint

# Validate your fix
breakops check

# Give up? (no shame)
breakops solution
```

> **Requirements:** Docker, Bash, Git

---

## 🗂️ Lab Categories

| Category | Status | Labs |
|---|---|---|
| 🐧 Linux / System | ✅ Available | 8 labs |
| ☸️ Kubernetes | 🔜 Coming soon | — |
| 🏗️ Terraform / IaC | 🔜 Coming soon | — |
| ⚙️ CI/CD | 🔜 Coming soon | — |
| ☁️ AWS | 🔜 Coming soon | — |

---

## 🐧 Linux Labs

| ID | Title | Difficulty | Concept |
|---|---|---|---|
| `linux-001` | Disk Full | 🟢 Easy | Disk usage, `df`, `du`, log cleanup |
| `linux-002` | Permission Hell | 🟡 Medium | `chmod`, `chown`, file permissions |
| `linux-003` | Service Won't Start | 🟡 Medium | nginx config, `nginx -t`, service debugging |
| `linux-004` | Cron Gone Silent | 🟢 Easy | `crontab`, cron daemon, script permissions |
| `linux-005` | SSH Lockout | 🟡 Medium | `sshd_config`, `sshd -t`, `.ssh` permissions |
| `linux-006` | OOM Killer Strikes | 🟡 Medium | `dmesg`, `ps`, memory hog, `pkill` |
| `linux-007` | Firewall Blocked | 🟡 Medium | `iptables`, port rules, `ss -tlnp` |
| `linux-008` | Zombie Apocalypse | 🔴 Hard | Zombie processes, `ppid`, process reaping |

---

## 🔬 How a Lab Works

Each lab is a self-contained Docker container with a broken environment baked in.

```
labs/
  linux-001-disk-full/
    ├── scenario.yaml    # Title, objective, hints, difficulty
    ├── Dockerfile       # Ubuntu base image
    ├── break.sh         # Script that injects the problem
    └── check.sh         # Script that validates your fix
```

When you run `breakops start linux-001`, it:
1. Builds a fresh Docker image with the broken state
2. Drops you into an interactive shell
3. Waits for you to fix the problem
4. Runs `check.sh` to validate when you're ready

---

## 🧩 CLI Reference

```bash
breakops start <lab-id>     # Launch a lab
breakops list               # List all available labs
breakops hint               # Show the next hint (progressive)
breakobs check              # Check if the lab is fixed
breakops solution           # Show the full solution
breakops reset              # Reset the lab to its broken state
```

---

## 📋 Scenario Format

Each scenario is described in a simple YAML file:

```yaml
id: linux-001
title: Disk Full
category: linux
difficulty: easy
objective: "The application can't write logs anymore. Figure out why and fix it."
hints:
  - "Start by checking the available disk space."
  - "Which directory is consuming the most space?"
  - "Logs are usually stored in /var/log — what do you find there?"
solution: |
  The /var/log directory is full of artificially generated log files.
  Run: du -sh /var/log/* to find the culprit.
  Then: rm /var/log/app/debug.log.* to free up space.
  Verify: df -h should show available space restored.
```

---

## 🤝 Contributing

BreakOps lives and grows through community contributions. Adding a new lab is straightforward:

1. Fork the repo
2. Copy `labs/_template/` into a new folder: `labs/<category>-<id>-<short-name>/`
3. Fill in `scenario.yaml`, `Dockerfile`, `break.sh`, `check.sh`
4. Test it locally with `breakops start <your-lab-id>`
5. Open a Pull Request

See [CONTRIBUTING.md](./CONTRIBUTING.md) for the full guide and lab design principles.

---

## 🌍 Roadmap

- [x] MVP — Linux labs + CLI
- [ ] Difficulty progression system
- [ ] Score & completion tracking (local)
- [ ] Kubernetes labs
- [ ] Terraform / IaC labs
- [ ] Web UI for lab browser
- [ ] Community lab submissions
- [ ] CI validation for contributed labs

---

## 📄 License

MIT : free to use, fork, and contribute.

---

*Built by DevOps engineers, for DevOps engineers.*
*Break things. Fix them. Get better.*
