#!/usr/bin/env bash
# author: noflcl

_homeConfig="/home/$USER/.config/home-manager/home.nix"

apply() {
    echo ""
    echo "Applying Home Manager..."
    home-manager switch
}

edit() {
    $EDITOR $_homeConfig
}

quit(){
        echo -e "\nDisconnecting from the deployOS system"
        echo -e ""
        read -n1 -r -p "The program is ready to exit. Press any key to continue..."
}

cat << "EOF"
     _            _               ___  __    
  __| | ___ _ __ | | ___  _   _  /___\/ _\   
 / _` |/ _ \ '_ \| |/ _ \| | | |//  //\ \    
| (_| |  __/ |_) | | (_) | |_| / \_// _\ \   
 \__,_|\___| .__/|_|\___/ \__, \___/  \__/   
           |_|            |___/              
  Early Beta Edition: Hold my beer! 🍻

EOF

echo -e " This tool will manage your user configuartion.\n"
echo -e ""
echo -e " I am crude early beta tool...\n"

while true; do
                echo -e " a | A - Apply changes to your home.nix file"
                echo -e " e | E - Edit your home.nix file"
                echo -e " x | X - This will terminate and exit this tool"
                echo -e ""
                read -p " Please Select from one of the following options: " choice
 
                case "$choice" in
                        a|A ) apply ;;
                        e|E ) edit ;;
                        x|X|q|Q ) quit; break ;;
                          * ) echo -e "\n That is an invalid selection.\n" ;;
                esac
        done