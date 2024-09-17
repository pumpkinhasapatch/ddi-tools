# Doko Demo Issyo PSP tools archive
This is an archive of the code repository originally hosted as "Doko Demo Issyo Tools" on the https://neko.rehab or https://swag.toys code server. The original Fossil code server has been changed to cgit, and all of the old repositories including ddi-tools have been gone for months. This is a backup of the code made on May 19, 2024.

These scripts were created by swagtoys for their [Doko Demo Issyo reverse engineering project](https://ddi-en.swag.toys), and some code was later used by pumpkin for his [Doko Demo Issyo PSP Fan Translation](https://github.com/pumpkinhasapatch/dokodemo-psp-english). You can find the original author on their website linked above, or as [@swagtoy](https://github.com/swagtoy) on GitHub.

<img src="https://ddi-en.swag.toys/ddishots/1.jpg" width=49%> <img src="https://ddi-en.swag.toys/ddishots/4.jpg" width=49%>

## File description
### bpar
Read and insert files from DATA.BP and .BPM archives. The code mentions some differences in the BP format that may cause issues with other games like [Doko Demo Issyo: Let's Gakkou](https://dokodemo.fandom.com/wiki/Doko_Demo_Issyo:_Let%27s_Go_to_School!). A Linux build of the program is available on our [Releases page](https://github.com/pumpkinhasapatch/ddi-tools/releases), but I could not get the .c file to compile properly for Windows.

### ksctool
A Perl script that attempts to extract text from a KSC file. It outputs a `*_messages.txt` file containing speech bubbles and a `_dialogue.txt` file containing Pokepi Diary entries, item names and descriptions.

It does not read special characters and control codes properly and may output broken or cut off text. ksctool is not recommended for text re-insertion, and it is possible to use [Atlas](https://www.romhacking.net/utilities/224/) or [abcde](https://www.romhacking.net/forum/index.php?topic=25968.0) instead.

### scripts folder
Various bits of code that use bpar, ksctool and the original game files placed in the main folder of the repository. (You will have to provide these yourself.)

## License
All code is open-source, written by swagtoys and pumpkin does not claim any ownership of the original files. At the bottom of the page on swagtoys' [Doko Demo Issyo English Edition website](https://ddi-en.swag.toys/) shows the following message:
> No copyright steal everything. F*** DA WORLD 2023

This is basically the equivalent of using an [Unlicense](https://choosealicense.com/licenses/unlicense/) or [WTFPL](https://choosealicense.com/licenses/wtfpl/) and will be treated as such until further notice. Copyright is a complicated thing, and I may remove this repository from GitHub if swagtoys really wants it gone or fixes the original code website.

