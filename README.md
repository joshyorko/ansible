# Ansible Configuration Project

This project contains Ansible configurations for managing
infrastructure and applications. It includes roles for core
functionalities and Neovim setup, along with inventory files,
playbooks, and scripts for encryption.

## Directory Structure

- **inventory/**: Contains the inventory file for defining hosts.
- **roles/**: Contains reusable roles.
  - **core/**: Core functionalities.
  - **nvim/**: Configuration for Neovim.
- **group_vars/**: Variables that apply to groups of hosts.
- **vault/**: Contains encrypted secrets.
- **ansible.cfg**: Configuration file for Ansible.
- **site.yml**: Main playbook for executing tasks.
- **Dockerfile**: Docker configuration for the project.
- **encrypt.sh**: Script for encrypting sensitive data.

## Usage

This command copies the sample inventory file to a new directory
named `my-machine`. You can then modify this file to suit your
environment.

```bash
cp -R inventory/sample inventory/my-machine
```

To get started, modify the inventory file to include your hosts, and
customize the roles as needed. Use the `site.yml` playbook to run your
configurations.
