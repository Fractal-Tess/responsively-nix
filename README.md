# Responsively App Nix Flake

This repository contains a Nix flake for installing and running [Responsively App](https://responsively.app/), a powerful browser for responsive web development.

## Features

- Easy installation through Nix flakes
- Includes desktop integration
- Automatic dependency management
- Version 1.15.0 of Responsively App

## Prerequisites

- Nix package manager with flakes enabled
- Linux system (x86_64)

## Installation

To install Responsively App using this flake, run:

```bash
nix profile install github:YOUR_USERNAME/responsively-nix
```

Or, you can try it without installing:

```bash
nix run github:YOUR_USERNAME/responsively-nix
```

## Usage

After installation, you can:
1. Launch from your desktop environment's application menu
2. Run `responsively` from the command line

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This flake configuration is provided under the MIT License. Responsively App itself has its own license terms.

## Acknowledgments

- [Responsively App](https://responsively.app/) - The original application
- [Nix](https://nixos.org/) - The package manager that makes this possible
