
# ⚡ Global IDE (Terminal Edition) v1.0

Welcome to **Global IDE**, a modular, high-performance command-line environment designed for developers who demand speed, minimalism, and full control over their GitHub ecosystem without leaving the terminal.

> **"Built by a developer, for developers who live in the shell."**

---

## 🏗️ Project Structure

The project is built on a **Modular Micro-Kernel** architecture. The main script handles the UI and navigation, while specialized logic is delegated to independent modules.

```text
gh-scripts/
├── gh-scripts.sh         # Main Entry Point (UI & Navigation)
├── install.sh            # Dependency Installer (gh, fzf, jq, fonts)
├── setup.sh               # Environment & Directory Setup
├── README.md              # Project Story & Overview
│
├── core/                  # The "Brain" (Modular Logic)
│   ├── ui_render.sh       # Logo & Screen Rendering
│   ├── pr_manager.sh      # Pull Request Logic
│   ├── snippet_manager.sh # FZF-based Code Snippets
│   ├── secret_manager.sh  # GitHub Secrets API
│   └── ... (other modules)
│
├── automations/           # User-defined local scripts
├── templates/             # Code snippet storage
└── docs/                  # Technical documentation
    └── user_guide.md      # Detailed operational manual
```

---

## 🧠 The Journey: Ideation, Planning & Execution

### 1. Ideation (The "Why")
The project started with a simple problem: **Context Switching**. Constant switching between the terminal and the GitHub web interface was killing productivity. 
* **Goal:** Create a "Terminal-First" experience where GitHub Actions, Pull Requests, and local Snippets coexist in a single, unified interface.
* **Core Philosophy:** No heavy frameworks. Just pure Bash, powered by industry-standard CLI tools (`gh`, `fzf`, `jq`).

### 2. Planning (The Architecture)
We moved from a monolithic script to a **Source-Based Module System**.
* **Scalability:** New features should be added by simply dropping a `.sh` file into the `core/` folder.
* **Consistency:** Every module must inherit the user's color preferences (`$MY_COL`) and utilize **Nerd Font** glyphs for a modern aesthetic.
* **Efficiency:** Use `fzf` for all list-based interactions to ensure sub-second response times.

### 3. Execution (The Creation Process)
* **Phase Alpha:** Building the UI engine and the color-preference system.
* **Phase Beta:** Integrating `gh` CLI for real-time data fetching (Actions & PRs).
* **Phase Gamma:** Implementing the **Nerd Font** layer and the dynamic module loader.
* **Phase Delta:** Finalizing the `install` and `setup` suites for a "Zero-Config" experience.

---

## 🛠️ Key Features: What does it do?

* **Project Orchestration:** Navigate your local repositories and verify cloud sync status instantly.
* **Code Review Pro:** Preview, Checkout, and Approve Pull Requests using a fuzzy-search interface.
* **CI/CD Monitoring:** Watch your GitHub Actions logs and statuses in real-time.
* **Secret Vault:** Manage repository environment variables securely from the command line.
* **Smart Snippets:** A library for your most-used code fragments, categorized with dynamic icons and clipboard support.
* **Alias Wizard:** Automate your most frequent terminal commands on the fly.

---

## 🚀 How to Use It

1. **Deploy:** Run `bash install.sh` followed by `bash setup.sh`.
2. **Authenticate:** Ensure you are logged into GitHub via `gh auth login`.
3. **Launch:** Run `./gh-scripts.sh`.
4. **Interact:** Use the arrow keys to navigate and `Enter` to dive into any module.

*For detailed command references and troubleshooting, please refer to the [User Guide](docs/USER_GUIDE.md).*

---

## 📈 Future Roadmap
* [ ] **Git Dashboard 2.0:** Visual graphs of commit history in ASCII.
* [ ] **Extension Store:** Ability to download community-made modules directly into `core/`.
* [ ] **Plugin System:** Support for Python-based modules alongside Bash.

---

## 🤝 Contributing
This is an open-source project. Feel free to fork, add your own modules to the `core/` folder, and submit a Pull Request.

**Created by Maximiliano Flores** | *Empowering terminal-based workflows.*

