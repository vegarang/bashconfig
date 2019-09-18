# various flags.
export CFLAGS="-I$(brew --prefix openssl)/include"
export LDFLAGS="-L$(brew --prefix openssl)/lib"
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# brew sbin to path
export PATH="/usr/local/sbin:$PATH"
