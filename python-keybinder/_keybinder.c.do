redo-ifchange ../config
. ../config

T=${1%.c}
OVR=$T.override
DEF=$T.defs
redo-ifchange $OVR $DEF
pygobject-codegen-2.0 \
    --override $OVR \
    --register ${PYGTK_DEFSDIR}/gtk-types.defs \
    --register ${PYGTK_DEFSDIR}/gdk-types.defs \
    --prefix py$T $T.defs
