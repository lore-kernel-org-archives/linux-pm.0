From: Eric Sesterhenn <snakebyte@gmx.de>
Subject: Re: Suspend regression, hang after matroxfb
Date: Fri, 30 Jan 2009 13:46:43 +0100
Message-ID: <20090130124643.GA8394__4754.51370371065$1233319772$gmane$org@alice>
References: <20090129125855.GA4597@alice> <200901292312.44884.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200901292312.44884.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, Kernel Testers <kernel-testers@vger.kernel.org>, vandrove@vc.cvut.cz
List-Id: linux-pm@vger.kernel.org

* Rafael J. Wysocki (rjw@sisk.pl) wrote:
> On Thursday 29 January 2009, Eric Sesterhenn wrote:
> > hi,
> > 
> > on this box standby worked with 2.6.28, but is broken with 2.6.29-rc3.
> > 
> > Dmesg of startup
> > http://www.cccmz.de/~snakebyte/200.log
> > .config
> > http://www.cccmz.de/~snakebyte/config_200
> > 
> > When testing the devices 
> > 
> > root@computer-desktop:/sys/power# echo devices > pm_test 
> 
> What happens if you replace 'devices' with 'core' ?

no change, it hangs after matroxfb

root@computer-desktop:/sys/power# echo core > pm_test 
root@computer-desktop:/sys/power# echo standby > state

[  220.808462] PM: Syncing filesystems ... done.
[  220.825735] PM: Preparing system for standby sleep
[  220.832295] Freezing user space processes ... (elapsed 0.00 seconds)
done.
[  220.835975] Freezing remaining freezable tasks ... (elapsed 0.00
seconds) done.
[  220.837080] PM: Entering standby sleep
[  220.837709] agpgart-intel 0000:00:00.0: preparing suspend
[  220.837816] pci 0000:00:01.0: preparing suspend
[  220.837925] pci 0000:00:07.0: preparing suspend
[  220.838018] ata_piix 0000:00:07.1: preparing suspend
[  220.838141] uhci_hcd 0000:00:07.2: preparing suspend
[  220.838238] piix4_smbus 0000:00:07.3: preparing suspend
[  220.838363] pci 0000:00:0a.0: preparing suspend
[  220.838455] aic7xxx 0000:00:0c.0: preparing suspend
[  220.838577] 8139too 0000:00:0e.0: preparing suspend
[  220.838672] RIPTIDE 0000:00:12.0: preparing suspend
[  220.838794] pci 0000:00:12.1: preparing suspend
[  220.838886] pci 0000:00:12.2: preparing suspend
[  220.838992] matroxfb 0000:01:00.0: preparing suspend
[  220.839246] platform pcspkr: preparing suspend
[  220.839360] platform microcode: preparing suspend
[  220.839518] vga16fb vga16fb.0: preparing suspend
[  220.843272] serial8250 serial8250: preparing suspend
[  220.844125] usb usb1: preparing type suspend, may wakeup
[  220.844269] i8042 i8042: preparing suspend
[  220.844417] rtc-test rtc-test.0: preparing suspend
[  220.844533] rtc-test rtc-test.1: preparing suspend
[  220.845060] ac97 0-0:unknown codec: legacy suspend
[  220.845241] fschmd 3-0073: legacy suspend
[  220.845374] rtc rtc2: legacy class suspend
[  220.845478] rtc-test rtc-test.1: suspend
[  220.845580] rtc rtc1: legacy class suspend
[  220.845735] rtc-test rtc-test.0: suspend
[  220.845870] rtc rtc0: legacy class suspend
[  220.846122] serio serio0: legacy suspend
[  220.846324] i8042 i8042: suspend
[  220.846774] usb usb1: type suspend, may wakeup
[  220.846976] sd 2:0:0:0: legacy suspend
[  220.847282] sd 2:0:0:0: [sda] Synchronizing SCSI cache
[  220.848305] sd 2:0:0:0: [sda] Stopping disk
[  220.965924] scsi 1:0:0:0: legacy suspend
[  220.966646] serial8250 serial8250: suspend
[  220.966798] drm card0: legacy class suspend
[  220.970528] vga16fb vga16fb.0: suspend
[  220.970724] platform microcode: suspend
[  220.970869] platform pcspkr: suspend
[  220.971072] serial 00:08: legacy suspend
[  220.971871] serial 00:08: disabled
[  220.972110] pnp 00:07: legacy suspend
[  220.972249] i8042 kbd 00:06: legacy suspend
[  220.972413] pnp 00:05: legacy suspend
[  220.972547] pnp 00:04: legacy suspend
[  220.972681] rtc_cmos 00:03: legacy suspend, may wakeup
[  220.972914] pnp 00:02: legacy suspend
[  220.973050] system 00:01: legacy suspend
[  220.973209] pnp 00:00: legacy suspend
[  220.973363] matroxfb 0000:01:00.0: suspend
[  220.973694] matroxfb 0000:01:00.0: PCI INT A disabled

> If the same, what happens without the matroxfb driver?

It gets a bit further, suspend seems to complete,
but hangs during resume


[  753.618066] PM: Syncing filesystems ... done.
[  753.643958] PM: Preparing system for standby sleep
[  753.660491] Freezing user space processes ... (elapsed 0.00 seconds)
done.
[  753.664452] Freezing remaining freezable tasks ... (elapsed 0.00
seconds) done.
[  753.665783] PM: Entering standby sleep
[  753.666556] agpgart-intel 0000:00:00.0: preparing suspend
[  753.666777] pci 0000:00:01.0: preparing suspend
[  753.666987] pci 0000:00:07.0: preparing suspend
[  753.667185] ata_piix 0000:00:07.1: preparing suspend
[  753.667420] uhci_hcd 0000:00:07.2: preparing suspend
[  753.667625] piix4_smbus 0000:00:07.3: preparing suspend
[  753.667863] pci 0000:00:0a.0: preparing suspend
[  753.668131] aic7xxx 0000:00:0c.0: preparing suspend
[  753.668337] 8139too 0000:00:0e.0: preparing suspend
[  753.668569] RIPTIDE 0000:00:12.0: preparing suspend
[  753.668771] pci 0000:00:12.1: preparing suspend
[  753.668982] pci 0000:00:12.2: preparing suspend
[  753.669179] pci 0000:01:00.0: preparing suspend
[  753.669539] platform pcspkr: preparing suspend
[  753.669756] platform microcode: preparing suspend
[  753.669993] vga16fb vga16fb.0: preparing suspend
[  753.674075] serial8250 serial8250: preparing suspend
[  753.675018] usb usb1: preparing type suspend, may wakeup
[  753.675272] i8042 i8042: preparing suspend
[  753.675528] rtc-test rtc-test.0: preparing suspend
[  753.675753] rtc-test rtc-test.1: preparing suspend
[  753.676448] ac97 0-0:unknown codec: legacy suspend
[  753.676740] fschmd 0-0073: legacy suspend
[  753.676955] rtc rtc2: legacy class suspend
[  753.677166] rtc-test rtc-test.1: suspend
[  753.677365] rtc rtc1: legacy class suspend
[  753.683332] rtc-test rtc-test.0: suspend
[  753.689205] rtc rtc0: legacy class suspend
[  753.694915] atkbd serio0: legacy suspend
[  754.128100] i8042 i8042: suspend
[  754.133805] usb usb1: type suspend, may wakeup
[  754.139399] sd 2:0:0:0: legacy suspend
[  754.145221] sd 2:0:0:0: [sda] Synchronizing SCSI cache
[  754.151717] sd 2:0:0:0: [sda] Stopping disk
[  754.274990] scsi 1:0:0:0: legacy suspend
[  754.281243] serial8250 serial8250: suspend
[  754.286805] drm card0: legacy class suspend
[  754.296202] vga16fb vga16fb.0: suspend
[  754.301830] platform microcode: suspend
[  754.307463] platform pcspkr: suspend
[  754.313077] serial 00:08: legacy suspend
[  754.319331] serial 00:08: disabled
[  754.324945] pnp 00:07: legacy suspend
[  754.330555] i8042 kbd 00:06: legacy suspend
[  754.336173] pnp 00:05: legacy suspend
[  754.341726] pnp 00:04: legacy suspend
[  754.347186] rtc_cmos 00:03: legacy suspend, may wakeup
[  754.352794] pnp 00:02: legacy suspend
[  754.358162] system 00:01: legacy suspend
[  754.363547] pnp 00:00: legacy suspend
[  754.368987] pci 0000:01:00.0: suspend
[  754.374641] pci 0000:01:00.0: PCI INT A disabled
[  754.396162] pci 0000:00:12.2: suspend
[  754.416089] pci 0000:00:12.1: suspend
[  754.436088] RIPTIDE 0000:00:12.0: suspend
[  754.442619] RIPTIDE 0000:00:12.0: PCI INT A disabled
[  754.448788] ACPI handle has no context!
[  754.468088] 8139too 0000:00:0e.0: suspend
[  760.226866] ata2.00: ACPI cmd c6/00:10:00:00:00:a0 succeeded
[  760.238259] RIPTIDE 0000:00:12.0: resume
[  760.249475] ata2.00: ACPI cmd 91/00:3f:00:00:00:af succeeded
[  760.264115] RIPTIDE 0000:00:12.0: restoring config space at offset
0xf (was 0x1ff, writing 0x10b)
[  760.286261] RIPTIDE 0000:00:12.0: restoring config space at offset
0x4 (was 0x1, writing 0xe001)
[  760.308472] RIPTIDE 0000:00:12.0: restoring config space at offset
0x3 (was 0x800000, writing 0x804000)
[  760.331698] RIPTIDE 0000:00:12.0: restoring config space at offset
0x1 (was 0x2900000, writing 0x2900101)
[  760.355924] RIPTIDE 0000:00:12.0: PCI INT A -> Link[LNKA] -> GSI 11
(level, low) -> IRQ 11
[  761.042233] pci 0000:00:12.1: resume
[  761.054092] pci 0000:00:12.1: PME# disabled
[  761.065818] pci 0000:00:12.2: resume
[  761.076931] pci 0000:00:12.2: PME# disabled
[  761.087950] pci 0000:01:00.0: resume
[  761.098465] pci 0000:01:00.0: PME# disabled
[  761.108609] ata2.00: configured for UDMA/33
[  761.124376] pci 0000:01:00.0: enabling device (0000 -> 0002)

Greetings, Eric

> > root@computer-desktop:/sys/power# echo standby > state
> > 
> > I get this message: 
> > 
> > [  174.177445] PM: Preparing system for standby sleep
> > [  174.182706] Freezing user space processes ... (elapsed 0.00 seconds) done.
> > [  174.186096] Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
> > [  174.186903] PM: Entering standby sleep
> > [  174.620476] sd 2:0:0:0: [sda] Synchronizing SCSI cache
> > [  174.621453] sd 2:0:0:0: [sda] Stopping disk
> > [  174.743784] serial 00:08: disabled
> > [  174.744389] matroxfb 0000:01:00.0: PCI INT A disabled
> > 
> > and the system does not seem to properly suspend / neither wakeup
> > 
> > root@computer-desktop:~# lspci
> > 00:00.0 Host bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev 03)
> > 00:01.0 PCI bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (rev 03)
> > 00:07.0 ISA bridge: Intel Corporation 82371AB/EB/MB PIIX4 ISA (rev 02)
> > 00:07.1 IDE interface: Intel Corporation 82371AB/EB/MB PIIX4 IDE (rev 01)
> > 00:07.2 USB Controller: Intel Corporation 82371AB/EB/MB PIIX4 USB (rev 01)
> > 00:07.3 Bridge: Intel Corporation 82371AB/EB/MB PIIX4 ACPI (rev 02)
> > 00:0a.0 Ethernet controller: Intel Corporation 82556 EtherExpress PRO/100 Smart (rev 03)
> > 00:0c.0 SCSI storage controller: Adaptec AIC-7861 (rev 03)
> > 00:0e.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
> > 00:12.0 Multimedia audio controller: Rockwell International Device 4310
> > 00:12.1 Communication controller: Rockwell International Riptide HSF 56k PCI Modem
> > 00:12.2 Input device controller: Rockwell International Device 4312
> > 01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G200 AGP (rev 03)
> > 
> > root@computer-desktop:~# lsmod
> > Module                  Size  Used by
> > nfsd                  217580  13 
> > exportfs                4608  1 nfsd
> > nfs                   253896  1 
> > lockd                  66984  2 nfsd,nfs
> > nfs_acl                 3328  2 nfsd,nfs
> > auth_rpcgss            36160  2 nfsd,nfs
> > sunrpc                185716  16 nfsd,nfs,lockd,nfs_acl,auth_rpcgss
> > ipv6                  252276  10 
> > fuse                   54188  1 
> > unix                   25404  96
> > 
> > root@computer-desktop:/usr/src/linux# cat /proc/cpuinfo 
> > processor	: 0
> > vendor_id	: GenuineIntel
> > cpu family	: 6
> > model		: 8
> > model name	: Pentium III (Coppermine)
> > stepping	: 3
> > cpu MHz		: 697.840
> > cache size	: 256 KB
> > fdiv_bug	: no
> > hlt_bug		: no
> > f00f_bug	: no
> > coma_bug	: no
> > fpu		: yes
> > fpu_exception	: yes
> > cpuid level	: 2
> > wp		: yes
> > flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr sse
> > bogomips	: 1395.68
> > clflush size	: 32
> > power management:
> > 
> > 
> > After PM_VERBOSE enabled the log changes to this:
> > 
> > [ 1968.407273] PM: Syncing filesystems ... done.
> > [ 1968.424490] PM: Preparing system for standby sleep
> > [ 1968.431142] Freezing user space processes ... (elapsed 0.00 seconds) done.
> > [ 1968.434866] Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
> > [ 1968.435887] PM: Entering standby sleep
> > [ 1968.436580] agpgart-intel 0000:00:00.0: preparing suspend
> > [ 1968.436683] pci 0000:00:01.0: preparing suspend
> > [ 1968.436788] pci 0000:00:07.0: preparing suspend
> > [ 1968.436877] ata_piix 0000:00:07.1: preparing suspend
> > [ 1968.436998] uhci_hcd 0000:00:07.2: preparing suspend
> > [ 1968.437091] piix4_smbus 0000:00:07.3: preparing suspend
> > [ 1968.437213] pci 0000:00:0a.0: preparing suspend
> > [ 1968.437301] aic7xxx 0000:00:0c.0: preparing suspend
> > [ 1968.437420] 8139too 0000:00:0e.0: preparing suspend
> > [ 1968.437511] RIPTIDE 0000:00:12.0: preparing suspend
> > [ 1968.437617] pci 0000:00:12.1: preparing suspend
> > [ 1968.437705] pci 0000:00:12.2: preparing suspend
> > [ 1968.437807] matroxfb 0000:01:00.0: preparing suspend
> > [ 1968.438056] platform pcspkr: preparing suspend
> > [ 1968.438166] platform microcode: preparing suspend
> > [ 1968.438321] vga16fb vga16fb.0: preparing suspend
> > [ 1968.442065] serial8250 serial8250: preparing suspend
> > [ 1968.442857] usb usb1: preparing type suspend, may wakeup
> > [ 1968.442995] i8042 i8042: preparing suspend
> > [ 1968.443144] rtc-test rtc-test.0: preparing suspend
> > [ 1968.443256] rtc-test rtc-test.1: preparing suspend
> > [ 1968.443785] ac97 0-0:unknown codec: legacy suspend
> > [ 1968.443960] fschmd 3-0073: legacy suspend
> > [ 1968.444151] rtc rtc2: legacy class suspend
> > [ 1968.444252] rtc-test rtc-test.1: suspend
> > [ 1968.444351] rtc rtc1: legacy class suspend
> > [ 1968.444501] rtc-test rtc-test.0: suspend
> > [ 1968.444638] rtc rtc0: legacy class suspend
> > [ 1968.444883] atkbd serio0: legacy suspend
> > [ 1968.872096] i8042 i8042: suspend
> > [ 1968.872384] usb usb1: type suspend, may wakeup
> > [ 1968.872581] sd 2:0:0:0: legacy suspend
> > [ 1968.872881] sd 2:0:0:0: [sda] Synchronizing SCSI cache
> > [ 1968.873883] sd 2:0:0:0: [sda] Stopping disk
> > [ 1968.992131] scsi 1:0:0:0: legacy suspend
> > [ 1968.992852] serial8250 serial8250: suspend
> > [ 1968.992997] drm card0: legacy class suspend
> > [ 1968.996728] vga16fb vga16fb.0: suspend
> > [ 1968.996920] platform microcode: suspend
> > [ 1968.997059] platform pcspkr: suspend
> > [ 1968.997256] serial 00:08: legacy suspend
> > [ 1968.998043] serial 00:08: disabled
> > [ 1968.998213] pnp 00:07: legacy suspend
> > [ 1968.998343] i8042 kbd 00:06: legacy suspend
> > [ 1968.998498] pnp 00:05: legacy suspend
> > [ 1968.998626] pnp 00:04: legacy suspend
> > [ 1968.998754] rtc_cmos 00:03: legacy suspend, may wakeup
> > [ 1968.998980] pnp 00:02: legacy suspend
> > [ 1968.999109] system 00:01: legacy suspend
> > [ 1968.999262] pnp 00:00: legacy suspend
> > [ 1968.999410] matroxfb 0000:01:00.0: suspend
> > [ 1968.999737] matroxfb 0000:01:00.0: PCI INT A disabled
> > 
> > I am not sure if a bisection makes sense
> > with all those suspend bugs.
> 
> No, it doesn't. :-(
> 
> Thanks,
> Rafael
