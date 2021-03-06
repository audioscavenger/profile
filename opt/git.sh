alias gitp='git add . && git commit && git push'
alias gitg='git fetch && git pull origin master'


# git windows: cannot remove this pesky "\\" file? comes from seafile desktop apparently

eric@LLED MINGW64 /s/Dropbox/lolo/Dropbox/sources/exploit (master)
$ git status
# On branch master
# Changes to be committed:
  # (use "git reset HEAD <file>..." to unstage)

        # deleted:    "\\"

# Untracked files:
  # (use "git add <file>..." to include in what will be committed)

        # opt/git.sh


eric@LLED MINGW64 /s/Dropbox/lolo/Dropbox/sources/exploit (master)
$ git reset HEAD \\
# fatal: \: '\' is outside repository

# eric@LLED MINGW64 /s/Dropbox/lolo/Dropbox/sources/exploit (master)


# solution: https://stackoverflow.com/questions/31420690/why-am-i-getting-error-fatal-c-program-files-x86-git-is-outside-the-repos
# git reset --hard head~1


# ---------------------------------------------------------- submodules
# https://stackoverflow.com/questions/1811730/how-do-i-work-with-a-git-repository-within-another-repository

# Say you have repository PROJECT1, PROJECT2, and MEDIA...

# cd /path/to/PROJECT1
# git submodule add ssh://path.to.repo/MEDIA
# git commit -m "Added Media submodule"

# Repeat on the other repo...

# Now, the cool thing is, that any time you commit changes to MEDIA, you can do this:

# cd /path/to/PROJECT2/MEDIA
# git pull
# cd ..
# git add MEDIA
# git commit -m "Upgraded media to version XYZ"

# This just recorded the fact that the MEDIA submodule WITHIN PROJECT2 is now at version XYZ.

# It gives you 100% control over what version of MEDIA each project uses. git submodules are great, but you need to experiment and learn about them. 

# ---------------------------------------------------------- subproject
# https://stackoverflow.com/questions/8334974/git-repo-inside-repo

# ==> find out if symlinks are authorized locally:
fsutil behavior query SymlinkEvaluation

# git clone with symlinks:
# git clone -c core.symlinks=true <URL>

cdexp
git remote add exploit-diffDir https://github.com/audioscavenger/exploit-diffDir.git
# subproject_remote is the new branch name and (url) where to get it from, it could be a path to a local git repo

git subtree add --prefix=PATH/common/exploit-diffDir/ exploit-diffDir master
# the prefix is the name of the directory to place the submodule
# You need to run this command from the toplevel of the working tree.
# Working tree has modifications.  Cannot add.

cd PATH/common
# linux:
ln -s exploit-diffDir/diffDir diffDir
# Windows:
mklink diffDir exploit-diffDir\diffDir
git commit -am "Added submodule exploit-diffDir link to diffDir"
# possibly commit this along with any changes

#-------  update subproject
# If the subproject changes, to pull them locally:
git subtree pull  --prefix=PATH/common/exploit-diffDir/ https://github.com/audioscavenger/exploit-diffDir.git master

# if changes are made in the subproject inside the project
git subtree push --prefix=PATH/common/exploit-diffDir/ https://github.com/audioscavenger/exploit-diffDir.git master




# ---------------------------------------------------------- subtree - from Linux - attempt 1
# https://riptutorial.com/git/example/5278/create--pull--and-backport-subtree
# https://mirrors.edge.kernel.org/pub/software/scm/git/docs/howto/using-merge-subtree.html

# Here is the command sequence you need:

# $ git remote add -f Bproject https://path.to/remotes/Bproject.git <1>
# $ git merge -s ours --no-commit --allow-unrelated-histories Bproject/master <2>
# $ git read-tree --prefix=Bproject/ -u Bproject/master <3>
# $ git commit -m "Merge Bproject project as our subdirectory" <4>

# $ git pull -s subtree Bproject master <5>

   # 1 name the other project "Bproject", and fetch.
   # 2 prepare for the later step to record the result as a merge.
   # 3 read "master" branch of Bproject to the subdirectory "dir-B".
   # 4 record the merge result.
   # 5 maintain the result with subsequent merges using "subtree"

# The first four commands are used for the initial merge, while the last one is to merge updates from B project.

# 1) ==> update to Git 2.22
# 2) use full relative path for submodule
# for https://github.com/audioscavenger/exploit, on Windows bash:
cdexp

## must use full path:
# git remote add -f exploit-diffDir https://github.com/audioscavenger/exploit-diffDir.git
# fatal: remote exploit-diffDir already exists.
git remote add -f PATH/common/exploit-diffDir https://github.com/audioscavenger/exploit-diffDir.git

# git merge -s ours --no-commit --allow-unrelated-histories PATH/common/exploit-diffDir/master
## this error because previous command didn't work:
# merge: exploit-diffDir/master - not something we can merge
## this error because Git 2.7.4:
# git error: unknown option `allow-unrelated-histories'

git merge -s ours --no-commit --allow-unrelated-histories PATH/common/exploit-diffDir/master
## correct message:
# Automatic merge went well; stopped before committing as requested

git read-tree --prefix=PATH/common/exploit-diffDir/ -u PATH/common/exploit-diffDir/master
cd PATH/common
ln -s exploit-diffDir/diffDir diffDir
# git add diffDir

cdexp
# git add .gitmodules diffDir
git commit -am "Merge exploit-diffDir as our subdirectory + link"

==> HOW DO I UPDATE subtree???


# ----------------------------------------------------------submodule and symlink by Atlassian - to try
# https://www.atlassian.com/blog/git/alternatives-to-git-submodule-git-subtree




# ---------------------------------------------------------- subtree - from Linux - to try
# https://stackoverflow.com/questions/24709704/apply-gradle-file-from-different-repository/24709789#24709789
cdexp
git remote add -f PATH/common/exploit-diffDir https://github.com/audioscavenger/exploit-diffDir.git
git fetch PATH/common/exploit-diffDir
git checkout -b infra infrarepo/master

git checkout master
git read-tree --prefix=infra/ –u infra
git commit -m "Add Infra subtree"


#-------  update main
To update the project repo with subtree changes:

git checkout infra
git pull
git checkout master
git merge --squash –s subtree –-no-commit infra
git commit -m "update infra"

#-------  update subtree
To update the subtree repo with change from the subtree folder of the project repo:

git checkout infra
git merge --squash –s subtree --no-commit master
git commit -m "(infra subtree) nature of changes"

git push infrarepo infra




# ---------------------------------------------------------- submodule and symlink auto update to HEAD
# https://stackoverflow.com/questions/31769820/differences-between-git-submodule-and-subtree
## submodule is a better fit for component-based development, where your main project depends on a fixed version of another component (repo).

## What if I want the links to always point to the HEAD of the external repo?
## You can make a submodule to follow the HEAD of a branch of a submodule remote repo, with:
git submodule add -b <branch> <repository> [<path>]. (to specify a branch to follow)

## this will update the content of the submodule to the latest HEAD from <repository>/<branch>, by default origin/master. 
## Your main project will still track the hashes of the HEAD of the submodule even if --remote is used though.


# ---------------------------------------------------------- attempt 3 - submodule and symlink - seems to work
# https://www.git-scm.com/docs/gitmodules
cdexp
git submodule add https://github.com/audioscavenger/exploit-diffDir.git PATH/common/exploit-diffDir
git submodule update --init --recursive
cd PATH/common
ln -s exploit-diffDir/diffDir diffDir

cdexp
cat .gitmodules
# [submodule "PATH/common/exploit-diffDir"]
  # path = PATH/common/exploit-diffDir
  # url = https://github.com/audioscavenger/exploit-diffDir.git
ll PATH/common/exploit-diffDir/
# -rw-rw-r-- 1 ubuntu ubuntu    84 Jul 14 16:05 CHANGELOG.md
# -rwxrwxr-x 1 ubuntu ubuntu  4557 Jul 14 16:05 diffDir*
# -rw-rw-r-- 1 ubuntu ubuntu    58 Jul 14 16:05 .git
# -rw-rw-r-- 1 ubuntu ubuntu   181 Jul 14 16:05 .gitattributes
# -rw-rw-r-- 1 ubuntu ubuntu  3835 Jul 14 16:05 .gitignore
# -rw-rw-r-- 1 ubuntu ubuntu 35126 Jul 14 16:05 LICENSE
# -rw-rw-r-- 1 ubuntu ubuntu  1909 Jul 14 16:05 README.md

git add . && git commit -am "submodule exploit-diffDir attempt 3" && git push

#-------  update ALL submodules from remote
# https://stackoverflow.com/questions/1030169/easy-way-to-pull-latest-of-all-git-submodules
git submodule status
#  0ce4318f1c8852688db89f69afe09c6746f7e1f0 PATH/common/exploit-diffDir (remotes/origin/HEAD)
git pull --recurse-submodules
git submodule update --recursive --remote
git push || (git add . && git commit -am "submodules update" && git push)

#-------  push local submodules updates to remote
git submodule foreach 'echo $path `git rev-parse HEAD`'
# Entering 'PATH/common/exploit-diffDir'
# PATH/common/exploit-diffDir 5e8a38c10ffae3f1a5b04bc0aa23591686f0bf3e

# first time:
git submodule update --recursive --remote
git push --recurse-submodules=on-demand

# subsequentely:
git submodule foreach 'git add . && git commit -am "commit by main repo" && git push origin HEAD:master'
git add . && git commit -am "commit after push submodules" && git push

zsh
#  ubuntu@web-scav-01  ~/exploit   master  cd PATH/common/exploit-diffDir
#  ubuntu@web-scav-01  ~/exploit/PATH/common/exploit-diffDir  ➦ 5e8a38c 


