# Herdr pixel theme

A retro DOS/EGA-style theme for the [Herdr](https://herdr.dev) desktop app.

![Herdr with the pixel theme](screenshot.png)

- **Colours:** dark navy panels, teal borders, gold highlights, black terminals with the 16 classic EGA colours.
- **Font:** PxPlus IBM VGA 8x16 for terminals and the interface.
- **No modern look:** square corners everywhere, 2px borders, no shadows on pop-ups opened from the window.
- **Pixel icons:** 12×12 glyphs for every sidebar, tab, pane and menu icon, plus 16×16 program icons (shell, Claude, git, node, python, vim, docker, ssh, npm, htop and more).
- **Pixel logo:** a 24×24 sprite of the Herdr ram in the theme's colours.
- **8-bit sounds:** a chiptune jingle when an agent finishes and a two-tone alarm when one is blocked.

- **Usage and System panels:** the sidebar shows your AI subscriptions' limits (Claude Code, Codex, API keys) and CPU, GPU, RAM and disk use (see below).

## Install

```sh
git clone https://github.com/makefunstuff/herdr-pixel-theme
cd herdr-pixel-theme
./install.sh
```

It copies everything into `~/.config/herdr-app` (or `$HERDR_APP_HOME`) and switches Herdr to the `pixel` layout. Press `ctrl-shift-l` to cycle layouts. Run it again after pulling to update.

Notes:

- `programs.json` (the program icons) applies to every layout. The installer backs up an existing one first. Delete it to get the stock icons back.
- The sounds are set in `settings.json` and also apply to every layout.
- The `px-*` mods are copies of Herdr's own mods, so they won't pick up Herdr's later changes to those panels.
- Herdr opens a few dialogs itself (confirm, prompt, help, toasts); those keep the stock look.

## Usage and System panels

Two sections sit under Agents in the sidebar:

- **Usage** (`px-usage`): each provider's limits with a bar and the time until it resets: Claude Code's 5-hour and weekly limits, Codex's, and API accounts whose keys are on the machine (OpenRouter, DeepSeek, …). It reads them with [herdr-usage](https://github.com/makefunstuff/herdr-android/tree/main/host/herdr-usage) every 5 minutes, using the logins already on the machine; click the header to read them again now. It needs herdr-usage (one Python 3 file) at `~/.local/share/herdr-usage/herdr-usage`:

  ```sh
  mkdir -p ~/.local/share/herdr-usage
  curl -fsSL https://raw.githubusercontent.com/makefunstuff/herdr-android/main/host/herdr-usage/herdr-usage -o ~/.local/share/herdr-usage/herdr-usage
  chmod +x ~/.local/share/herdr-usage/herdr-usage
  ```

- **System** (`px-sysmon`): CPU, each GPU (NVIDIA through `nvidia-smi`, AMD through sysfs), RAM and up to four local disks, every 3 seconds. Hover a row for VRAM, temperature and free space. CPU, GPU and RAM are Linux only; elsewhere it shows the disks.

Bars turn yellow at 70% and red at 90%. Don't want them? Delete the `usage` and `sysmon` blocks from `layouts/pixel.json`.

## What's in it

| Path | What |
|---|---|
| `herdr-app/themes/pixel.json` | colours |
| `herdr-app/layouts/pixel.json` | the layout: fonts, square frames, which mods to use |
| `herdr-app/mods/px-*` | the window's panels and pop-ups, squared off with pixel glyphs |
| `herdr-app/pixel-icons/`, `programs.json` | program icons |
| `herdr-app/sounds/` | 8-bit alert sounds |
| `herdr-app/fonts/` | PxPlus IBM VGA 8x16 |

## Licence

Apache-2.0, as the mods are derived from Herdr's. The font is CC BY-SA 4.0. See `NOTICE`.
