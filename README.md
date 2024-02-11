# emacs-config
A backup of my own emacs setup. I'm using org mode so the setup is easier to understand and tweak. 

If you would like to start your own emacs config from scratch and don't know where to begin, I can recommend [Distrotube's tutorial series](https://youtu.be/d1fgypEiQkE?si=Kb9rw8RYmFGrPfkI).

## Additional install steps
These are some issues you might face if you use my config as a starting point:

### Fonts
I'm using fonts from Apple and Jetbrains. You can of course use your favorite fonts instead. However, if you would like to use the same ones, you can :
1. Download the [SF Pro font](https://developer.apple.com/fonts/) directly from Apple.
2. Install the font following [these instructions](https://www.securitronlinux.com/debian-testing/install-mac-osx-fonts-on-linux-easily/).
3. Download and install [JetBrains Mono](https://www.jetbrains.com/lp/mono/]).
### Vterm
For vterm, cmake and libtool are required to deal with the compilation of vterm-module. Install both using your OS' package manager, such as:

`sudo dnf install cmake`

`sudo dnf install libtool`

### All the icons
To complete the all-the-icons install, run `all-the-icons-install-fonts` and restart emacs.
