# ~/.zshenv

umask 022
if [[ ! $OSTYPE = cygwin ]]; then
    limit coredumpsize 0
    limit maxproc 200   # 40 is default
fi

export BLOCKSIZE=1k # df(1)

export LANG=ja_JP.UTF-8
export LC_ALL=en_US.UTF-8

#export LANG=C
#export LANG=en_US.UTF-8

#export LANG=C
#export LC_ALL=C
#export LANGUAGE=C


# Python UTF-8 default
export PYTHONUTF8=1
export TZ=JST-9
#export TERM=vt100

path=(
    $HOME/bin
    /usr/local/bin
    /usr/bin
    /bin
    /usr/local/sbin
    /usr/sbin
    /sbin
)
