# Some documentation regarding KSC files

Before the "H" byte, there is a byte that specifies the characters reaction
to a message. Certain values cause the character to run, become sad, become
annoyed, happy, etc. Some values seem invalid and cause nothing to change
with his reaction.

A good origin text to mess with for Toro Inoue is "はじめましてニャ". You
can open in Shift-JIS mode using GNU Emacs, by typing `C-x [enter] c
shift_jis [enter] C-f ~/NEKO.KSC`, do a search, edit and save (save as
shift_jis), then open your hex/text editor of choice and do a search for
your new english text. Make sure you overwrite the Japanese text in Emacs
with overwrite-mode.
