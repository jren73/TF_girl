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


Tips:
* Error in `python': double free or corruption 

We've observed similar crashes. I suspect incompatibility of TensorFlow official release with Ubuntu 14.04, something possibly related to jemalloc. The work-around is to do following:
```
sudo apt-get install google-perftools
export LD_PRELOAD="/usr/lib/libtcmalloc.so.4" 
```
