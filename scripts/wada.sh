#!/bin/sh
cp output/NEKO.KSC.BAK output/NEKO.KSC
./ksctool.pl debug output/NEKO.KSC
./bpar id DATA.BP output/NEKO.KSC
./scripts/finalize.sh
python3.9 scripts/ppsspp_ddi_setup.py reset
