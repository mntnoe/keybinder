redo-ifchange libkeybinder/libkeybinder.so libkeybinder/keybinder.pc

redo-ifchange ./config

. ./config

if [ $HAVE_PYTHON = yes ] ; then
	redo-ifchange \
		python-keybinder/_keybinder.so \
		python-keybinder/__init__.py
fi
if [ $HAVE_LUA = yes ] ; then
	redo-ifchange lua-keybinder/keybinder.so
fi
