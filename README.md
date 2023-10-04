# scripts

Various small scripts implemented using bash/zsh or Python. Needed for my [dotfiles](https://github.com/malte70/dotfiles) to work properly.

## battery\_status

*Language: Python 3*

Get the current status of the battery on GNU/Linux notebooks (Currently only Linux Kernel version 2 or 3)

## dvd2vob/vob2ogv/dvd2ogv

*Language: Zsh*

DVD ripping tools. 

### dvd2ogv

Encode a movie on a DVD to an OGG Vorbis+Theora file. No problems with copy protection discovered yet. Wrapper script for `dvd2vob` and `vob2ogv`.

### dvd2vob

Read the main track of a DVD movie into a VOB file (Playable with, e.g. VLC media player), which contains all spoken languages and subtitles present on the DVD.

### vob2ogv

Convert a VOB file (e.g. created by `dvd2vob`) to an OGG Vorbis+Theora file.

## freshrss

*Language: Python 3*

PyQt5 WebEngine wrapper for my FreshRSS instance at [freshrss.rt3x.de](https://freshrss.rt3x.de)

## generate\_password

*Language: Python 3*

Generates a random and secure password. Length is passed as an argument, default is 8.

## gitinfo

*Language: Zsh*

Short Git repository info used by my Zsh prompt. See also: [malte70/dotfiles: .zsh/prompt.zsh](https://github.com/malte70/dotfiles/blob/master/.zsh/prompt.zsh)

## lxc-run-and-wait

*Language: Bourne-Shell*

Launcher script for libvirtd LXC containers.

	lxc-run-and-wait [--app-root=/opt/foo] [--cd-app-root] [--dhcp]

Example domain XML configuration:

```xml
<domain type="lxc">
  <name>bbs-minishell</name>
  <uuid>ea9d54d2-d0e1-4375-b704-6cac72a8796c</uuid>
  <title>T.A.R.D.I.S.</title>
  <memory unit="KiB">65536</memory>
  <currentMemory unit="KiB">16384</currentMemory>
  <vcpu placement="static">1</vcpu>
  <resource>
    <partition>/machine</partition>
  </resource>
  <os>
    <type arch="x86_64">exe</type>
    <init>/bin/bash</init>
    <initarg>/scripts/lxc-run-and-wait</initarg>
    <initarg>--silent</initarg>
    <initarg>--dhcp</initarg>
    <initarg>--domain=bbs-minishell</initarg>
    <initarg>--app-root=/bbs</initarg>
    <initarg>--cd-app-root</initarg>
    <initarg>/bin/python</initarg>
    <initarg>-m</initarg>
    <initarg>bbs.minishell</initarg>
  </os>
  <clock offset="utc"/>
  <on_poweroff>destroy</on_poweroff>
  <on_reboot>restart</on_reboot>
  <on_crash>destroy</on_crash>
  <devices>
    <emulator>/usr/lib/libvirt/libvirt_lxc</emulator>
    <filesystem type="ram" accessmode="mapped">
      <source usage="102400" units="KiB"/>
      <target dir="/etc"/>
    </filesystem>
    <filesystem type="mount" accessmode="mapped">
      <source dir="/home/malte70/bin"/>
      <target dir="/scripts"/>
    </filesystem>
    <filesystem type="mount" accessmode="mapped">
      <source dir="/home/malte70/code/bbs"/>
      <target dir="/bbs"/>
    </filesystem>
    <interface type="network">
      <mac address="00:16:3e:b9:f1:4e"/>
      <source network="default"/>
      <link state="down"/>
    </interface>
    <console type="pty">
      <target type="lxc" port="0"/>
    </console>
  </devices>
</domain>
```

## md2html

*Language: Bourne-Shell*

Converts Markdown documents to HTML using pandoc.

## minidnsserver

*Language: Python 2*

Resolves a custom DNS prefix to a specific IP, and everything else througt the system's default DNS servers.

Usage:

    minidnsserver [suffix] [ip]

Example:

    minidnsserver dev 127.0.0.1
    # Resolves *.dev to 127.0.0.1

## minishell

*Language: Python 3*

A shell that can only be quitted.

You might use it whenever a user should be able to launch a shell, but not to execute commands.

## myip

*Language: Bourne-Shell*

Lists all IPv4 and IPv6 addresses of eth0 and wlan0.

## open

*Language: Zsh*

An implementation of macOS' `open` command for Linux.

```
open 0.2
Provides macOS's open utility on GNU/Linux
Usage:
   open [OPTIONS] [FILENAME]

Options:
  --version -V  Show the version and exit
  --help -h     Show this help and exit
  -a <App>      Open the file using <App>
  -t            Edit the file in $VISUAL
  -e            Edit the file in $EDITOR
  --x11         Start a GUI application without blocking the terminal

For "-a <App>": If the filename is omitted, the application is
started without arguments.
The original open command uses TextEdit.app with "-t", and
your default text editor with "-e"
```

## pushover-notify

*Language: Python 3*

Send a notification to yourself using Pushover, for use in Cronjobs or other automated scripts.

## qrcode

*Language: Python 3*

Generates a QR code for a text and writes it to a file.

Usage:

    qrcode filename.png "Text to encode"

## repo-add-license

*Language: Bourne-Shell*

Add a `LICENSE` file based on a template to the current directory. Currently only supports *MIT* and *BSD-2-Clause* licenses.

```
repo-add-license 0.20230502
Usage:
	repo-add-license [--help|--version]
	repo-add-license [<spdx-license-id>]

Currently supported license IDs:
	MIT
	BSD-2-Clause
	(or none to use the default license)

/home/malte70/bin/repo-add-license places a LICENSE file in the current directory; it's generated from a template,
with usable default values for the placeholders "[year]" and "[fullname]".

The template files are always downloaded from <https://f.malte70.de/>, with this naming convention:
	LICENSE.tpl *
	LICENSE.<spdx-license-id>.tpl

If no license ID was specified at the command line, a default template (*) is used;
which is just a symlink on the webserver.
```

## screensaver-activate

*Language: Zsh*

Activate the screensaver using D-Bus.

## slideshow-generator

*Language: Zsh*

Generate a slideshow from a list of images and save it as an MP4 video.

```
Usage:
	slideshow-generator [OPTIONS] [video.mp4] [images...]

Options:
	--version, -V  Display script name and version
	--help,    -h  Show this usage help
	--debug        Turn on debug mode (more verbose messages)
	--dry-run, -h  Don't actually gegrate anything, just show what *WOULD*
	               be done.

```

## todo

*Language: Bourne-Shell*

Show or edit a todo list. Used by [my .zshrc](https://github.com/malte70/dotfiles/blob/master/.zsh/todo.zsh).

## update

*Language: Zsh*

All-in-one update script:

1. Git repositories in `~/` and `~/bin`
2. pass(1) password store
3. Package manager
   - ArchLinux incl. AUR
   - Debian-based via APT
   - Flatpak (System and user)
   - macOS: Homebrew, Macports and Mac App Store
4. tldr

## website-screenshot

*Language: Python 3*

Generates a screenshot of a website using Selenium and either Geckodriver or Chromedriver, without requiring a running X Server (uses it's own virtual one).

```
Usage:
	website-screenshot <-h|--help|-V|--version>
	website-screenshot <url> <screenshot filename>
```

## website-title

*Language: Python 3*

Extract the title of a website from HTML.

## wine-new-prefix

*Language: Zsh*

Create an new per-application Wine prefix including some often required basic fonts and settings.

```sh
# Create a prefix under ~/.local/opt/wine-firefox
wine-new-prefix firefox
```

I also wrote a blog post based on this script (in German): [Pimp my Wine-Prefix](https://malte70.de/blog/pimp-my-wine-prefix/)
