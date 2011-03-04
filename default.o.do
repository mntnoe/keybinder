exec >&2

redo-ifchange ./config
. ./config

SUB=${1%%/*}
PFX=${SUB%%-*}
eval CFLAGS=\$${PFX}_CFLAGS

SRC=${1%.o}.c

onlylocal() {
	# remove all that start with '/'
	while [ $# != 0 ] ; do
		test -n "${1##/*}" && echo $1
		shift
	done
}

redo-ifchange $SRC
${CC} -MD -MF $3.deps ${CFLAGS} -shared -o $3 -c $SRC
read DEPS <$3.deps
rm -f $3.deps
redo-ifchange $(onlylocal ${DEPS#*:})
