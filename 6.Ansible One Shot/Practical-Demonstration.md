# ⚙️ Ansible Zero-to-Hero — Complete Beginner's Notes
> By **@codeWithMonil** | Automate two servers at once with a single file. No local terminal needed.

---

## 🧠 What is Ansible?
Ansible is an **automation tool** that lets you configure, install, and manage multiple servers simultaneously — using just one file written in simple YAML.

| Term | Meaning |
|------|---------|
| **Control Node** | The machine running Ansible (we use AWS CloudShell) |
| **Target Node** | The servers Ansible is managing (our EC2 instances) |
| **Inventory** | A file listing all your target servers |
| **Playbook** | A YAML file describing what Ansible should do |
| **Task** | A single action inside a playbook |
| **Handler** | A task that only runs when triggered (e.g. restart a service) |
| **Module** | A built-in Ansible function (e.g. `apt`, `yum`, `copy`, `service`) |

---

## 🏗️ Phase 1 — AWS Infrastructure Setup

> Spin up **2 EC2 servers** that Ansible will manage.

### Security Group: `ansible-web-sg`
| Rule | Port | Source |
|------|------|--------|
| SSH | 22 | 0.0.0.0/0 |
| HTTP | 80 | 0.0.0.0/0 |

### Server 1 — Ubuntu
```
Name:          Ubuntu-Web
AMI:           Ubuntu 24.04 LTS
Instance Type: t2.micro
Key Pair:      ansible-demo-key  ← Download the .pem file!
Security Group: ansible-web-sg
```

### Server 2 — Amazon Linux
```
Name:          RHEL-Web
AMI:           Amazon Linux 2023
Instance Type: t2.micro
Key Pair:      ansible-demo-key  ← Same key as above!
Security Group: ansible-web-sg
```

> 💡 **Why same key?** Ansible needs one key to SSH into both servers. Always reuse the same key pair for servers in the same demo/project.

---

## ☁️ Phase 2 — CloudShell Setup (Your Control Node)

> We use **AWS CloudShell** so you don't need to install anything on your laptop.

### Step 1 — Upload your SSH Key
```
CloudShell → Actions → Upload File → select ansible-demo-key.pem
```

### Step 2 — Secure the Key
```bash
# AWS/Linux requires strict permissions on SSH keys
chmod 400 ansible-demo-key.pem
```

### Step 3 — Install Ansible
```bash
python3 -m pip install --user ansible
```

### Step 4 — Verify Installation
```bash
ansible --version
```

---

## 📋 Phase 3 — The Inventory File (`hosts.ini`)

> This file tells Ansible **which servers to talk to** and **how to connect**.

### Create the file
```bash
vim hosts.ini
```
> Press `i` to enter Insert Mode, paste your content, then press `Esc` → type `:wq` → hit `Enter` to save.

### Inventory Content
```ini
[webservers]
ubuntu_server ansible_host=YOUR_UBUNTU_IP ansible_user=ubuntu ansible_ssh_private_key_file=./ansible-demo-key.pem
rhel_server   ansible_host=YOUR_RHEL_IP   ansible_user=ec2-user ansible_ssh_private_key_file=./ansible-demo-key.pem
```

> ⚠️ **Common Mistake:** Replace `YOUR_UBUNTU_IP` and `YOUR_RHEL_IP` with the actual **Public IPv4 addresses** from your EC2 dashboard. Also make sure the `.pem` filename matches exactly what you uploaded.

### Breakdown of each part
| Part | Meaning |
|------|---------|
| `[webservers]` | Group name — you can target this group in playbooks |
| `ansible_host` | The public IP of the server |
| `ansible_user` | SSH login user (`ubuntu` for Ubuntu, `ec2-user` for Amazon Linux) |
| `ansible_ssh_private_key_file` | Path to your `.pem` key |

---

## 🔔 Phase 4 — Ad-Hoc "Mic Check"

> Before writing a full playbook, **test the connection** with a quick one-liner.

```bash
ansible webservers -i hosts.ini -m ping
```

### Expected Output ✅
```
ubuntu_server | SUCCESS => { "ping": "pong" }
rhel_server   | SUCCESS => { "ping": "pong" }
```

> 💡 **What is an Ad-Hoc command?** A one-time Ansible command run directly in the terminal — no playbook needed. Great for quick checks.

---

## 📜 Phase 5 — The Master Playbook (`setup_web.yml`)

> One YAML file. Two completely different servers. One command to run it all.

### Create the file
```bash
vim setup_web.yml
```

### Full Playbook
```yaml
---
- name: Hybrid Web Server & Docker Configuration
  hosts: webservers
  become: yes                        # Run tasks as sudo/root

  vars:
    page_title: "Ansible One-Shot Crash Course"

  tasks:

    # ── 1. LOOPS — Runs on BOTH servers ──────────────────────────────────────
    - name: Install utility packages
      package:
        name: "{{ item }}"
        state: present
      loop:
        - git
        - wget

    # ── 2. UBUNTU ONLY — Install Apache ──────────────────────────────────────
    - name: Install Apache on Ubuntu
      apt:
        name: apache2
        state: present
        update_cache: yes            # Same as running 'apt update' first
      when: ansible_os_family == "Debian"

    - name: Create custom index.html for Ubuntu
      copy:
        dest: /var/www/html/index.html
        content: |
          <html>
            <body style="background-color: #282c34; color: white; text-align: center; font-family: sans-serif; padding-top: 50px;">
              <h1>{{ page_title }}</h1>
              <h2>Hosted on: Ubuntu (Apache)</h2>
            </body>
          </html>
      when: ansible_os_family == "Debian"
      notify: Restart Apache         # Triggers the handler below

    # ── 3. AMAZON LINUX ONLY — Docker + Nginx ────────────────────────────────
    - name: Install Docker on Amazon Linux
      yum:
        name: docker
        state: present
      when: ansible_os_family == "RedHat"

    - name: Ensure Docker service is running
      service:
        name: docker
        state: started
        enabled: yes
      when: ansible_os_family == "RedHat"

    - name: Deploy Nginx Container
      shell: |
        if ! docker ps | grep -q my_nginx; then
          docker run -d -p 80:80 --name my_nginx nginx
        fi
      when: ansible_os_family == "RedHat"

  # ── 4. HANDLERS ─────────────────────────────────────────────────────────────
  handlers:
    - name: Restart Apache
      service:
        name: apache2
        state: restarted
```

---

## 🔑 Key Concepts Used in This Playbook

### `become: yes`
```yaml
become: yes   # Tells Ansible to run all tasks with sudo privileges
```

### Variables (`vars`)
```yaml
vars:
  page_title: "Ansible One-Shot Crash Course"

# Used later as:
content: "<h1>{{ page_title }}</h1>"
```

### Loops
```yaml
loop:
  - git
  - wget
# Ansible runs the task once for each item in the list
```

### Conditionals (`when`)
```yaml
when: ansible_os_family == "Debian"   # Only runs on Ubuntu
when: ansible_os_family == "RedHat"   # Only runs on Amazon Linux
```
> 💡 `ansible_os_family` is a **magic variable** Ansible detects automatically from the server. You don't set it — Ansible reads it.

### Handlers
```yaml
notify: Restart Apache   # Sends a signal to the handler

handlers:
  - name: Restart Apache
    service:
      name: apache2
      state: restarted
# Handler only runs IF the "Create index.html" task actually made a change
```

### Modules Used
| Module | Purpose |
|--------|---------|
| `package` | Generic — installs on any OS |
| `apt` | Install packages on Ubuntu/Debian |
| `yum` | Install packages on Amazon Linux/RHEL |
| `copy` | Copy content or files to a server |
| `service` | Start/stop/restart system services |
| `shell` | Run raw shell commands |

---

## 🚀 Phase 6 — Run the Playbook

```bash
ansible-playbook -i hosts.ini setup_web.yml
```

### Watch for these in the output
| Output Color | Meaning |
|---|---|
| 🟢 `ok` | Task ran, no changes needed |
| 🟡 `changed` | Task ran and made a change |
| 🔵 `skipping` | Task was skipped due to `when` condition |
| 🔴 `failed` | Something went wrong |

---

## ✅ The Proof — Open in Your Browser

| Server | URL | Expected Result |
|--------|-----|-----------------|
| Ubuntu | `http://YOUR_UBUNTU_IP` | Custom dark-mode Ansible page |
| Amazon Linux | `http://YOUR_RHEL_IP` | Default "Welcome to nginx!" page |

---

## 🧹 Cleanup — Avoid Surprise AWS Bills!

> ⚠️ **Do this after every demo!**

```
AWS Console → EC2 → Select both instances → Instance State → Terminate
```

---

## 📌 Quick Reference — Full Command List

```bash
# Install Ansible
python3 -m pip install --user ansible

# Secure your SSH key
chmod 400 ansible-demo-key.pem

# Test connectivity
ansible webservers -i hosts.ini -m ping

# Run the playbook
ansible-playbook -i hosts.ini setup_web.yml

# Run with verbose output (great for debugging)
ansible-playbook -i hosts.ini setup_web.yml -v

# Dry run — see what WOULD change without actually changing anything
ansible-playbook -i hosts.ini setup_web.yml --check
```

---

## 🧱 Ansible Flow — Mental Model

```
You write a Playbook (YAML)
        ↓
Ansible reads the Inventory (hosts.ini)
        ↓
Ansible SSHs into each Target Node
        ↓
Runs Tasks in order, top to bottom
        ↓
Skips tasks where 'when' condition is false
        ↓
Fires Handlers if notified
        ↓
Reports results back to your terminal
```

---

*Notes by @codeWithMonil — share, learn, build. 🚀*