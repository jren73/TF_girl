# TF_girl

diff command for patch
```
diff -Naur target.rb.original target.rb > my_awesome_change.patch
```

git command for patch

```
# to generate a patch between two commits
git diff commitid1 commitid2 > my_awesome_change.patch

# to generate a patch between the HEAD and a specific commits
git diff commitid1 > my_awesome_change.patch
```
