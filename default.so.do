redo-ifchange ./config
. ./config

SUB=${1%%/*}
PFX=${SUB%%-*}
eval SRCS=\$${PFX}_SRCS
eval LDFLAGS=\$${PFX}_LDFLAGS
eval LIBS=\$${PFX}_LIBS

redo-ifchange $SRCS
${CC} ${LDFLAGS} -shared -o $3 $SRCS ${LIBS}
