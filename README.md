scripts
=======

Various small scripts (Shell and python)

generate\_password
-----------------

*Language: Python 3*

Generates a random and secure password. Length is passed
as an argument, default is 8.

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

