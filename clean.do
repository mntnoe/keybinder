exec >&2
rm -fv ./*.compiler ./*.linker
rm -fv libkeybinder/*.o libkeybinder/*.so libkeybinder/keybinder.pc
rm -fv lua-keybinder/*.o lua-keybinder/*.so
rm -fv python-keybinder/*.o python-keybinder/*.so python-keybinder/_keybinder.c python-keybinder/__init__.py
