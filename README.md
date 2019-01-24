# Silly Shell Portable Profile
Fairly large Linux/UNIX interactive profile including 280+ functions. Build over the course of 15 years, it features many shortcuts to get things done in daily Operations. I don't think anyone else than the maker of one's script should use it at all, but why not sharing anyway?

15 years of use and abuse means some functions are deprecated or not optimized. Use and purge at your convenience!


# Presentation
It used to be a fairly large profile.sh script that grew up to big over time. I then split it into multiple functions through the use of FPATH.

## Features
* Bash ONLY
> Formerly developed around KSH for IBM AIX, it used to be both **KSH** *and* **Bash** compatible, but maintaining this was a headache and abandonned.

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

* Smart bind keyboard shortcuts
> Implements `backward-word`, `forward-word`, `beginning-of-line`,  `end-of-line`, `delete-char-backward` + custom inputrc

## Compatibility
* Bash 2+
* System V
  * IBM AIX 4.3.3 --> 7.1
  * SunOS
* Linux Kernel 2.6 --> latest
  * Embeded Linux: DD-WRT, Thecus OS
  * Darwin (MacOS) and iPhone (jailbroken)
  * Linux Distributions tested: Suse, Mandriva, RedHat, Fedora, Ubuntu

# How To Use
## Load with Putty
In Putty, configure `Remote command` under `Connection > SSH` like so:

`bash --init-file <path>/exploit/profile.sh`

## Load within TTY
**DO NOT** include this profile in your `.bashrc` and **DO NOT** use it as a replacement. As the name suggests, this is for an **interactive profile** at first. It takes some time to load and you DO NOT want this I/O and CPU overhead for every shell  process fork in your system.


# TODO List
* System compatibility:
* [ ] retest against Suse,
* [ ] retest against Mandriva
[ ] retest against RedHat
[ ] retest against Fedora
[ ] retest against SunOS
[ ] retest against IBM AIX
[ ] retest against SunOS

* Shell compatibility:
[ ] retest against Bash version 2
[ ] retest against Bash version 3
[ ] retest against busybox (`ls -q` issue)

* Scripts needed
[ ] implement an emulation of `lsof`


# Thoughts
You would think only bash and shell builtins are important, but don't forget that many systems are not **GNU** from the start, and come with a different set of binaries which behavior is not **POSIX** either. *SunOS* comes to mind. Example: SunOS command `which` RC is always 0...

To give a higher complexity to the problem, embedded systems often come with `busybox`. Its `ls` command doesn't implement the `-q` parameter! And that's just an example...


