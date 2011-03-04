# vim: sts=4 sw=4 et ft=sh
exec >&2

: ${CC:=cc}
: ${VALAC:=valac}

GTK_FLAGS=$(pkg-config --cflags --libs gtk+-2.0 2>/dev/null) || true
LUA_FLAGS=$(pkg-config --cflags --libs lua5.1 2>/dev/null)   || true

FLAGS=$(pkg-config --cflags --libs keybinder 2>/dev/null)

cmp() { # usage compile dst srcs
    $CC -fPIC $FLAGS $GTK_FLAGS $LUA_FLAGS -o $1 -c $2
}

link() { # usage dst srcs
    $CC -Wl,--as-needed -o $@ $FLAGS $GTK_FLAGS $LDFLAGS
}


case $1 in
    cex)
        redo-ifchange cex.o
        link $3 cex.o
        ;;
    luaex)
        redo-ifchange minigtk.so
        ;;
    valaex)
        redo-ifchange $1.vala keybinder.vapi
        ${VALAC} --pkg gtk+-2.0 --pkg keybinder --vapidir=. -o $3 $1.vala
        ;;
    *.o)
        redo-ifchange ${1%.o}.c
        cmp $3 ${1%.o}.c
        ;;
    *.so)
        redo-ifchange  l${1%.so}.o
        link $3 l${1%.so}.o -shared
        ;;
    *)
        exit 1
        ;;
esac

