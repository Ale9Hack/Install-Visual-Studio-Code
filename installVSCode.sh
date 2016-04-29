#!/bin/bash
dest="/opt/test"
tmpDest="/tmp/vscode"
folderInstaller='VSCode'
shortcut='/usr/share/applications/vscode.desktop'
link="/usr/bin/code"
if (( $EUID != 0 )); then
    echo "Please run as root"
    exit
elif [  -d $dest/$folderInstaller ]; then
    echo "Visual Studio Code is Installed. ¿Remove it? y/c"
    read r
    if [ "$r"  == "y" ]; then 
	rm -R -f $dest/$folderInstaller
	rm -f $shortcut
	rm -f $link
    else
    echo "Not removed"
    fi    
echo "script is finished"
exit
fi

mkdir $tmpDest
mkdir $dest

echo "Ingrese el zip de origen"
read origin
origin=$(echo $origin | tr -d "'")
echo $origin 
unzip   $origin  -d $tmpDest/
tmpFolderInstaller=$(ls $tmpDest)
mv $tmpDest/$tmpFolderInstaller $dest/$folderInstaller
rm -R -f $tmpDest

echo "[Desktop Entry]
Comment=Microsoft Visual Studio Code
Terminal=false
Name=Visual Studio Code
Icon="$dest/$folderInstaller"/resources/app/resources/linux/vscode.png
Exec="$dest/$folderInstaller"/Code
Type=Application" >> $shortcut
ln -s $dest/$folderInstaller"/code" $link
