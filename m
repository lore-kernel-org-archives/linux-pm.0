From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Suspend wakes right back up
Date: Sun, 26 Jun 2016 15:45:06 +0200
Message-ID: <20160626134506.GA5509@amd>
References: <20160531063332.69d9c389@ulgy_thing>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160531063332.69d9c389@ulgy_thing>
Sender: linux-kernel-owner@vger.kernel.org
To: David Niklas <Hgntkwis@vfemail.net>
Cc: LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue 2016-05-31 06:33:32, David Niklas wrote:
> Hello,
> My laptop will, after a short while, wake right up after issuing the command
> pm-suspend.
> The computer does not need to be connected to the internet.
> I Get no errors and pm-suspend returns 0.
> This tells me that the kernel must have some sort of wakeup event
set.

Ok... you may want to play with /proc/acpi/wakeup... and you may want
to mention kernel version, which machine it is, and if it ever worked
ok in linux.

Best regards,
								Pavel


> The output on syslog is as follows (includes dmesg output):
> #########################################
> May 28 20:47:26 [kernel] [6235719.374042] PM: Syncing filesystems ... done.
> May 28 20:47:26 [kernel] [6235719.618066] Freezing user space processes ... (elapsed 0.001 seconds) done.
> May 28 20:47:26 [kernel] [6235719.619563] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
> May 28 20:47:26 [kernel] [6235719.620969] Suspending console(s) (use no_console_suspend to debug)
> May 28 20:47:26 [kernel] [6235719.621198] wlan0: deauthenticating from 00:14:d1:37:34:ec by local choice (Reason: 3=DEAUTH_LEAVING)
> May 28 20:47:26 [kernel] [6235719.628656] queueing ieee80211 work while going to suspend
> May 28 20:47:26 [kernel] [6235719.636591] sd 0:0:0:0: [sda] Synchronizing SCSI cache
> May 28 20:47:26 [kernel] [6235719.636706] sd 0:0:0:0: [sda] Stopping disk
> May 28 20:47:26 [kernel] [6235719.636733] cfg80211: Calling CRDA to update world regulatory domain
> May 28 20:47:26 [kernel] [6235720.225320] PM: suspend of devices complete after 604.389 msecs
> May 28 20:47:26 [kernel] [6235720.238675] PM: late suspend of devices complete after 13.352 msecs
> May 28 20:47:26 [kernel] [6235720.239515] ehci-pci 0000:00:1d.0: System wakeup enabled by ACPI
> May 28 20:47:26 [kernel] [6235720.239637] ehci-pci 0000:00:1a.0: System wakeup enabled by ACPI
> May 28 20:47:26 [kernel] [6235720.239743] xhci_hcd 0000:00:14.0: System wakeup enabled by ACPI
> May 28 20:47:26 [kernel] [6235720.252090] PM: noirq suspend of devices complete after 13.416 msecs
> May 28 20:47:26 [kernel] [6235720.252289] ACPI: Preparing to enter system sleep state S3
> May 28 20:47:26 [kernel] [6235720.255273] ACPI : EC: EC stopped
> May 28 20:47:26 [kernel] [6235720.255274] PM: Saving platform NVS memory
> May 28 20:47:26 [kernel] [6235720.255279] Disabling non-boot CPUs ...
> May 28 20:47:26 [kernel] [6235720.255321] intel_pstate CPU 1 exiting
> May 28 20:47:26 [kernel] [6235720.256561] smpboot: CPU 1 is now offline
> May 28 20:47:26 [kernel] [6235720.269807] ACPI: Low-level resume complete
> May 28 20:47:26 [kernel] [6235720.269858] ACPI : EC: EC started
> May 28 20:47:26 [kernel] [6235720.269858] PM: Restoring platform NVS memory
> May 28 20:47:26 [kernel] [6235720.270210] microcode: CPU0 sig=0x306a9, pf=0x10, revision=0x1b
> May 28 20:47:26 [kernel] [6235720.270215] Enabling non-boot CPUs ...
> May 28 20:47:26 [kernel] [6235720.270255] x86: Booting SMP configuration:
> May 28 20:47:26 [kernel] [6235720.270256] smpboot: Booting Node 0 Processor 1 APIC 0x2
> May 28 20:47:26 [kernel] [6235720.296719]  cache: parent cpu1 should not be sleeping
> May 28 20:47:26 [kernel] [6235720.296822] microcode: CPU1 sig=0x306a9, pf=0x10, revision=0x17
> May 28 20:47:26 [kernel] [6235720.297686] microcode: CPU1 updated to revision 0x1b, date = 2014-05-29
> May 28 20:47:26 [kernel] [6235720.297693] CPU1 is up
> May 28 20:47:26 [kernel] [6235720.299022] ACPI: Waking up from system sleep state S3
> May 28 20:47:26 [kernel] [6235720.313242] ehci-pci 0000:00:1d.0: System wakeup disabled by ACPI
> May 28 20:47:26 [kernel] [6235720.313441] xhci_hcd 0000:00:14.0: System wakeup disabled by ACPI
> May 28 20:47:26 [kernel] [6235720.313599] ehci-pci 0000:00:1a.0: System wakeup disabled by ACPI
> May 28 20:47:26 [kernel] [6235720.313822] PM: noirq resume of devices complete after 12.779 msecs
> May 28 20:47:26 [kernel] [6235720.314075] PM: early resume of devices complete after 0.190 msecs
> May 28 20:47:26 [kernel] [6235720.320422] ath: phy0: ASPM enabled: 0x42
> May 28 20:47:26 [kernel] [6235720.379426] sd 0:0:0:0: [sda] Starting disk
> May 28 20:47:26 [kernel] [6235720.423301] rtc_cmos 00:03: System wakeup disabled by ACPI
> May 28 20:47:26 [kernel] [6235720.543151] usb 4-1.4: reset full-speed USB device number 3 using ehci-pci
> May 28 20:47:26 [kernel] [6235720.543158] usb 3-1.1: reset full-speed USB device number 3 using ehci-pci
> May 28 20:47:26 [kernel] [6235720.693093] usb 3-1.3: reset high-speed USB device number 18 using ehci-pci
> May 28 20:47:26 [kernel] [6235720.703078] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> May 28 20:47:26 [kernel] [6235720.706744] ata3.00: configured for UDMA/133
> May 28 20:47:26 [kernel] [6235721.326610] PM: resume of devices complete after 1012.854 msecs
> May 28 20:47:26 [dhcpcd] wlan0: carrier lost
> May 28 20:47:26 [kernel] [6235721.326902] Restarting tasks ... done.
> May 28 20:47:26 [kernel] [6235721.347844] cfg80211: World regulatory domain updated:
> May 28 20:47:26 [kernel] [6235721.347849] cfg80211:  DFS Master region: unset
> May 28 20:47:26 [kernel] [6235721.347850] cfg80211:   (start_freq - end_freq @ bandwidth), (max_antenna_gain, max_eirp), (dfs_cac_time)
> May 28 20:47:26 [kernel] [6235721.347853] cfg80211:   (2402000 KHz - 2472000 KHz @ 40000 KHz), (N/A, 2000 mBm), (N/A)
> May 28 20:47:26 [kernel] [6235721.347856] cfg80211:   (2457000 KHz - 2482000 KHz @ 20000 KHz, 92000 KHz AUTO), (N/A, 2000 mBm), (N/A)
> May 28 20:47:26 [kernel] [6235721.347858] cfg80211:   (2474000 KHz - 2494000 KHz @ 20000 KHz), (N/A, 2000 mBm), (N/A)
> May 28 20:47:26 [kernel] [6235721.347860] cfg80211:   (5170000 KHz - 5250000 KHz @ 80000 KHz, 160000 KHz AUTO), (N/A, 2000 mBm), (N/A)
> May 28 20:47:26 [kernel] [6235721.347863] cfg80211:   (5250000 KHz - 5330000 KHz @ 80000 KHz, 160000 KHz AUTO), (N/A, 2000 mBm), (0 s)
> May 28 20:47:26 [kernel] [6235721.347865] cfg80211:   (5490000 KHz - 5730000 KHz @ 160000 KHz), (N/A, 2000 mBm), (0 s)
> May 28 20:47:26 [kernel] [6235721.347866] cfg80211:   (5735000 KHz - 5835000 KHz @ 80000 KHz), (N/A, 2000 mBm), (N/A)
> May 28 20:47:26 [kernel] [6235721.347868] cfg80211:   (57240000 KHz - 63720000 KHz @ 2160000 KHz), (N/A, 0 mBm), (N/A)
> May 28 20:47:26 [laptop-mode] Laptop mode 
> May 28 20:47:26 [laptop-mode] enabled, not active
> May 28 20:47:26 [dhcpcd] wlan0: deleting default route via 192.168.1.1
> May 28 20:47:26 [su] Successful su for me by root
> May 28 20:47:26 [kernel] [6235721.691661] Turbo disabled by BIOS or unavailable on processor
> May 28 20:47:26 [kernel] [6235721.756917] NMI watchdog: enabled on all CPUs, permanently consumes one hw-PMU counter.
> May 28 20:47:26 [laptop-mode] Failed.
> May 28 20:47:27 [kernel] [6235722.319501] wlan0: authenticate with 00:14:d1:37:34:ec
> May 28 20:47:27 [kernel] [6235722.338154] wlan0: send auth to 00:14:d1:37:34:ec (try 1/3)
> May 28 20:47:27 [kernel] [6235722.340567] wlan0: authenticated
> May 28 20:47:27 [kernel] [6235722.340676] ath9k 0000:03:00.0 wlan0: disabling HT as WMM/QoS is not supported by the AP
> May 28 20:47:27 [kernel] [6235722.340679] ath9k 0000:03:00.0 wlan0: disabling VHT as WMM/QoS is not supported by the AP
> May 28 20:47:27 [dhcpcd] wlan0: carrier acquired
> May 28 20:47:27 [kernel] [6235722.342507] wlan0: associate with 00:14:d1:37:34:ec (try 1/3)
> May 28 20:47:27 [kernel] [6235722.345378] wlan0: RX AssocResp from 00:14:d1:37:34:ec (capab=0x421 status=0 aid=1)
> May 28 20:47:27 [kernel] [6235722.345489] wlan0: associated
> May 28 20:47:27 [dhcpcd] wlan0: IAID 24:21:95:d2
> May 28 20:47:27 [dhcpcd] wlan0: soliciting an IPv6 router
> May 28 20:47:27 [dhcpcd] wlan0: rebinding lease of 192.168.1.100
> May 28 20:47:27 [dhcpcd] wlan0: probing address 192.168.1.100/24
> May 28 20:47:27 [kernel] [6235723.112248] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> May 28 20:47:28 [kernel] [6235723.255254] ata1.00: configured for UDMA/133
> May 28 20:47:28 [su] + ??? root:me
> May 28 20:47:28 [su] Successful su for me by root
> May 28 20:47:28 [su] + ??? root:me
> May 28 20:47:28 [su] Successful su for me by root
> May 28 20:47:28 [su] + ??? root:me
> May 28 20:47:28 [root] Device /sys/bus/usb/devices/4-1.3 is blacklisted, skipping auto suspend.
> May 28 20:47:28 [laptop-mode] Laptop mode 
> May 28 20:47:28 [laptop-mode] enabled, not active
> May 28 20:47:28 [su] Successful su for me by root
> May 28 20:47:29 [kernel] [6235724.129503] Turbo disabled by BIOS or unavailable on processor
> May 28 20:47:29 [su] + ??? root:me
> May 28 20:47:29 [kernel] [6235724.197725] NMI watchdog: enabled on all CPUs, permanently consumes one hw-PMU counter.
> May 28 20:47:29 [su] Successful su for me by root
> May 28 20:47:29 [su] + ??? root:me
> May 28 20:47:29 [su] Successful su for me by root
> May 28 20:47:29 [laptop-mode] Failed.
> May 28 20:47:29 [su] + ??? root:me
> May 28 20:47:31 [root] Device /sys/bus/usb/devices/4-1.3 is blacklisted, skipping auto suspend.
> May 28 20:47:32 [dhcpcd] wlan0: leased 192.168.1.100 for 86400 seconds
> May 28 20:47:32 [dhcpcd] wlan0: adding route to 192.168.1.0/24
> May 28 20:47:32 [dhcpcd] wlan0: adding default route via 192.168.1.1
> May 28 20:47:32 [dhcpcd] wlan0: removing route to 192.168.1.0/24
> May 28 20:47:39 [dhcpcd] wlan0: no IPv6 Routers available
> May 28 20:49:32 [root] ACPI event unhandled: button/lid LID close
> May 28 20:49:32 [kernel] [6235847.569044] i915 0000:00:02.0: BAR 6: [??? 0x00000000 flags 0x2] has bogus alignment
> May 28 20:49:32 [kernel] [6235847.569111] i915 0000:00:02.0: BAR 6: [??? 0x00000000 flags 0x2] has bogus alignment
> May 28 20:49:32 [kernel] [6235847.569160] i915 0000:00:02.0: BAR 6: [??? 0x00000000 flags 0x2] has bogus alignment
> May 28 20:49:32 [kernel] [6235847.569212] i915 0000:00:02.0: BAR 6: [??? 0x00000000 flags 0x2] has bogus alignment
> May 28 20:49:32 [kernel] [6235847.569229] i915 0000:00:02.0: BAR 6: [??? 0x00000000 flags 0x2] has bogus alignment
> May 28 20:49:32 [kernel] [6235847.569464] pci_bus 0000:02: Allocating resources
> May 28 20:49:32 [kernel] [6235847.569520] pci_bus 0000:03: Allocating resources
> May 28 20:49:32 [kernel] [6235847.569536] i915 0000:00:02.0: BAR 6: [??? 0x00000000 flags 0x2] has bogus alignment
> May 28 20:49:32 [kernel] [6235847.569655] i915 0000:00:02.0: BAR 6: [??? 0x00000000 flags 0x2] has bogus alignment
> May 28 20:49:32 [laptop-mode] Laptop mode 
> May 28 20:49:32 [laptop-mode] enabled, not active [unchanged]
> May 28 20:49:35 [root] ACPI event unhandled: button/lid LID open
> May 28 20:49:35 [kernel] [6235850.135204] psmouse serio1: Touchpad at isa0060/serio1/input0 lost sync at byte 6
> May 28 20:49:35 [kernel] [6235850.144716] psmouse serio1: Touchpad at isa0060/serio1/input0 lost sync at byte 6
> May 28 20:49:35 [kernel] [6235850.178222] i915 0000:00:02.0: BAR 6: [??? 0x00000000 flags 0x2] has bogus alignment
> May 28 20:49:35 [kernel] [6235850.178288] i915 0000:00:02.0: BAR 6: [??? 0x00000000 flags 0x2] has bogus alignment
> May 28 20:49:35 [kernel] [6235850.178336] i915 0000:00:02.0: BAR 6: [??? 0x00000000 flags 0x2] has bogus alignment
> May 28 20:49:35 [kernel] [6235850.178387] i915 0000:00:02.0: BAR 6: [??? 0x00000000 flags 0x2] has bogus alignment
> May 28 20:49:35 [kernel] [6235850.178402] i915 0000:00:02.0: BAR 6: [??? 0x00000000 flags 0x2] has bogus alignment
> May 28 20:49:35 [kernel] [6235850.178641] pci_bus 0000:02: Allocating resources
> May 28 20:49:35 [kernel] [6235850.178698] pci_bus 0000:03: Allocating resources
> May 28 20:49:35 [kernel] [6235850.178712] i915 0000:00:02.0: BAR 6: [??? 0x00000000 flags 0x2] has bogus alignment
> May 28 20:49:35 [kernel] [6235850.178833] i915 0000:00:02.0: BAR 6: [??? 0x00000000 flags 0x2] has bogus alignment
> May 28 20:49:35 [laptop-mode] Laptop mode 
> May 28 20:49:35 [laptop-mode] enabled, not active [unchanged]
> #########################################
> 
> Thanks, David
> 
> -------------------------------------------------
> 
> ONLY AT VFEmail! - Use our Metadata Mitigator to keep your email out of the NSA's hands!
> $24.95 ONETIME Lifetime accounts with Privacy Features!  
> 15GB disk! No bandwidth quotas!
> Commercial and Bulk Mail Options!  

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
