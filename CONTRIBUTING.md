# Contributing to BreakOps

BreakOps grows through community labs. If you've hit an interesting problem in production, turn it into a lab. Here's how.

---

## Lab Design Principles

**1. Realistic over synthetic**
The scenario should feel like something that actually happens on a real server or cluster. Avoid abstract or academic setups.

**2. One root cause (or two related ones)**
Don't pile on 5 unrelated issues. A good lab has 1–2 connected problems. The second issue ideally surfaces only after the first is fixed.

**3. Discoverable with the right commands**
The user should be able to find the problem using standard Linux/DevOps tooling. The lab teaches both the fix AND the diagnostic process.

**4. Clear validation**
`check.sh` must be unambiguous. Either it passes or it doesn't. Avoid flaky checks.

**5. Honest difficulty**
Easy = one command fixes it. Medium = requires 2–3 steps and some diagnosis. Hard = multi-step, requires understanding of the system.

---

## Adding a New Lab

### 1. Fork and clone the repo

```bash
git clone https://github.com/your-username/breakops.git
cd breakops
```

### 2. Copy the template

```bash
cp -r labs/_template labs/<category>-<id>-<short-name>
# Example: labs/linux-004-cron-overload
```

### 3. Fill in the 4 files

| File | What to write |
|---|---|
| `scenario.yaml` | ID, title, difficulty, objective, hints (4), solution |
| `Dockerfile` | Base image + any packages + MOTD |
| `break.sh` | Commands that inject the broken state |
| `check.sh` | Validation logic, clear pass/fail output |

### 4. Test locally

```bash
./breakops start linux-004
# Fix the lab manually to verify it's solvable
./breakops check   # from another terminal
./breakops solution
```

### 5. Open a Pull Request

PR title: `feat: add linux-004 — cron overload`

Include in the PR description:
- What the scenario simulates
- How you validated the fix works
- Any special Docker flags needed

---

## ID Naming Convention

```
<category>-<number>-<slug>

linux-004-cron-overload
kubernetes-001-crashloop
terraform-001-state-locked
```

Categories: `linux`, `kubernetes`, `terraform`, `cicd`, `aws`

Numbers are sequential within each category. Check existing labs to pick the next number.

---

## Questions?

Open an issue or start a discussion on GitHub.
