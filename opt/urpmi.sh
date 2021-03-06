# Mandrake urpmi EXAMPLES:
#-------------------------
urpmi version 4.4
Copyright (C) 1999, 2000, 2001, 2002 MandrakeSoft.
This is free software and may be redistributed under the terms of the GNU GPL.

usage:
  --help         - print this help message.
  --update       - use only update media.
  --media        - use only the given media, separated by comma.
  --excludemedia - do not use the given media, separated by comma.
  --sortmedia    - sort media according to substrings separated by comma.
  --synthesis    - use the given synthesis instead of urpmi db.
  --auto         - automatically select a package in choices.
  --auto-select  - automatically select packages to upgrade the system.
  --no-uninstall - never ask to uninstall a package, abort the installation.
  --keep         - keep existing packages if possible, reject requested
                   packages that leads to remove.
  --split-level  - split in small transaction if more than given packages
                   are going to be installed or upgraded,
                   default is 20.
  --split-length - small transaction length, default is 1.
  --fuzzy        - impose fuzzy search (same as -y).
  --src          - next package is a source package (same as -s).
  --install-src  - install only source package (no binaries).
  --clean        - remove rpm from cache before anything else.
  --noclean      - keep rpm not used in cache.
  --force        - force invocation even if some packages do not exist.
  --allow-nodeps - allow asking user to install packages without
                   dependencies checking.
  --allow-force  - allow asking user to install packages without
                   dependencies checking and integrity.
  --parallel     - distributed urpmi accross machines of alias.
  --wget         - use wget to retrieve distant files.
  --curl         - use curl to retrieve distant files.
  --limit-rate   - limit the download speed.
  --proxy        - use specified HTTP proxy, the port number is assumed
                   to be 1080 by default (format is <proxyhost[:port]>).
  --proxy-user   - specify user and password to use for proxy
                   authentication (format is <user:password>).
  --bug          - output a bug report in directory indicated by
                   next arg.
  --env          - use specific environment (typically a bug
                   report).
  --X            - use X interface.
  --best-output  - choose best interface according to the environment:
                   X or text mode.
  --verify-rpm   - verify rpm signature before installation
                   (--no-verify-rpm disable it, default is enabled).
  --test         - verify if the installation can be achieved correctly.
  --excludepath  - exclude path separated by comma.
  --excludedocs  - exclude docs files.
  -a             - select all matches on command line.
  -p             - allow search in provides to find package.
  -P             - do not search in provides to find package.
  -y             - impose fuzzy search (same as --fuzzy).
  -s             - next package is a source package (same as --src).
  -q             - quiet mode.
  -v             - verbose mode.

  names or rpm files given on command line will be installed.

