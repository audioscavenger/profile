# Silly Shell Portable Profile
Fairly large Linux/UNIX profile including 280+ functions. Build over the course of 15 years, it features many shortcuts to get things done in daily Operations. I don't think anyone else than the maker of one's script should use it at all, but why not sharing anyway?


# Presentation
## Features
* Bash ONLY
> Formerly developed around KSH for IBM AIX, it used to be both **KSH** *and* **Bash** compatible, but maintaining this was a headache and abandonned.

* Portable
> Everything is referenced from the folder it's installed to: functions, vim profiles, variables, etc.

* Compatible with old system V and old Linux not really maintained.
> Because sometimes you are not SysAdmin nor the one abilited to install packages in Production.

* Optimized for xterm-256color
> Wide range of color shades used everywhere, don't forget to setup Putty: `Connection > Data > Terminal-type string=xterm-256color`

* 280+ functions to ease your daily job
> Includes customized functions set per system, powerful and colorized tools to manage network and File systems, etc.
> Includes best practice functions such as **pathmunge** and **libmunge**

* KSH `FPATH` emulation
> KSH FPATH emulation (optimized for lower memory needs). That's something I never understood: why doesn't Bash includes this?

* Emulation of commonly mnissing binaries on some systems:
> **egrep, mktemp, print, printf, readlink, realpath**

* 100+ aliases
> Covers common slips and uber-used commands:
> * **ll = lla** =ls -lAq
> * **dusk** =command du -sk ./*|sort -n
> * **telent** =telnet
> * **alais** = alias
> * And many many more

* Smart binary+library overriding
> * loads custom PATH if present under `bin/${UNAME}`, then `bin/${UNAME}.${KERNELV}`, then `bin/${UNAME}.${KERNELV}.${bit}`, etc
> * simmilar behavior for `$LIBDIR` and `$LD_LIBRARY_PATH`

* Easy deployement for custom script load per sytem/machine:
> create a file called `.entity.<NAME>` at the root and the profile will load `etc/ENTITY/<NAME>/profile.<NAME>.sh`

## Features in detail
