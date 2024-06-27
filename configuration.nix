{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = "nix480"; # Define your hostname.
    networkmanager.enable = true;
    nameservers = [ "8.8.8.8" "8.8.4.4" ];
    enableIPv6 = false;
    nat = {
        enable = true;
	internalInterfaces = ["ve-+"];
	externalInterface = "enp0s31f6" ; # eth interface
    };
  };
  
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure the X11 windowing system
  services.xserver.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Desktop environments and display manager
  services.displayManager.sddm = {
    enable = true;
  };
  #services.desktopManager.plasma6 = {
  #  enable = true;
  #};
  programs.hyprland = {
    enable = true;
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # GNOME keyring
  # services.gnome3.gnome-keyring.enable = true;

  # Sound configuration
  hardware = {
    pulseaudio.enable = false;
    bluetooth.enable = true;
  };
  services.blueman.enable = true;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    #jack.enable = true;

    # use the example session manager, enabled by default
    # media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kobi = {
    isNormalUser = true;
    description = "Kobi";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowInsecure = true;

  # Enable Nix Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
	# Utilities
	blueman	# bluetooth
	clang	# C compiler
	fzf	# fuzzy finder
	vim	# basic text editor
	wget	# http puller
	brightnessctl	# brightness control
	fastfetch	# system info
	pipewire	# audio things
	pavucontrol	# pulse audio volume control
	unzip	# open .zip files
	zip	# compress files to .zip
	rar	# handle .rar files
	feh	# lightweight image viewer
	qimgv	# slightly less lightweight image viewer
	grim	# fullscreen screenshot
	slurp	# selected screenshot

	# Environment
	wayland
	wayland-protocols
	xwayland
	sddm
	hyprland	# tiling WM
	swww		# the Solution to your Wayland Wallpaper Woes
	waybar	# status bar for wayland tiling WMs
	wofi	# program search
	alacritty	#terminal emulator
	alacritty-theme
	ranger	# cli file management
	font-manager

	# Development
	git	# version control
	neovim	# the new vim
	vscode
	python3
	dart
	flutter319
	android-studio

	# Apps
	discord
	firefox-wayland
	gimp
	obsidian
	spotify
	steam
	vlc
  ];

  fonts.fontDir.enable = true;
  fonts.packages = with pkgs; [
  	nerdfonts
	font-awesome
	google-fonts
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.stateVersion = "24.05"; # Keep as system version from first install

}
