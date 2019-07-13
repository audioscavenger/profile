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

# ---------------------------------------------------------- submodules
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

# ---------------------------------------------------------- subtree
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

# for https://github.com/audioscavenger/exploit, on Windows bash:
cd PATH/common
git remote add -f exploit-diffDir https://github.com/audioscavenger/exploit-diffDir.git
# fatal: remote exploit-diffDir already exists.
git merge -s ours --no-commit --allow-unrelated-histories exploit-diffDir/master
# merge: exploit-diffDir/master - not something we can merge
git read-tree --prefix=exploit-diffDir/ -u exploit-diffDir/master
ln -s exploit-diffDir/diffDir diffDir
# git add diffDir
# git add .gitmodules diffDir
git commit -am "Merge exploit-diffDir as our subdirectory + link"

# ---------------------------------------------------------- submodule and symlink
cd PATH/common
git submodule add https://github.com/audioscavenger/exploit-diffDir.git
ln -s exploit-diffDir/diffDir diffDir
git add .gitmodules diffDir
git commit -am "add a symbolic link to diffDir with the respective submodule exploit-diffDir"