scripts
=======

Various small scripts (Shell and python)

battery\_status
---------------

*Language: Python 3*

Get the current status of the battery on GNU/Linux notebooks (Currently
only Linux Kernel version 2 or 3)


deshort-url
-----------

*Language: Bourne-Shell*

Simple reverse URL shortener based on a HEAD request with curl.

dnsresolver
-----------

*Language: Python 3*

A simple DNS resolver for A records (hostname to IP)

dvd2ogv
-------

*Language: Bourne-Shell*

Encode a movie on a DVD to an OGG Vorbis+Theora file. No problems
with copy protection discovered yet.

dvd2vob
-------

*Language: Bourne-Shell*

Read the main track of a DVD movie into a VOB file (Playable with, e.g.
VLC media player), which contains all spoken languages and subtitles
present on the DVD.

generate\_password
-----------------

*Language: Python 3*

Generates a random and secure password. Length is passed
as an argument, default is 8.

getipv4/getipv6
---------------

*Language: Bourne-Shell*

Resolves an IPv4 or IPv6 address. It only prints out the IP, nothing else,
so it can be used to insert the IP of a host in an editor
(`getent ahostsv4`/`getent ahostsv6`, which are internally used, print out some
information you do not need in most cases).

minidnsserver
-------------

*Language: Python 2*

Resolves a custom DNS prefix to a specific IP, and everything else througt
the system's default DNS servers.

Usage:

    minidnsserver [suffix] [ip]

Example:

    minidnsserver dev 127.0.0.1
    # Resolves *.dev to 127.0.0.1

minishell
---------

*Language: Python 2*

A shell that can only be quitted.

You might use it whenever a user should be able to
launch a shell, but not to execute commands.

mips-run
--------

*Language: Bourne-Shell*

Launches a MIPS assembler program using MARS IDE on the command line,
and processes it with pypp.

myip
----

*Language: Bourne-Shell*

Lists all IPv4 and IPv6 addresses of eth0 and wlan0.

pypp
----

*Language Python 3*

A basic perprocessor, e.g. used by mips-run. Supports multi-line
macro definitions.

qrcode
------

*Language: Python 2*

Generates a QR code for a text and writes it to a file.

Usage:

    qrcode filename "Text to encode"


website-screenshot
------------------

*Language: Python 2*

Generates a screenshot of a website using Firefox, without
requiring a running X Server (uses it's own virtual one).

