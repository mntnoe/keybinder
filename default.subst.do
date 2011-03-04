test -e ./config && D=. || D=..

redo-ifchange $D/subst_env.py
redo-ifchange $D/config
$D/subst_env.py $D/config < $1$2.in > $3
