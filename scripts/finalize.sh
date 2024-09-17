#!/bin/sh
echo Finalizing
if ! type rsync > /dev/null; then
	cp DATA.BP PSP_GAME/USRDIR/data/DATA.BP
else
	rsync -ah --progress DATA.BP PSP_GAME/USRDIR/data/DATA.BP
fi
