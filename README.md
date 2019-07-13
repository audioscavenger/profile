## :scroll: exploit: Table of Contents
- [diffDir](#diffDir)
  - [Features](#sparkles-Features)
  - [How To Use](#question-How-To-Use)
  - [Compatibility](#memo-Compatibility)
  - [Dependencies](#arrows_clockwise-Dependencies)
- [TODO List](#clipboard-TODO-List)

# diffDir
**diffDir** is a light port of [WinMerge](http://winmerge.org) for folder comparison only.
Outputs colored differences between folders based on _file name_ and _size_.

## :sparkles: Features
* 2 folders comparison
* File list difference extraction
* 256 colors

## :question: How To Use
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


## :memo: Compatibility
* Optimized for xterm-256color, black background
* Bash 2+
* System V
  * IBM AIX 4.3.3+
  * SunOS
* Linux Kernel 2.6+
  * Embeded Linux: DD-WRT, Thecus OS
  * Darwin (MacOS) and iPhone (jailbroken)
  * Linux Distributions tested: Suse, Mandriva, RedHat, Fedora, Ubuntu

# :arrows_clockwise: Dependencies
- [ ] [exploit](#https://github.com/audioscavenger/exploit)
  - [x] profile.sh
    - [x] FPATH/profile/setColors

# :clipboard: TODO List

- [ ] decides to include color dependencies or not
- [ ] update difference symbols
- [ ] update difference colors based on amount of differences?

