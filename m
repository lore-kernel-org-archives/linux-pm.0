From: Andrey Rahmatullin <wrar@wrar.name>
Subject: Re: ehci_hcd related S3 lockup on ASUS laptops, again
Date: Fri, 20 Apr 2012 03:48:56 +0600
Message-ID: <20120419214856.GC11484@belkar.wrar.name>
References: <20120419163055.GB11484@belkar.wrar.name>
	<Pine.LNX.4.44L0.1204191404460.1154-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0169084111064128144=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1204191404460.1154-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: jrnieder@gmail.com, linux-pm@lists.linux-foundation.org, USB list <linux-usb@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>
List-Id: linux-pm@vger.kernel.org


--===============0169084111064128144==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wwSkEpePV3aFlXly"
Content-Disposition: inline


--wwSkEpePV3aFlXly
Content-Type: multipart/mixed; boundary="4JxvUTD846AMAZAS"
Content-Disposition: inline


--4JxvUTD846AMAZAS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 19, 2012 at 02:07:47PM -0400, Alan Stern wrote:
> > > Below is a patch that will prevent any PCI device from being put into
> > > D3 during suspend.  (This is meant to be used without any of the
> > > earlier diagnostic patches.)  Obviously it's not the final solution;=
=20
> > > the test in the "if" statement needs to be more discriminating.  :-)
> > >=20
> > > But before going any farther, I'd like to test if USB wakeup works. =
=20
> > > So after booting with this patch, make sure that the power/wakeup file
> > > says "enabled" in the sysfs path for each controller as well as the
> > > usb1, usb2, 1-2, and 2-2 paths under /sys/bus/usb/devices/.
> > >=20
> > > Then suspend the computer without using the script, and while it is
> > > asleep try plugging in a new USB device.  That should cause the
> > > computer to wake up, if everything is working properly.
> > I've set "enabled" for following files:
> >=20
> > /sys/bus/usb/devices/usb1/power/wakeup
> > /sys/bus/usb/devices/usb2/power/wakeup
> > /sys/bus/usb/devices/1-1/power/wakeup
> > /sys/bus/usb/devices/2-1/power/wakeup
> > /sys/bus/pci/devices/0000:00:1a.0/power/wakeup
> > /sys/bus/pci/devices/0000:00:1d.0/power/wakeup
>=20
> Good.
>=20
> > yet it didn't wake up after plugging, though devices light up.
>=20
> You mean, the devices that you plug in light up?
Yes. An mp3 player and a flash drive.

> I'd like to see the dmesg log for the complete suspend/resume cycle=20
> (naturally you'll have to resume the system by hand after plugging in=20
> the USB device).  Make sure that CONFIG_USB_DEBUG is enabled.
Attached.


--=20
WBR, wRAR

--4JxvUTD846AMAZAS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dmesg
Content-Transfer-Encoding: quoted-printable

[  145.122398] PM: Syncing filesystems ... done.
[  146.095904] PM: Preparing system for mem sleep
[  146.110135] Freezing user space processes ... (elapsed 0.01 seconds) don=
e.
[  146.121637] Freezing remaining freezable tasks ... (elapsed 0.01 seconds=
) done.
[  146.132804] PM: Entering mem sleep
[  146.140388] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[  146.188114] sd 0:0:0:0: [sda] Stopping disk
[  146.569462] PM: suspend of devices complete after 436.593 msecs
[  146.569638] PM: late suspend of devices complete after 0.154 msecs
[  146.570125] ehci_hcd 0000:00:1d.0: wakeup: 1
[  146.570159] ehci_hcd 0000:00:1d.0: wake-up capability enabled by ACPI
[  146.570172] ehci_hcd 0000:00:1d.0: --> PCI D0
[  146.570234] ehci_hcd 0000:00:1a.0: wakeup: 1
[  146.570251] ehci_hcd 0000:00:1a.0: wake-up capability enabled by ACPI
[  146.570288] ehci_hcd 0000:00:1a.0: --> PCI D0
[  146.570399] PM: noirq suspend of devices complete after 0.747 msecs
[  146.571068] ACPI: Preparing to enter system sleep state S3
[  146.588943] ------------[ cut here ]------------
[  146.588995] WARNING: at drivers/gpu/drm/i915/i915_drv.c:398 gen6_gt_chec=
k_fifodbg.isra.5+0x31/0x44 [i915]()
[  146.589010] Hardware name: K53E
[  146.589017] MMIO read or write has been dropped ffffffff
[  146.589026] Modules linked in: aes_x86_64 aes_generic af_packet cpufreq_=
userspace cpufreq_stats cpufreq_powersave cpufreq_ondemand rfcomm bnep uinp=
ut fuse nfsd nfs nfs_acl auth_rpcgss fscache lockd sunrpc ipv6 snd_hda_code=
c_hdmi snd_hda_codec_realtek btusb bluetooth uvcvideo videobuf2_vmalloc snd=
_hda_intel videobuf2_memops snd_hda_codec videobuf2_core videodev snd_hwdep=
 crc16 snd_pcm arc4 snd_page_alloc ath9k snd_seq_midi snd_seq_midi_event sn=
d_rawmidi ath9k_common ath9k_hw ath mac80211 snd_seq acpi_cpufreq mperf fre=
q_table joydev i915 asus_nb_wmi asus_wmi sparse_keymap pci_hotplug i2c_algo=
_bit drm_kms_helper i2c_i801 drm cfg80211 processor evdev battery wmi butto=
n i2c_core intel_agp intel_gtt psmouse video backlight snd_seq_device coret=
emp crc32c_intel ac agpgart snd_timer snd soundcore dm_mod ehci_hcd sr_mod =
cdrom usbcore usb_common atl1c thermal thermal_sys hwmon [last unloaded: sc=
si_wait_scan]
[  146.589261] Pid: 2880, comm: kworker/u:11 Not tainted 3.4.0-rc2-wrar-sab=
ine-8+ #18
[  146.589273] Call Trace:
[  146.589294]  [<ffffffff8102a5e1>] warn_slowpath_common+0x7e/0x96
[  146.589310]  [<ffffffff8102a68d>] warn_slowpath_fmt+0x41/0x43
[  146.589337]  [<ffffffffa02143b7>] gen6_gt_check_fifodbg.isra.5+0x31/0x44=
 [i915]
[  146.589365]  [<ffffffffa021462e>] __gen6_gt_force_wake_put+0x19/0x1b [i9=
15]
[  146.589392]  [<ffffffffa0214884>] i915_read32+0x61/0x82 [i915]
[  146.589433]  [<ffffffffa022e111>] ? intel_disable_plane+0x60/0x60 [i915]
[  146.589462]  [<ffffffffa02167ea>] i915_update_gfx_val+0x61/0xb9 [i915]
[  146.589500]  [<ffffffffa022e156>] intel_idle_update+0x45/0x18b [i915]
[  146.589518]  [<ffffffff810463d1>] ? need_resched+0x1e/0x28
[  146.589551]  [<ffffffffa022e111>] ? intel_disable_plane+0x60/0x60 [i915]
[  146.589569]  [<ffffffff8103c292>] process_one_work+0x13c/0x21e
[  146.589585]  [<ffffffff8103cb93>] worker_thread+0xce/0x152
[  146.589600]  [<ffffffff8103cac5>] ? manage_workers.isra.28+0x16c/0x16c
[  146.589614]  [<ffffffff8103ffab>] kthread+0x86/0x8e
[  146.589629]  [<ffffffff812f2094>] kernel_thread_helper+0x4/0x10
[  146.589644]  [<ffffffff8103ff25>] ? kthread_freezable_should_stop+0x3e/0=
x3e
[  146.589658]  [<ffffffff812f2090>] ? gs_change+0xb/0xb
[  146.589668] ---[ end trace d4f42eb8f9f0177b ]---
[  146.590280] ------------[ cut here ]------------
[  146.590302] WARNING: at drivers/gpu/drm/i915/i915_drv.c:398 gen6_gt_chec=
k_fifodbg.isra.5+0x31/0x44 [i915]()
[  146.590315] Hardware name: K53E
[  146.590322] MMIO read or write has been dropped ffffffff
[  146.590330] Modules linked in: aes_x86_64 aes_generic af_packet cpufreq_=
userspace cpufreq_stats cpufreq_powersave cpufreq_ondemand rfcomm bnep uinp=
ut fuse nfsd nfs nfs_acl auth_rpcgss fscache lockd sunrpc ipv6 snd_hda_code=
c_hdmi snd_hda_codec_realtek btusb bluetooth uvcvideo videobuf2_vmalloc snd=
_hda_intel videobuf2_memops snd_hda_codec videobuf2_core videodev snd_hwdep=
 crc16 snd_pcm arc4 snd_page_alloc ath9k snd_seq_midi snd_seq_midi_event sn=
d_rawmidi ath9k_common ath9k_hw ath mac80211 snd_seq acpi_cpufreq mperf fre=
q_table joydev i915 asus_nb_wmi asus_wmi sparse_keymap pci_hotplug i2c_algo=
_bit drm_kms_helper i2c_i801 drm cfg80211 processor evdev battery wmi butto=
n i2c_core intel_agp intel_gtt psmouse video backlight snd_seq_device coret=
emp crc32c_intel ac agpgart snd_timer snd soundcore dm_mod ehci_hcd sr_mod =
cdrom usbcore usb_common atl1c thermal thermal_sys hwmon [last unloaded: sc=
si_wait_scan]
[  146.590551] Pid: 2880, comm: kworker/u:11 Tainted: G        W    3.4.0-r=
c2-wrar-sabine-8+ #18
[  146.590563] Call Trace:
[  146.590576]  [<ffffffff8102a5e1>] warn_slowpath_common+0x7e/0x96
[  146.590590]  [<ffffffff8102a68d>] warn_slowpath_fmt+0x41/0x43
[  146.590614]  [<ffffffffa02143b7>] gen6_gt_check_fifodbg.isra.5+0x31/0x44=
 [i915]
[  146.590639]  [<ffffffffa021462e>] __gen6_gt_force_wake_put+0x19/0x1b [i9=
15]
[  146.590664]  [<ffffffffa0214884>] i915_read32+0x61/0x82 [i915]
[  146.590696]  [<ffffffffa022e1ae>] intel_idle_update+0x9d/0x18b [i915]
[  146.590728]  [<ffffffffa022e111>] ? intel_disable_plane+0x60/0x60 [i915]
[  146.590744]  [<ffffffff8103c292>] process_one_work+0x13c/0x21e
[  146.590758]  [<ffffffff8103cb93>] worker_thread+0xce/0x152
[  146.590772]  [<ffffffff8103cac5>] ? manage_workers.isra.28+0x16c/0x16c
[  146.590786]  [<ffffffff8103ffab>] kthread+0x86/0x8e
[  146.590797]  [<ffffffff812f2094>] kernel_thread_helper+0x4/0x10
[  146.590810]  [<ffffffff8103ff25>] ? kthread_freezable_should_stop+0x3e/0=
x3e
[  146.590823]  [<ffffffff812f2090>] ? gs_change+0xb/0xb
[  146.590832] ---[ end trace d4f42eb8f9f0177c ]---
[  146.644755] PM: Saving platform NVS memory
[  146.649445] Disabling non-boot CPUs ...
[  146.651233] CPU 1 is now offline
[  146.654012] CPU 2 is now offline
[  146.656592] CPU 3 is now offline
[  146.657317] Extended CMOS year: 2000
[  146.658682] ACPI: Low-level resume complete
[  146.658728] PM: Restoring platform NVS memory
[  146.659118] Extended CMOS year: 2000
[  146.659141] Enabling non-boot CPUs ...
[  146.660262] Booting Node 0 Processor 1 APIC 0x2
[  146.674899] CPU1 is up
[  146.675071] Booting Node 0 Processor 2 APIC 0x1
[  146.689611] CPU2 is up
[  146.689735] Booting Node 0 Processor 3 APIC 0x3
[  146.704075] CPU3 is up
[  146.707254] ACPI: Waking up from system sleep state S3
[  147.297244] ehci_hcd 0000:00:1a.0: wake-up capability disabled by ACPI
[  147.333090] power_supply BAT0: parent PNP0C0A:00 should not be sleeping
[  147.458847] ehci_hcd 0000:00:1d.0: wake-up capability disabled by ACPI
[  147.559435] PM: noirq resume of devices complete after 432.678 msecs
[  147.559694] PM: early resume of devices complete after 0.106 msecs
[  147.559822] i915 0000:00:02.0: setting latency timer to 64
[  147.559840] ehci_hcd 0000:00:1a.0: setting latency timer to 64
[  147.559880] usb usb1: root hub lost power or was reset
[  147.559906] ehci_hcd 0000:00:1a.0: reset command 0080002 (park)=3D0 ithr=
esh=3D8 period=3D1024 Reset HALT
[  147.559930] snd_hda_intel 0000:00:1b.0: irq 45 for MSI/MSI-X
[  147.560048] ehci_hcd 0000:00:1d.0: setting latency timer to 64
[  147.560054] ahci 0000:00:1f.2: setting latency timer to 64
[  147.560071] usb usb2: root hub lost power or was reset
[  147.560085] ehci_hcd 0000:00:1d.0: reset command 0080002 (park)=3D0 ithr=
esh=3D8 period=3D1024 Reset HALT
[  147.563800] ehci_hcd 0000:00:1a.0: cache line size of 64 is not supported
[  147.563820] usb usb1: usb resume
[  147.563828] ehci_hcd 0000:00:1a.0: resume root hub after power loss
[  147.564282] ehci_hcd 0000:00:1d.0: cache line size of 64 is not supported
[  147.564819] usb usb2: usb resume
[  147.564826] ehci_hcd 0000:00:1d.0: resume root hub after power loss
[  147.583553] hub 1-0:1.0: hub_reset_resume
[  147.583559] hub 1-0:1.0: trying to enable port power on non-switchable h=
ub
[  147.584563] hub 2-0:1.0: hub_reset_resume
[  147.584572] hub 2-0:1.0: trying to enable port power on non-switchable h=
ub
[  147.641086] [drm] Enabling RC6 states: RC6 on, RC6p off, RC6pp off
[  147.650114] atl1c 0000:03:00.0: irq 46 for MSI/MSI-X
[  147.684584] ehci_hcd 0000:00:1a.0: GetStatus port:1 status 001803 0  ACK=
 POWER sig=3Dj CSC CONNECT
[  147.684602] hub 1-0:1.0: port 1: status 0501 change 0001
[  147.685571] ehci_hcd 0000:00:1d.0: GetStatus port:1 status 001803 0  ACK=
 POWER sig=3Dj CSC CONNECT
[  147.685583] hub 2-0:1.0: port 1: status 0501 change 0001
[  147.785577] usb 1-1: finish reset-resume
[  147.786555] usb 2-1: finish reset-resume
[  147.836698] ehci_hcd 0000:00:1a.0: port 1 high speed
[  147.836714] ehci_hcd 0000:00:1a.0: GetStatus port:1 status 001005 0  ACK=
 POWER sig=3Dse0 PE CONNECT
[  147.875482] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  147.877791] ata3.00: ACPI cmd ef/10:06:00:00:00:a0 (SET FEATURES) succee=
ded
[  147.877811] ata3.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) filter=
ed out
[  147.881892] ata3.00: ACPI cmd ef/10:06:00:00:00:a0 (SET FEATURES) succee=
ded
[  147.881912] ata3.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) filter=
ed out
[  147.883449] ata3.00: configured for UDMA/100
[  147.887485] usb 1-1: reset high-speed USB device number 2 using ehci_hcd
[  147.938648] ehci_hcd 0000:00:1a.0: port 1 high speed
[  147.938664] ehci_hcd 0000:00:1a.0: GetStatus port:1 status 001005 0  ACK=
 POWER sig=3Dse0 PE CONNECT
[  148.001587] ehci_hcd 0000:00:1a.0: set dev address 2 for port 1
[  148.001598] ehci_hcd 0000:00:1a.0: LPM: no device attached
[  148.002062] hub 1-1:1.0: hub_reset_resume
[  148.002071] hub 1-1:1.0: enabling power on all ports
[  148.052711] ehci_hcd 0000:00:1d.0: port 1 high speed
[  148.052727] ehci_hcd 0000:00:1d.0: GetStatus port:1 status 001005 0  ACK=
 POWER sig=3Dse0 PE CONNECT
[  148.103404] usb 2-1: reset high-speed USB device number 2 using ehci_hcd
[  148.104514] hub 1-1:1.0: port 1: status 0101 change 0001
[  148.104888] hub 1-1:1.0: port 2: status 0101 change 0001
[  148.160530] ehci_hcd 0000:00:1d.0: port 1 high speed
[  148.160546] ehci_hcd 0000:00:1d.0: GetStatus port:1 status 001005 0  ACK=
 POWER sig=3Dse0 PE CONNECT
[  148.206372] usb 1-1: link qh256-0001/ffff88013a93ed00 start 3 [1/0 us]
[  148.206557] usb 1-1.2: finish reset-resume
[  148.206858] usb 1-1.1: finish reset-resume
[  148.223468] ehci_hcd 0000:00:1d.0: set dev address 2 for port 1
[  148.223480] ehci_hcd 0000:00:1d.0: LPM: no device attached
[  148.224226] hub 2-1:1.0: hub_reset_resume
[  148.224235] hub 2-1:1.0: enabling power on all ports
[  148.234465] hub 1-1:1.0: port 2 not reset yet, waiting 10ms
[  148.296583] usb 1-1.2: reset high-speed USB device number 4 using ehci_h=
cd
[  148.325925] hub 2-1:1.0: port 3: status 0101 change 0001
[  148.388528] hub 1-1:1.0: port 1 not reset yet, waiting 10ms
[  148.427243] usb 2-1: link qh256-0001/ffff88013a93e400 start 2 [1/0 us]
[  148.450517] usb 1-1.1: reset full-speed USB device number 3 using ehci_h=
cd
[  148.467506] hub 1-1:1.0: port 1 not reset yet, waiting 10ms
[  149.457684] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  149.465889] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK=
) filtered out
[  149.472303] ata1.00: ACPI cmd ef/10:06:00:00:00:a0 (SET FEATURES) succee=
ded
[  149.472312] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) filter=
ed out
[  149.482789] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK=
) filtered out
[  149.489164] ata1.00: ACPI cmd ef/10:06:00:00:00:a0 (SET FEATURES) succee=
ded
[  149.489176] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) filter=
ed out
[  149.496961] ata1.00: configured for UDMA/133
[  149.502899] sd 0:0:0:0: [sda] Starting disk
[  149.559598] PM: resume of devices complete after 2000.913 msecs
[  149.619233] PM: Finishing wakeup.
[  149.619241] Restarting tasks ...=20
[  149.619442] hub 1-0:1.0: state 7 ports 2 chg 0002 evt 0000
[  149.624455] done.
[  149.632672] hub 1-0:1.0: port 1, status 0503, change 0000, 480 Mb/s
[  149.632686] hub 2-0:1.0: state 7 ports 2 chg 0002 evt 0000
[  149.632699] hub 2-0:1.0: port 1, status 0503, change 0000, 480 Mb/s
[  149.632707] hub 1-1:1.0: state 7 ports 6 chg 0006 evt 0004
[  149.632817] hub 1-1:1.0: port 1, status 0103, change 0000, 12 Mb/s
[  149.632960] hub 1-1:1.0: port 2, status 0503, change 0000, 480 Mb/s
[  149.632974] hub 2-1:1.0: state 7 ports 6 chg 0008 evt 0000
[  149.633205] hub 2-1:1.0: port 3, status 0101, change 0000, 12 Mb/s
[  149.643682] hub 2-1:1.0: port 3 not reset yet, waiting 10ms
[  149.705688] usb 2-1.3: new high-speed USB device number 3 using ehci_hcd
[  149.720119] video LNXVIDEO:01: Restoring backlight state
[  149.790209] usb 2-1.3: default language 0x0409
[  149.790751] usb 2-1.3: udev 3, busnum 2, minor =3D 130
[  149.790761] usb 2-1.3: New USB device found, idVendor=3D04e8, idProduct=
=3D5133
[  149.790907] usb 2-1.3: New USB device strings: Mfr=3D1, Product=3D2, Ser=
ialNumber=3D5
[  149.791051] usb 2-1.3: Product: YP-U6
[  149.791127] usb 2-1.3: Manufacturer: Samsung Electronics
[  149.791234] usb 2-1.3: SerialNumber: 38F5000001B1241C0002DCE4D908E41C
[  149.791902] usb 2-1.3: usb_probe_device
[  149.791911] usb 2-1.3: configuration #1 chosen from 2 choices
[  149.792207] usb 2-1.3: adding 2-1.3:1.0 (config #1, interface 0)
[  149.925318] uas 2-1.3:1.0: usb_probe_interface
[  149.925328] uas 2-1.3:1.0: usb_probe_interface - got id
[  149.925422] usbcore: registered new interface driver uas
[  149.936863] libusual 2-1.3:1.0: usb_probe_interface
[  149.936877] libusual 2-1.3:1.0: usb_probe_interface - got id
[  149.936996] usbcore: registered new interface driver libusual
[  149.958603] Initializing USB Mass Storage driver...
[  149.958802] usb-storage 2-1.3:1.0: usb_probe_interface
[  149.958816] usb-storage 2-1.3:1.0: usb_probe_interface - got id
[  149.958931] scsi6 : usb-storage 2-1.3:1.0
[  149.959189] usbcore: registered new interface driver usb-storage
[  149.959309] USB Mass Storage support registered.
[  150.962927] scsi 6:0:0:0: Direct-Access     Samsung  YP-U6            01=
00 PQ: 0 ANSI: 4
[  150.965186] sd 6:0:0:0: [sdb] 1889152 2048-byte logical blocks: (3.86 GB=
/3.60 GiB)
[  150.966136] sd 6:0:0:0: [sdb] Write Protect is off
[  150.966271] sd 6:0:0:0: [sdb] Mode Sense: 3e 00 00 00
[  150.966875] sd 6:0:0:0: [sdb] No Caching mode page present
[  150.967020] sd 6:0:0:0: [sdb] Assuming drive cache: write through
[  150.968497] sd 6:0:0:0: [sdb] 1889152 2048-byte logical blocks: (3.86 GB=
/3.60 GiB)
[  150.969732] sd 6:0:0:0: [sdb] No Caching mode page present
[  150.969897] sd 6:0:0:0: [sdb] Assuming drive cache: write through
[  150.972374]  sdb: sdb1
[  150.974025] sd 6:0:0:0: [sdb] 1889152 2048-byte logical blocks: (3.86 GB=
/3.60 GiB)
[  150.975232] sd 6:0:0:0: [sdb] No Caching mode page present
[  150.979258] sd 6:0:0:0: [sdb] Assuming drive cache: write through
[  150.983262] sd 6:0:0:0: [sdb] Attached SCSI removable disk
[  150.994014] usb 1-1.1: usb auto-suspend, wakeup 0
[  150.994027] usb 1-1.2: usb auto-suspend, wakeup 0
[  153.003869] hub 1-1:1.0: hub_suspend
[  153.003893] usb 1-1: unlink qh256-0001/ffff88013a93ed00 start 3 [1/0 us]
[  153.004042] usb 1-1: usb auto-suspend, wakeup 1
[  155.013849] hub 1-0:1.0: hub_suspend
[  155.013870] usb usb1: bus auto-suspend, wakeup 1
[  155.013877] ehci_hcd 0000:00:1a.0: suspend root hub

--4JxvUTD846AMAZAS--

--wwSkEpePV3aFlXly
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJPkIhIAAoJEDNi9wMaSZLhs7YP/3ziF0dTbmuRX4kuxCk/vxfY
vF//VhQnRNFK1dJJ+VVUhoSfulodZk/m57ytltNp8dKuu5Dq6InOp0dzEm5/Z9YK
vu5vKdSOZ142W/JVJjhLYe8gV33JQWr7a3+3doag+iWbeI26Ax0mIuSAKJvAC2rc
H5fHXurpNOF6ELq+wsrx0RYZGkstOG6EhnybLA7TPHpJstUeDbA7sCe5/rpkvUVG
94DXAfasevTtmBdUYojx7CJ4YQrdMBjtxhU3v99fKbWpEMXxm6puaiQqsZdZdoFw
s4FCKbjv9qFsYnvy7gioHZ59reaixYXpHmYQS72c73QtK2N13Rn0onnkpGp/2PE3
bLBgYrId6EamHHOqP3UMKPjPkNJxdlKu3kq46TSuziEy3hyAof7/UlFKjCtM6hWw
p5r0nxwZOeV9CX0/CjbuikfvwfR+s61XblBfAU3eqZWhY/pwY00d9HlKeWY7gG5U
bTvOI+h1aVv1q9AZkIcCo501DPULQahqskopYQM8lsJ4TUFfyCYcdWZnTNWtgLSw
tOxw+X2TkYQ///dKpgLD2Q26pvBrKJeWfg6iZpYCAM2M3KB1au/9GPnVpmi7iVG9
Pmj9y/Iq4/iwhOENK1uggIrJ5NRzvoHSXRe5GxlPJkRKeNpXwh0JJMVmHw4DCXg0
z8XQO9+sWh4smw93QCf0
=SDXn
-----END PGP SIGNATURE-----

--wwSkEpePV3aFlXly--

--===============0169084111064128144==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0169084111064128144==--
