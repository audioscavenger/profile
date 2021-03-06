## :scroll: exploit: Table of Contents
- [Silly Shell Portable-Profile](#exploit-Silly-Shell-Portable-Profile)
- [Presentation](#Presentation)
  - [Features](#sparkles-Features)
  - [Compatibility](#memo-Compatibility)
- [How To Use](#question-How-To-Use)
  - [Load-with-Putty](#Load-with-Putty)
  - [Load-within-TTY](#Load-within-TTY)
- [TODO List](#clipboard-TODO-List)
- [Thoughts](#unamuzed-Thoughts)
- [Highlights](#mag-Highlights)
  - [listFunctions](#listFunctions)
  - [dfm](#dfm)
  - [diffDir](#diffDir)

# exploit: Silly Shell Portable Profile
Fairly large Linux/UNIX interactive profile including 280+ functions. Build over the course of 15 years, it features many shortcuts to get things done in daily Operations. I don't think anyone else than the maker of one's script should use it at all, but why not sharing anyway?

15 years of use and abuse means some functions are deprecated or not optimized. Use and purge at your convenience!


# Presentation
It used to be a fairly large profile.sh script that grew up too big over time. I then split it into multiple functions through the use of FPATH.

*Silly Shell* is a movement that aims at improving both the graphical and artistic output of shell scripts. As the name suggests, it's certainly useless from an efficacy stand point. 

## :sparkles: Features
* Bash ONLY
> Formerly developed around KSH for IBM AIX, it used to be both **KSH** *and* **Bash** compatible, but maintaining this was a headache and abandoned.

* Portable
> Everything is referenced from the folder it's installed to: functions, vim profiles, variables, etc.

* Compatible with old system V and old Linux not really maintained.
> Because sometimes you are not SysAdmin nor the one abilited to install packages in Production.

* Optimized for xterm-256color, black background
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

* Smart bashrc behavior
> Loads aliases and TTY variables only in interactive shell

* Smart bind keyboard shortcuts for TTY and inside screen terminal
> Implements `backward-word`, `forward-word`, `beginning-of-line`,  `end-of-line`, `delete-char-backward` + custom inputrc

* Awesome PS1
> Different colors per system, with indicator for in-screen TTYs

## :memo: Compatibility
* Bash 2+
* System V
  * IBM AIX 4.3.3 --> 7.1
  * SunOS
* Linux Kernel 2.6 --> latest
  * Embeded Linux: DD-WRT, Thecus OS
  * Darwin (MacOS) and iPhone (jailbroken)
  * Linux Distributions tested: Suse, Mandriva, RedHat, Fedora, Ubuntu

# :question: How To Use

## Load with Putty
In Putty, configure `Remote command` under `Connection > SSH` like so:

`bash --init-file <path>/exploit/profile.sh`

## Load within TTY
`. [path/]profile.sh`

**DO NOT** include this profile in your `.bashrc` and **DO NOT** use it as a replacement.
As the name suggests, this is an **interactive profile** at first.
It takes seconds to load and you DO NOT want this I/O and CPU overhead for every shell process fork on your system.


# :clipboard: TODO List

* Todo
- [ ] Stop appending todo list

* Releases
- [ ] create releases excluding opt/docs
- [ ] create installer because of non-empty profile folder

* System compatibility:
- [ ] retest against Suse,
- [ ] retest against Mandriva
- [ ] retest against RedHat
- [ ] retest against Fedora
- [ ] retest against SunOS
- [ ] retest against IBM AIX
- [ ] retest against SunOS

* Shell compatibility:
- [ ] retest minimal version + profile against Bourne shell + dash
- [ ] retest against Bash version 2
- [ ] retest against Bash version 3
- [ ] retest against KSH93
- [ ] retest against KSH88
- [ ] retest against busybox (`ls -q` issue)
- [ ] retest against zsh
- [ ] check why ${command) broke zsh
- [ ] convert every "local" to "typeset" under PATH
- [ ] validate every PATH sh tests
- [x] validate every FPATH sh tests
- [ ] remove every last "while [[ "x$1" == x-? ]]" tests
- [ ] make sure no PATH script uses ${FUNCNAME} anymore

* Dev needs
- [ ] currently broken: pseft, findi, vim
- [ ] implement an emulation of `lsof`
- [ ] make sure busybox issues are addressed within profile.sh
- [ ] update every "while [[ "x$1" == x-? ]]" with getopt
- [ ] retest xml_read in PATH
- [ ] decide how to hide and save /PATH/personal etc folders
- [ ] decide how to hide and save custom etc/ENTITY/* folders
- [ ] decide how to provide portable bim binaries
- [ ] decide to integrate colout or not
- [ ] decide how to provide specific bin folder per OS
- [ ] decide what to do with all the other stuff under bin/
- [ ] decide what to do with pl/py binaries
- [ ] decide how to provide specific lib folder per OS
- [ ] decide where to place /opt/mysql/mysqltuner and other similar tools
- [ ] implement autoupdate /opt/tools/
- [ ] decide what to do with /opt/tomcat and jdbc testing rigs
- [ ] decide what to do /share/perl modules
- [ ] make was a project of its own


# :unamused: Thoughts
You would think only bash and shell builtins are important, but don't forget that many systems are not **GNU** from the start, and come with a different set of binaries which behavior is not **POSIX** either. 
*SunOS* comes to mind. Example: SunOS command `which`' return code is always 0...

To give a higher level of complexity to the problem, embedded systems often come with `busybox`.
Its `ls` command doesn't implement the `-q` parameter! And that's just an example...


# :mag: Highlights

## listFunctions

**listFunctions** is the usage/functions listing script you want to try first.

* `listFunctions -h`
Usage: 

![listFunctions -h](https://www.it-cooking.com/listFunctions-help-oq10/ "listFunctions -h")

* `listFunctions -u`
Print usage of every functions under `FPATH/*/`:

![listFunctions -u](https://www.it-cooking.com/listFunctions-usage-oq10/ "listFunctions -u")

* `listFunctions -u was`
Print usage of every WebSphere functions under `FPATH/was/`:

![listFunctions -u was](https://www.it-cooking.com/listFunctions-usage-was-oq10/ "listFunctions -u was")

* `listFunctions -r listFunctions`
Print recursively every functions and sub-functions called inside a particular script/function:

![listFunctions -r listFunctions](https://www.it-cooking.com/listFunctions-function-recursive-oq10/ "listFunctions -r listFunctions")


## dfm
**dfm** features df -m + awk + colors based on use rate + FS selection based on size/pattern. With thousands comma separator... silly shell at its best:

* `dfm`

```
Logical_Volume           mB_Total     mB_Used     mB_Free Use% Mounted_on
xvda1                       7,877       4,227       3,635  54% /
xvdg                        1,952       1,646         188  90% /data
xvdh                       15,999       9,169       5,996  61% /data2
udev                          488           0         488   0% /dev
tmpfs                         496           6         490   2% /dev/shm
tmpfs                         100          11          89  11% /run
tmpfs                           5           0           5   0% /run/lock
tmpfs                         100           0         100   0% /run/user/1000
tmpfs                         496           0         496   0% /sys/fs/cgroup
9 FS - Total :             27,513      15,059      11,487  24%
```

* `dfm gt 55`

```
Logical_Volume           mB_Total     mB_Used    mB_Free Use% Mounted_on
xvdg                        1,952       1,646        188  90% /data
xvdh                       15,999       9,169      5,996  61% /data2
2 FS - Total :             17,951      10,815      6,184  75%
```

## diffDir
**diffDir** is a light port of [WinMerge](http://winmerge.org) for folder comparison. Outputs colored differences between folders based on file name and size.

* `diffDir -h`
Usage:

![diffDir usage](https://www.it-cooking.com/diffdir-help-oq10/ "diffDir usage")

* `diffDir leftDir rightDir`
Default folder comparison:

![diffDir leftDir rightDir](https://www.it-cooking.com/diffdir-default-oq10/ "diffDir leftDir rightDir")

* `diffDir -qdm leftDir rightDir`
Prints only differences and missing files, quiet mode:

![diffDir -qdm leftDir rightDir](https://www.it-cooking.com/diffdir-qdm-oq10/ "diffDir -qdm leftDir rightDir")

* `diffDir -qmr leftDir rightDir`
Prints only missing files, quiet mode + full path: easy way to obtain a list of files missing between directories:

![diffDir -qmr leftDir rightDir](https://www.it-cooking.com/diffdir-qmr-oq10/ "diffDir -qmr leftDir rightDir")

# :ribbon: License (is GNU GPL3)
This project is distributed under [GNU Affero General Public License, Version 3][AGPLv3].

                    GNU GENERAL PUBLIC LICENSE
                       Version 3, 29 June 2007

 Copyright (C) 2007 Free Software Foundation, Inc. <https://fsf.org/>
 Everyone is permitted to copy and distribute verbatim copies
 of this license document, but changing it is not allowed.

install-rkit-portable  Copyright (C) <2019>  <audioscavenger@it-cooking.com>
This program comes with ABSOLUTELY NO WARRANTY;
This is free software, and you are welcome to redistribute it
under certain conditions; https://www.gnu.org/licenses/gpl-3.0.html

