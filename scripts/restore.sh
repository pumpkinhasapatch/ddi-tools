#!/bin/sh
echo Finalizing
if ! type rsync > /dev/null; then
	cp PSP_GAME/USRDIR/data/DATA.BP.BAK DATA.BP
else
	rsync -ah --progress PSP_GAME/USRDIR/data/DATA.BP.BAK DATA.BP
fi
