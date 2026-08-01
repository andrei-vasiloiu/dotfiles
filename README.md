# Dotfiles

Portable development-environment configuration for Debian WSL2 and a future native Debian workstation.

## Current scope

Implemented and validated:

- Debian 13 under WSL2
- systemd and user services
- Bash
- tmux
- Neovim 0.12.4
- Python through uv
- Node.js through mise
- pnpm
- TypeScript 7 native LSP
- .NET 10 and Roslyn
- rootless Podman
- Pi coding agent
- GNU Stow
- health checks and rebuild automation

Native Debian desktop components such as Sway, foot, Waybar, Fuzzel, Mako, TLP, and hardware integration are deferred to the laptop build.

## Repository layout

```text
bash/       Bash configuration
git/        Git configuration
mise/       Runtime configuration
nvim/       Neovim configuration
pi/         Pi settings, prompts, skills, themes, and extensions
tmux/       tmux configuration
packages/   APT package manifests
scripts/    Installers, WSL setup, and health checks
bootstrap   Main installation entry point
```

## Fresh WSL setup

Install Debian WSL2 and create your normal Linux user.

Install the minimum bootstrap dependencies:

```bash
sudo apt update
sudo apt install -y git curl ca-certificates stow openssh-client
```

Configure GitHub SSH authentication, then clone:

```bash
mkdir -p ~/src/github.com/andrei-vasiloiu
cd ~/src/github.com/andrei-vasiloiu
git clone git@github.com:andrei-vasiloiu/dotfiles.git
cd dotfiles
git switch develop
```

Prepare WSL:

```bash
./scripts/configure-wsl
```

From PowerShell:

```powershell
wsl --terminate Debian
wsl -d Debian
```

Then run:

```bash
cd ~/src/github.com/andrei-vasiloiu/dotfiles
./bootstrap
```

## Validation

```bash
./scripts/health-check
```

Expected result:

```text
0 failure(s), 0 warning(s)
```

GitHub SSH may warn until the key is loaded into the SSH agent.

## Secrets

The repository must not contain:

- SSH private keys
- API tokens
- `.env` files
- Bitwarden exports
- Pi authentication data
- Pi sessions

Pi configuration is tracked, but these paths are ignored:

```text
pi/.pi/agent/auth.json
pi/.pi/agent/sessions/
```

## Branch policy

`develop` is the default working branch.

Use small, descriptive commits:

```text
bash: preserve prompt hooks
tmux: make clipboard platform-aware
nvim: add WSL clipboard provider
tooling: add Pi coding agent
```

## Recovery model

The workstation is treated as rebuildable:

```text
Debian
+ this repository
+ GitHub
+ Bitwarden


## Native Debian laptop

The native Debian workstation uses the same portable toolchain plus the Sway desktop and laptop integration layer.

After installing minimal Debian and cloning this repository:

```bash
./scripts/install-native
./bootstrap
```

`install-native` is guarded and will refuse to run under WSL.

Native-only configuration for foot, Sway, Waybar, Fuzzel, Mako, power management, portals, and related desktop services will be added before the laptop build.
