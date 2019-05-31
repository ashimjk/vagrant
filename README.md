# Vagrant

## Config
```v
config.vm.box - Operating System
config.vm.provider - virtualbox (default)
config.vm.network - How your host sees your box (configure ip-address, port)
config.vm.synced_folder - How you access files from your computer
config.vm.provision - What we want to pre-setup like lamp, apache
```

## Synced Folder
### For Directory and File
```v
config.vm.synced_folder ".", "/var/www/html", :mount_options => ["dmode=777", "fmode=666"]
```

### Network File System
```v
config.vm.synced_folder ".", "/var/www/html", :nfs => { :mount_options => ["dmode=777", "fmode=666"] }
```

dmode - directory mode
fmode - file mode

## Network Config
```v
config.vm.network "private_network", ip:"192.168.33.10"
```

### Update Hosts
code /etc/hosts
192.168.33.10 ajk.localhost.io

## Provision
- Inline Bash Shell Command
```v
config.vm.provision "shell", inline: <<-SHELL
  apt-get update
  apt-get install -y apache2
SHELL
```

- Bash Shell File
```v
config.vm.provision "shell", path: "./bootstrap.sh"
```

## Common commands:
- `box`             : manages boxes: installation, removal, etc.
- `cloud`           : manages everything related to Vagrant Cloud
- `destroy`         : stops and deletes all traces of the vagrant machine
- `global-status`   : outputs status Vagrant environments for this user
- `halt`            : stops the vagrant machine
- `help`            : shows the help for a subcommand
- `init`            : initializes a new Vagrant environment by creating a Vagrantfile login           
- `package`         : packages a running vagrant environment into a box
- `plugin`          : manages plugins: install, uninstall, update, etc.
- `port`            : displays information about guest port mappings
- `powershell`      : connects to machine via powershell remoting
- `provision`       : provisions the vagrant machine
- `push`            : deploys code in this environment to a configured destination
- `rdp`             : connects to machine via RDP
- `reload`          : restarts vagrant machine, loads new Vagrantfile configuration
- `resume`          : resume a suspended vagrant machine
- `snapshot`        : manages snapshots: saving, restoring, etc.
- `ssh`             : connects to machine via SSH
- `ssh-config`      : outputs OpenSSH valid configuration to connect to the machine
- `status`          : outputs status of the vagrant machine
- `suspend`         : suspends the machine
- `up`              : starts and provisions the vagrant environment
- `upload`          : upload to machine via communicator
- `validate`        : validates the Vagrantfile
- `version`         : prints current and latest Vagrant version
- `winrm`           : executes commands on a machine via WinRM
- `winrm-config`    : outputs WinRM configuration to connect to the machine