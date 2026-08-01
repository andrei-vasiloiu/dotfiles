# Dotfiles

Reproducible Debian development environments for WSL2 and native Debian laptops.
The repository uses GNU Stow for configuration and small, rerunnable shell scripts
for installation, platform setup, desktop configuration, and validation.

## What is included

- Bash, Git, tmux, and Neovim
- Python tooling through uv
- Node.js and pnpm through mise
- TypeScript and .NET tooling, including Roslyn
- Rootless Podman
- Pi coding agent
- Sway, Wayland utilities, and native laptop integration
- Common CLI utilities for development, system inspection, networking, APIs, and documentation
- Health checks for commands, dotfiles, versions, systemd, and native services

Pinned versions are maintained in `scripts/versions.env`.

## Repository layout

```text
bash/       Bash configuration
bin/        User commands
desktop/    Native desktop application entries
foot/       Foot configuration
git/        Git configuration
gtk/        GTK configuration
mise/       Runtime configuration
nvim/       Neovim configuration
pi/         Pi settings, prompts, skills, themes, and extensions
sway/       Sway configuration
tmux/       tmux configuration
packages/   APT package manifests
native/     Native system configuration, including greetd
scripts/    Installers, platform setup, and health checks
bootstrap   Shared installation entry point
```

## Prerequisites

The setup targets x86_64 Debian 13 with `systemd`. Start from a normal Debian
user with `sudo` access, then install the tools needed to clone the repository:

```bash
sudo apt update
sudo apt install -y git curl ca-certificates openssh-client sudo
```

Configure GitHub SSH authentication, then clone the repository:

```bash
mkdir -p ~/src/github.com/andrei-vasiloiu
cd ~/src/github.com/andrei-vasiloiu
git clone git@github.com:andrei-vasiloiu/dotfiles.git
git -C dotfiles switch develop
cd dotfiles
```

## WSL2 setup

Run the WSL preparation script first. It enables systemd, configures the default
user, disables the unnecessary WSL getty, and enables user lingering:

```bash
./scripts/configure-wsl
```

Restart the distribution from PowerShell:

```powershell
wsl --terminate Debian
wsl -d Debian
```

Then install the shared environment and apply the shared dotfiles:

```bash
cd ~/src/github.com/andrei-vasiloiu/dotfiles
./bootstrap
```

`bootstrap` installs the common and WSL package manifests, fonts, language and
development tools, and shared Stow packages. It finishes by running the health
check.

## Native Debian setup

Run the single native entry point on a native Debian installation:

```bash
./scripts/setup-native
```

It runs these stages in order:

1. Install native Debian packages.
2. Run `bootstrap` for the shared environment.
3. Apply the native desktop configuration.
4. Enable NetworkManager, Bluetooth, TLP, and thermald.
5. Install and enable the greetd configuration.
6. Run the final health check.

The native entry point, as well as each native-only stage, refuses to run under
WSL before making system changes.

## Validation

Run the health check at any time:

```bash
./scripts/health-check
```

A successful run has zero failures. GitHub SSH authentication is reported as a
warning when the key is not loaded or GitHub is unavailable; this does not fail
the check.

Before committing shell changes, run:

```bash
bash -n scripts/health-check scripts/setup-native
shellcheck -x scripts/health-check scripts/setup-native
```

## Secrets and ignored state

Never commit private keys, API tokens, `.env` files, Bitwarden exports, or Pi
authentication data. Pi runtime state is ignored:

```text
pi/.pi/agent/auth.json
pi/.pi/agent/sessions/
```

## Branch and commit policy

`develop` is the working branch. Keep commits small and use the repository's
conventional `scope: description` style:

```text
bash: preserve prompt hooks
tmux: configure CSI-U extended keys
health: verify native services are enabled
native: add unified setup entry point
```

## Recovery model

The workstation is rebuildable from:

```text
Debian
+ this repository
+ GitHub
+ Bitwarden
```
