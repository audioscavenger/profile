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
git reset --hard head~1

