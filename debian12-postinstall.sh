#Post install script for debian 12 bookworm (gnome)

#Enable Contrib, Non Free repository
sudo apt-add-repository contrib -y
sudo apt-add-repository non-free -y
sudo apt-add-repository non-free-firmware -y

#Add Backport repository
sudo add-apt-repository "deb http://deb.debian.org/debian $(lsb_release -cs)-backports main contrib non-free non-free-firmware" -y

sudo apt update && sudo apt upgrade -y

#Install Codecs, Microsoft Fonts and rar support (Ubuntu restricted-extras)
sudo apt install libavcodec-extra ttf-mscorefonts-installer rar unrar gstreamer1.0-libav gstreamer1.0-plugins-ugly gstreamer1.0-vaapi -y

#Microsoft Fonts alternatives for "Cambria, Calibri"
sudo apt install fonts-crosextra-caladea fonts-crosextra-carlito -y

#Install and Enable Firewall
sudo apt install ufw gufw -y
sudo ufw enable

#Flatpak Support
sudo apt install flatpak -y
sudo apt install gnome-software-plugin-flatpak -y
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

#Remove Gnome games, xiterm
sudo apt purge --autoremove gnome-games xiterm+thai
 
#Install Gnome Extensions
sudo apt install gnome-shell-extension-desktop-icons-ng gnome-shell-extension-dashtodock gnome-shell-extension-dash-to-panel gnome-shell-extension-arc-menu -y
gsettings set org.gnome.shell enabled-extensions "['ding@rastersoft.com', 'dash-to-dock@micxgx.gmail.com']"
#reboot gnome sessione before enable the extensions
#gnome-extensions enable dash-to-dock@micxgx.gmail.com
#gnome-extensions enable ding@rastersoft.com


#Update Grub with quiet splash
sudo sed -i 's/^GRUB_CMDLINE_LINUX_DEFAULT=.*/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"/' /etc/default/grub
sudo sed -i 's/^quiet_boot="0"/quiet_boot="1"/g' /etc/grub.d/10_linux
sudo update-grub

#Enable Wayland and Touch in Firefox
echo 'export MOZ_ENABLE_WAYLAND=1' | sudo tee /etc/profile.d/firefox-wayland.sh
