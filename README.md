# My Personal Computer Setup with Nix

[![Check](https://github.com/marcocot/nix-dot-files/actions/workflows/lint.yaml/badge.svg)](https://github.com/marcocot/nix-dot-files/actions/workflows/lint.yaml)

Hey there! 👋 Welcome to my personal computer setup repository! Here you'll find all the configuration magic powered by [Nix](https://nixos.org/) to manage my various computing devices - my work desktop, my trusty MacBook (with [nix-darwin](https://github.com/LnL7/nix-darwin)), and my HTPC that doubles as a media center.

## What's Inside?

`host/macbook`

For my MacBook, I use [nix-darwin](https://github.com/LnL7/nix-darwin) to manage system configurations. This file contains all the customizations I've made to ensure my MacBook behaves just the way I like it.

`host/heimdall`

My Home Theater PC is not just for movies and TV shows, it's also a playground for Nix configurations. This file contains settings optimized for media playback and any additional utilities I need on my HTPC.

## Additional Services Implemented

### Media Management with arr Suite

I've set up a suite of programs (\*arr) to manage my media collection. This includes Sonarr for TV shows, Radarr for movies, and Lidarr for music. With these tools, I can easily search for, download, and organize my media library.

### Plex Installation

Plex is my go-to media server software, and I've made sure it's installed and configured across all my devices. Plex allows me to stream my media collection to any device, anywhere, making it easy to enjoy my favorite content on the go.

### Periodic Backups using Restic

Backup is crucial, so I've integrated Restic into my setup for periodic backups. Restic provides secure, efficient backups with deduplication, compression, and encryption. With Restic, I can rest assured knowing my important data is safely backed up and ready for recovery if needed.

### Consistent Shell Environment with Home Manager

To ensure a consistent shell environment across all my devices, I use [home-manager](https://github.com/LnL7/nix-darwin). [home-manager](https://github.com/LnL7/nix-darwin) allows me to manage my user environment declaratively, ensuring that my shell configuration, aliases, and preferences are automatically synchronized across all my machines. This means I have the same familiar environment whether I'm working on my desktop, MacBook, or HTPC.

## Flake-Based Management

This entire repository is managed as a [Nix flake](https://nixos.wiki/wiki/Flakes). Flakes provide a convenient and reproducible way to define, build, and compose Nix packages and configurations. With flakes, I can easily share my setup with others and ensure consistent development environments across different machines.

## Disclaimer

While these configurations work well for me, they might not suit everyone's needs. Use them at your own risk and always backup your data before making system-wide changes.

That's it! If you have any questions or just want to say hi, feel free to reach out. Happy hacking! 🎉
