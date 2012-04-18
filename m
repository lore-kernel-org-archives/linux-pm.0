From: Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>
Subject: Re: [linux-pm] ehci_hcd related S3 lockup on ASUS laptops, again
Date: Wed, 18 Apr 2012 17:41:38 -0400
Message-ID: <1334785298.28106.58.camel@gandalf.stny.rr.com>
References: <Pine.LNX.4.44L0.1204181724570.1149-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1204181724570.1149-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Andrey Rahmatullin <wrar-Bxt/JK/G85ezQB+pC5nmwQ@public.gmane.org>, jrnieder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 2012-04-18 at 17:27 -0400, Alan Stern wrote:

> > Below is the dmesg output after running with pm_test set to "platform".
> 
> The part you included didn't show the suspend itself.  It looks like a 
> bunch of stuff following the resume.  But I guess it doesn't much 
> matter, since we now know what needs to be fixed.

Oops sorry. Even though Andrey posted stuff, I'll post this anyway.

Should include everything you need.

-- Steve


[   42.896778] Intel AES-NI instructions are not detected.
[   43.470301] PM: Starting manual resume from disk
[   43.470384] PM: Hibernation image partition 254:2 present
[   43.470386] PM: Looking for hibernation image.
[   43.470862] PM: Image not found (code -22)
[   43.470864] PM: Hibernation image not present or could not be loaded.
[   43.478348] EXT4-fs (dm-1): INFO: recovery required on readonly filesystem
[   43.478434] EXT4-fs (dm-1): write access will be enabled during recovery
[   43.898420] EXT4-fs (dm-1): recovery complete
[   43.899517] EXT4-fs (dm-1): mounted filesystem with ordered data mode. Opts: (null)
[   45.842764] udev[396]: starting version 164
[   46.558691] input: Lid Switch as /devices/LNXSYSTM:00/device:00/PNP0C0D:00/input/input1
[   46.563721] input: PC Speaker as /devices/platform/pcspkr/input/input2
[   46.573988] ACPI: Lid Switch [LID]
[   46.574101] input: Sleep Button as /devices/LNXSYSTM:00/device:00/PNP0C0E:00/input/input3
[   46.574186] ACPI: Sleep Button [SLPB]
[   46.574281] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input4
[   46.574360] ACPI: Power Button [PWRF]
[   46.580765] wmi: Mapper loaded
[   46.617519] ACPI: AC Adapter [AC0] (on-line)
[   46.635591] Monitor-Mwait will be used to enter C-1 state
[   46.635645] Monitor-Mwait will be used to enter C-2 state
[   46.635673] ACPI: acpi_idle registered with cpuidle
[   46.650782] ACPI: Battery Slot [BAT0] (battery present)
[   46.690831] cfg80211: Calling CRDA to update world regulatory domain
[   46.766509] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[   46.772575] i801_smbus 0000:00:1f.3: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[   46.772658] ACPI: resource 0000:00:1f.3 [io  0xe040-0xe05f] conflicts with ACPI region SMBI [io 0xe040-0xe04f]
[   46.772740] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
[   46.818531] Linux media interface: v0.10
[   46.825793] Bluetooth: Core ver 2.16
[   46.825868] NET: Registered protocol family 31
[   46.825931] Bluetooth: HCI device and connection manager initialized
[   46.825996] Bluetooth: HCI socket layer initialized
[   46.826059] Bluetooth: L2CAP socket layer initialized
[   46.826125] Bluetooth: SCO socket layer initialized
[   46.840697] asus_wmi: ASUS WMI generic driver loaded
[   46.938273] xhci_hcd 0000:03:00.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
[   46.938427] xhci_hcd 0000:03:00.0: setting latency timer to 64
[   46.938432] xhci_hcd 0000:03:00.0: xHCI Host Controller
[   46.938505] xhci_hcd 0000:03:00.0: new USB bus registered, assigned bus number 3
[   46.948266] xhci_hcd 0000:03:00.0: irq 19, io mem 0xdde00000
[   46.948397] xhci_hcd 0000:03:00.0: irq 45 for MSI/MSI-X
[   46.948400] xhci_hcd 0000:03:00.0: irq 46 for MSI/MSI-X
[   46.948404] xhci_hcd 0000:03:00.0: irq 47 for MSI/MSI-X
[   46.948407] xhci_hcd 0000:03:00.0: irq 48 for MSI/MSI-X
[   46.948410] xhci_hcd 0000:03:00.0: irq 49 for MSI/MSI-X
[   46.948518] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002
[   46.948586] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   46.948664] usb usb3: Product: xHCI Host Controller
[   46.948725] usb usb3: Manufacturer: Linux 3.2.5-custom+ xhci_hcd
[   46.948790] usb usb3: SerialNumber: 0000:03:00.0
[   46.948929] xHCI xhci_add_endpoint called for root hub
[   46.948931] xHCI xhci_check_bandwidth called for root hub
[   46.948959] hub 3-0:1.0: USB hub found
[   46.949027] hub 3-0:1.0: 2 ports detected
[   46.949144] xhci_hcd 0000:03:00.0: xHCI Host Controller
[   46.949216] xhci_hcd 0000:03:00.0: new USB bus registered, assigned bus number 4
[   46.949316] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003
[   46.949384] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   46.949462] usb usb4: Product: xHCI Host Controller
[   46.949524] usb usb4: Manufacturer: Linux 3.2.5-custom+ xhci_hcd
[   46.949588] usb usb4: SerialNumber: 0000:03:00.0
[   46.949706] xHCI xhci_add_endpoint called for root hub
[   46.949708] xHCI xhci_check_bandwidth called for root hub
[   46.949731] hub 4-0:1.0: USB hub found
[   46.949798] hub 4-0:1.0: 2 ports detected
[   46.979554] asus_wmi: Initialization: 0x1
[   46.979632] asus_wmi: BIOS WMI version: 7.6
[   46.979788] asus_wmi: SFUN value: 0xa0877
[   46.980446] input: Asus WMI hotkeys as /devices/platform/asus-nb-wmi/input/input5
[   47.042230] asus_wmi: Backlight controlled by ACPI video driver
[   47.117511] Bluetooth: Generic Bluetooth USB driver ver 0.6
[   47.117715] usbcore: registered new interface driver btusb
[   47.139336] Intel(R) Wireless WiFi Link AGN driver for Linux, in-tree:
[   47.139398] Copyright(c) 2003-2011 Intel Corporation
[   47.139488] iwlwifi 0000:02:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[   47.139553] iwlwifi 0000:02:00.0: setting latency timer to 64
[   47.139575] iwlwifi 0000:02:00.0: pci_resource_len = 0x00002000
[   47.139633] iwlwifi 0000:02:00.0: pci_resource_base = ffffc90005790000
[   47.139691] iwlwifi 0000:02:00.0: HW Revision ID = 0x34
[   47.139821] iwlwifi 0000:02:00.0: irq 50 for MSI/MSI-X
[   47.139852] iwlwifi 0000:02:00.0: Detected Intel(R) Centrino(R) Wireless-N 1030 BGN, REV=0xB0
[   47.139983] iwlwifi 0000:02:00.0: L1 Disabled; Enabling L0S
[   47.155846] iwlwifi 0000:02:00.0: device EEPROM VER=0x716, CALIB=0x6
[   47.155908] iwlwifi 0000:02:00.0: Device SKU: 0X150
[   47.155967] iwlwifi 0000:02:00.0: Valid Tx ant: 0X1, Valid Rx ant: 0X3
[   47.156035] iwlwifi 0000:02:00.0: Tunable channels: 13 802.11bg, 0 802.11a channels
[   47.199920] snd_hda_intel 0000:00:1b.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
[   47.200042] snd_hda_intel 0000:00:1b.0: irq 51 for MSI/MSI-X
[   47.200067] snd_hda_intel 0000:00:1b.0: setting latency timer to 64
[   47.275349] Linux video capture interface: v2.00
[   47.303064] uvcvideo: Found UVC 1.00 device USB 2.0 UVC VGA WebCam (13d3:5710)
[   47.309669] input: USB 2.0 UVC VGA WebCam as /devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.2/1-1.2:1.0/input/input6
[   47.309818] usbcore: registered new interface driver uvcvideo
[   47.309881] USB Video Class driver (1.1.1)
[   47.310221] [drm] Initialized drm 1.1.0 20060810
[   47.392764] psmouse serio4: synaptics: Touchpad model: 1, fw: 7.5, id: 0x1e0b1, caps: 0xd00073/0x240000/0xa0400
[   47.426245] input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio4/input/input7
[   47.661923] iwlwifi 0000:02:00.0: loaded firmware version 17.168.5.1 build 33993
[   47.662161] Registered led device: phy0-led
[   47.694429] ieee80211 phy0: Selected rate control algorithm 'iwl-agn-rs'
[   47.963645] HDMI status: Codec=3 Pin=6 Presence_Detect=0 ELD_Valid=0
[   47.963854] input: HDA Intel PCH HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:1b.0/sound/card0/input8
[   47.964240] input: HDA Intel PCH Mic as /devices/pci0000:00/0000:00:1b.0/sound/card0/input9
[   47.964430] input: HDA Intel PCH Headphone as /devices/pci0000:00/0000:00:1b.0/sound/card0/input10
[   47.964770] i915 0000:00:02.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[   47.964834] i915 0000:00:02.0: setting latency timer to 64
[   48.048682] i915 0000:00:02.0: irq 52 for MSI/MSI-X
[   48.048687] [drm] Supports vblank timestamp caching Rev 1 (10.10.2010).
[   48.048748] [drm] Driver supports precise vblank timestamp query.
[   48.048838] vgaarb: device changed decodes: PCI:0000:00:02.0,olddecodes=io+mem,decodes=io+mem:owns=io+mem
[   48.683726] fbcon: inteldrmfb (fb0) is primary device
[   48.924618] Console: switching to colour frame buffer device 170x48
[   48.926877] fb0: inteldrmfb frame buffer device
[   48.926878] drm: registered panic notifier
[   48.979505] ACPI Warning: _BQC returned an invalid level (20110623/video-472)
[   48.979864] acpi device:40: registered as cooling_device4
[   48.980218] input: Video Bus as /devices/LNXSYSTM:00/device:00/PNP0A08:00/LNXVIDEO:00/input/input11
[   48.980302] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[   48.980411] [drm] Initialized i915 1.6.0 20080730 for 0000:00:02.0 on minor 0
[   49.417304] EXT4-fs (dm-1): re-mounted. Opts: (null)
[   49.610562] EXT4-fs (dm-1): re-mounted. Opts: errors=remount-ro
[   49.833738] loop: module loaded
[   50.257032] Adding 7811068k swap on /dev/mapper/VG00-Swap.  Priority:-1 extents:1 across:7811068k 
[   51.068930] kjournald starting.  Commit interval 5 seconds
[   51.069511] EXT3-fs (sda5): using internal journal
[   51.069516] EXT3-fs (sda5): mounted filesystem with ordered data mode
[   51.137232] EXT4-fs (dm-3): mounted filesystem with ordered data mode. Opts: (null)
[   52.829790] fuse init (API version 7.17)
[   54.025020] RPC: Registered named UNIX socket transport module.
[   54.025801] RPC: Registered udp transport module.
[   54.026556] RPC: Registered tcp transport module.
[   54.027316] RPC: Registered tcp NFSv4.1 backchannel transport module.
[   54.396007] Installing knfsd (copyright (C) 1996 okir-pn4DOG8n3UYbFoVRYvo4fw@public.gmane.org).
[   54.759224] input: ACPI Virtual Keyboard Device as /devices/virtual/input/input12
[   56.352662] svc: failed to register lockdv1 RPC service (errno 97).
[   56.353371] NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
[   56.366818] NFSD: starting 90-second grace period
[   58.198428] iwlwifi 0000:02:00.0: L1 Disabled; Enabling L0S
[   58.206338] iwlwifi 0000:02:00.0: Radio type=0x2-0x2-0x1
[   58.298416] iwlwifi 0000:02:00.0: L1 Disabled; Enabling L0S
[   58.307383] iwlwifi 0000:02:00.0: Radio type=0x2-0x2-0x1
[   58.395490] ADDRCONF(NETDEV_UP): wlan0: link is not ready
[   58.404550] atl1c 0000:04:00.0: irq 53 for MSI/MSI-X
[   58.489997] ADDRCONF(NETDEV_UP): eth0: link is not ready
[   67.638348] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   67.638352] Bluetooth: BNEP filters: protocol multicast
[   67.710164] Bridge firewalling registered
[   67.777648] Bluetooth: RFCOMM TTY layer initialized
[   67.777664] Bluetooth: RFCOMM socket layer initialized
[   67.777668] Bluetooth: RFCOMM ver 1.11
[   70.854657] lp: driver loaded but no devices found
[   70.871763] ppdev: user-space parallel port driver
[   74.010024] sshd (2152): /proc/2152/oom_adj is deprecated, please use /proc/2152/oom_score_adj instead.
[   88.946287] wlan0: authenticate with e0:91:f5:5e:86:d4 (try 1)
[   88.949046] wlan0: authenticated
[   88.949130] wlan0: associate with e0:91:f5:5e:86:d4 (try 1)
[   88.952812] wlan0: RX AssocResp from e0:91:f5:5e:86:d4 (capab=0x411 status=0 aid=6)
[   88.952815] wlan0: associated
[   88.959397] ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
[   99.259619] wlan0: no IPv6 routers present
[  126.278905] iwlwifi 0000:02:00.0: Tx aggregation enabled on ra = e0:91:f5:5e:86:d4 tid = 6
[  157.542516] ehci_hcd 0000:00:1a.0: remove, state 1
[  157.544628] usb usb1: USB disconnect, device number 1
[  157.546782] usb 1-1: USB disconnect, device number 2
[  157.549045] usb 1-1.1: USB disconnect, device number 3
[  157.551452] usb 1-1: clear tt 1 (9032) error -19
[  157.551485] Bluetooth: hci0 urb ffff88022f4d1d80 submission failed
[  157.802999] usb 1-1.2: USB disconnect, device number 4
[  157.866578] ehci_hcd 0000:00:1a.0: USB bus 1 deregistered
[  157.869037] ehci_hcd 0000:00:1a.0: PCI INT A disabled
[  157.871489] ehci_hcd 0000:00:1d.0: remove, state 4
[  157.873594] usb usb2: USB disconnect, device number 1
[  157.875670] usb 2-1: USB disconnect, device number 2
[  157.882492] ehci_hcd 0000:00:1d.0: USB bus 2 deregistered
[  157.884674] ehci_hcd 0000:00:1d.0: PCI INT A disabled
[  158.215336] wlan0: deauthenticating from e0:91:f5:5e:86:d4 by local choice (reason=3)
[  158.427757] cfg80211: Calling CRDA to update world regulatory domain
[  158.949659] PM: Syncing filesystems ... done.
[  158.950715] PM: Preparing system for mem sleep
[  158.951081] Freezing user space processes ... (elapsed 0.01 seconds) done.
[  158.966690] Freezing remaining freezable tasks ... (elapsed 0.01 seconds) done.
[  158.982673] PM: Entering mem sleep
[  158.982783] Suspending console(s) (use no_console_suspend to debug)
[  158.983044] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[  159.025372] pci 0000:00:1f.3: PCI INT C disabled
[  159.173746] sd 0:0:0:0: [sda] Stopping disk
[  159.230634] snd_hda_intel 0000:00:1b.0: PCI INT A disabled
[  159.585813] PM: suspend of devices complete after 603.884 msecs
[  159.601635] atl1c 0000:04:00.0: cur 0 target 3 error 0
[  159.601762] xhci_hcd 0000:03:00.0: PME# enabled
[  159.601769] pcieport 0000:00:1c.3: wake-up capability enabled by ACPI
[  159.617624] xhci_hcd 0000:03:00.0: cur 0 target 3 error 0
[  159.633600] iwlwifi 0000:02:00.0: cur 0 target 3 error 0
[  159.633654] pci 0000:00:1f.3: cur 0 target 0 error 0
[  159.633703] pci 0000:00:1f.0: cur 5 target 0 error 0
[  159.633734] pci 0000:00:1d.0: PME# enabled
[  159.633739] pci 0000:00:1d.0: wake-up capability enabled by ACPI
[  159.649551] pci 0000:00:1d.0: cur 0 target 3 error 0
[  159.649629] pci 0000:00:1a.0: PME# enabled
[  159.649656] pci 0000:00:1a.0: wake-up capability enabled by ACPI
[  159.665525] pci 0000:00:1a.0: cur 0 target 3 error 0
[  159.681497] pci 0000:00:16.0: Refused to change power state, currently in D0
[  159.681506] pci 0000:00:16.0: cur 5 target 3 error 0
[  159.681571] PM: late suspend of devices complete after 95.909 msecs
[  159.682243] ACPI: Preparing to enter system sleep state S3
[  161.191414] PM: Saving platform NVS memory
[  161.192356] suspend debug: Waiting for 5 seconds.
[  166.142910] ACPI: Waking up from system sleep state S3
[  166.230892] i915 0000:00:02.0: BAR 0: set to [mem 0xdd000000-0xdd3fffff 64bit] (PCI address [0xdd000000-0xdd3fffff])
[  166.230907] i915 0000:00:02.0: BAR 2: set to [mem 0xc0000000-0xcfffffff 64bit pref] (PCI address [0xc0000000-0xcfffffff])
[  166.230917] i915 0000:00:02.0: BAR 4: set to [io  0xe000-0xe03f] (PCI address [0xe000-0xe03f])
[  166.230951] i915 0000:00:02.0: restoring config space at offset 0x1 (was 0x900403, writing 0x900407)
[  166.246866] pci 0000:00:1a.0: BAR 0: set to [mem 0xdfc08000-0xdfc083ff] (PCI address [0xdfc08000-0xdfc083ff])
[  166.246900] pci 0000:00:1a.0: restoring config space at offset 0xf (was 0x100, writing 0x10b)
[  166.246942] pci 0000:00:1a.0: restoring config space at offset 0x1 (was 0x2900000, writing 0x2900002)
[  166.262844] snd_hda_intel 0000:00:1b.0: BAR 0: set to [mem 0xdfc00000-0xdfc03fff 64bit] (PCI address [0xdfc00000-0xdfc03fff])
[  166.262883] snd_hda_intel 0000:00:1b.0: restoring config space at offset 0xf (was 0x100, writing 0x105)
[  166.262920] snd_hda_intel 0000:00:1b.0: restoring config space at offset 0x3 (was 0x0, writing 0x10)
[  166.262941] snd_hda_intel 0000:00:1b.0: restoring config space at offset 0x1 (was 0x100000, writing 0x100002)
[  166.278813] pci 0000:00:1d.0: BAR 0: set to [mem 0xdfc07000-0xdfc073ff] (PCI address [0xdfc07000-0xdfc073ff])
[  166.278848] pci 0000:00:1d.0: restoring config space at offset 0xf (was 0x100, writing 0x105)
[  166.278889] pci 0000:00:1d.0: restoring config space at offset 0x1 (was 0x2900000, writing 0x2900002)
[  166.294842] ahci 0000:00:1f.2: restoring config space at offset 0x1 (was 0x2b00403, writing 0x2b00407)
[  166.310776] iwlwifi 0000:02:00.0: BAR 0: set to [mem 0xde800000-0xde801fff 64bit] (PCI address [0xde800000-0xde801fff])
[  166.310837] iwlwifi 0000:02:00.0: restoring config space at offset 0xf (was 0x100, writing 0x105)
[  166.310901] iwlwifi 0000:02:00.0: restoring config space at offset 0x1 (was 0x100000, writing 0x100006)
[  166.326745] xhci_hcd 0000:03:00.0: BAR 0: set to [mem 0xdde00000-0xdde07fff 64bit] (PCI address [0xdde00000-0xdde07fff])
[  166.326906] pcieport 0000:00:1c.3: wake-up capability disabled by ACPI
[  166.326912] xhci_hcd 0000:03:00.0: PME# disabled
[  166.342863] PM: early resume of devices complete after 127.606 msecs
[  166.342935] i915 0000:00:02.0: setting latency timer to 64
[  166.342940] pci 0000:00:1a.0: wake-up capability disabled by ACPI
[  166.342947] pci 0000:00:1a.0: PME# disabled
[  166.342950] snd_hda_intel 0000:00:1b.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
[  166.342961] snd_hda_intel 0000:00:1b.0: setting latency timer to 64
[  166.342970] pci 0000:00:1d.0: wake-up capability disabled by ACPI
[  166.342976] pci 0000:00:1d.0: PME# disabled
[  166.342984] pci 0000:00:1f.3: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[  166.342987] ahci 0000:00:1f.2: setting latency timer to 64
[  166.343018] xhci_hcd 0000:03:00.0: setting latency timer to 64
[  166.343039] snd_hda_intel 0000:00:1b.0: irq 51 for MSI/MSI-X
[  166.343042] usb usb3: root hub lost power or was reset
[  166.343043] usb usb4: root hub lost power or was reset
[  166.343140] sd 0:0:0:0: [sda] Starting disk
[  166.347650] xhci_hcd 0000:03:00.0: irq 45 for MSI/MSI-X
[  166.347653] xhci_hcd 0000:03:00.0: irq 46 for MSI/MSI-X
[  166.347657] xhci_hcd 0000:03:00.0: irq 47 for MSI/MSI-X
[  166.347661] xhci_hcd 0000:03:00.0: irq 48 for MSI/MSI-X
[  166.347665] xhci_hcd 0000:03:00.0: irq 49 for MSI/MSI-X
[  166.662204] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  166.670183] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  166.673729] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) filtered out
[  166.683187] ata1.00: ACPI cmd ef/10:06:00:00:00:a0 (SET FEATURES) succeeded
[  166.683190] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) filtered out
[  166.684986] ata3.00: ACPI cmd ef/10:06:00:00:00:a0 (SET FEATURES) succeeded
[  166.684996] ata3.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) filtered out
[  166.713928] ata3.00: ACPI cmd ef/10:06:00:00:00:a0 (SET FEATURES) succeeded
[  166.713938] ata3.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) filtered out
[  166.726782] ata3.00: configured for UDMA/100
[  168.627624] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) filtered out
[  168.627913] ata1.00: ACPI cmd ef/10:06:00:00:00:a0 (SET FEATURES) succeeded
[  168.627923] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) filtered out
[  168.628796] ata1.00: configured for UDMA/133
[  168.660546] PM: resume of devices complete after 2321.391 msecs
[  168.660712] PM: Finishing wakeup.
[  168.660713] Restarting tasks ... done.
[  168.665650] video LNXVIDEO:00: Restoring backlight state
[  168.701530] iwlwifi 0000:02:00.0: L1 Disabled; Enabling L0S
[  168.709187] iwlwifi 0000:02:00.0: Radio type=0x2-0x2-0x1
[  168.801144] ADDRCONF(NETDEV_UP): wlan0: link is not ready
[  168.803561] atl1c 0000:04:00.0: irq 53 for MSI/MSI-X
[  168.888515] ADDRCONF(NETDEV_UP): eth0: link is not ready
[  168.898150] ehci_hcd 0000:00:1a.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[  168.900556] ehci_hcd 0000:00:1a.0: setting latency timer to 64
[  168.900566] ehci_hcd 0000:00:1a.0: EHCI Host Controller
[  168.902803] ehci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 1
[  168.905033] ehci_hcd 0000:00:1a.0: debug port 2
[  168.911060] ehci_hcd 0000:00:1a.0: cache line size of 64 is not supported
[  168.911074] ehci_hcd 0000:00:1a.0: irq 16, io mem 0xdfc08000
[  168.926501] ehci_hcd 0000:00:1a.0: USB 2.0 started, EHCI 1.00
[  168.927782] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[  168.929028] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[  168.930280] usb usb1: Product: EHCI Host Controller
[  168.931159] usb usb1: Manufacturer: Linux 3.2.5-custom+ ehci_hcd
[  168.931825] usb usb1: SerialNumber: 0000:00:1a.0
[  168.932636] hub 1-0:1.0: USB hub found
[  168.933580] hub 1-0:1.0: 2 ports detected
[  168.958631] ehci_hcd 0000:00:1d.0: PCI INT A -> GSI 23 (level, low) -> IRQ 23
[  168.959979] ehci_hcd 0000:00:1d.0: setting latency timer to 64
[  168.959985] ehci_hcd 0000:00:1d.0: EHCI Host Controller
[  168.961010] ehci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
[  168.961888] ehci_hcd 0000:00:1d.0: debug port 2
[  168.966644] ehci_hcd 0000:00:1d.0: cache line size of 64 is not supported
[  168.966659] ehci_hcd 0000:00:1d.0: irq 23, io mem 0xdfc07000
[  168.982442] ehci_hcd 0000:00:1d.0: USB 2.0 started, EHCI 1.00
[  168.984712] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
[  168.986937] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[  168.989072] usb usb2: Product: EHCI Host Controller
[  168.991221] usb usb2: Manufacturer: Linux 3.2.5-custom+ ehci_hcd
[  168.993345] usb usb2: SerialNumber: 0000:00:1d.0
[  168.995824] hub 2-0:1.0: USB hub found
[  168.996495] hub 2-0:1.0: 2 ports detected
[  169.246068] usb 1-1: new high-speed USB device number 2 using ehci_hcd
[  169.378364] usb 1-1: New USB device found, idVendor=8087, idProduct=0024
[  169.380124] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[  169.382318] hub 1-1:1.0: USB hub found
[  169.384196] hub 1-1:1.0: 6 ports detected
[  169.497629] usb 2-1: new high-speed USB device number 2 using ehci_hcd
[  169.629894] usb 2-1: New USB device found, idVendor=8087, idProduct=0024
[  169.632100] usb 2-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[  169.635009] hub 2-1:1.0: USB hub found
[  169.637506] hub 2-1:1.0: 6 ports detected
[  169.713401] usb 1-1.1: new full-speed USB device number 3 using ehci_hcd
[  169.809382] usb 1-1.1: New USB device found, idVendor=8086, idProduct=0189
[  169.811659] usb 1-1.1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[  169.822285] wlan0: authenticate with e0:91:f5:5e:86:d4 (try 1)
[  169.825100] wlan0: authenticated
[  169.825502] wlan0: waiting for beacon from e0:91:f5:5e:86:d4
[  169.835059] wlan0: beacon received
[  169.873008] wlan0: associate with e0:91:f5:5e:86:d4 (try 1)
[  169.876767] wlan0: RX AssocResp from e0:91:f5:5e:86:d4 (capab=0x411 status=0 aid=6)
[  169.876776] wlan0: associated
[  169.881390] ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
[  169.889131] usb 1-1.2: new high-speed USB device number 4 using ehci_hcd
[  170.042023] usb 1-1.2: New USB device found, idVendor=13d3, idProduct=5710
[  170.044334] usb 1-1.2: New USB device strings: Mfr=3, Product=1, SerialNumber=2
[  170.046665] usb 1-1.2: Product: USB 2.0 UVC VGA WebCam
[  170.048996] usb 1-1.2: Manufacturer: Azurewave
[  170.051261] usb 1-1.2: SerialNumber: 0x0001
[  170.055819] uvcvideo: Found UVC 1.00 device USB 2.0 UVC VGA WebCam (13d3:5710)
[  170.066505] input: USB 2.0 UVC VGA WebCam as /devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.2/1-1.2:1.0/input/input13
[  179.996624] wlan0: no IPv6 routers present


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
