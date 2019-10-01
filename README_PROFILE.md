# Page_Access_profile
Based on [BadgerTrap](http://research.cs.wisc.edu/multifacet/BadgerTrap/)

## How to install

1. Clone the Linux kernel tree.
```
git clone https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
```
2. Revert to the git tree to kernel version 4.9
```
git checkout -b local v4.9
```
3. Download the patch
4. Apply the patch
```
cd linux-stable
patch -p1 < ../profile.patch
```
5. Call to profile
```
syscall(332,NULL,0,0)
```


## Tips:
/bin/sh: 1: bc: not found
```
sudo apt install bc
```
