From: Hugo Mills <hugo@carfax.org.uk>
Subject: Suspend fails to resume
Date: Sat, 27 Jun 2015 12:26:00 +0000
Message-ID: <20150627122600.GH16065@carfax.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PNpeiK4tTqhYOExY"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from frost.carfax.org.uk ([85.119.82.111]:36247 "EHLO
	frost.carfax.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751502AbbF0Myl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 27 Jun 2015 08:54:41 -0400
Received: from hrm by frost.carfax.org.uk with local (Exim 4.80)
	(envelope-from <hrm@carfax.org.uk>)
	id 1Z8pBI-0006FX-Q5
	for linux-pm@vger.kernel.org; Sat, 27 Jun 2015 12:26:00 +0000
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org


--PNpeiK4tTqhYOExY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

   I'm trying to get my desktop to suspend to RAM. This it does, but
when I try to wake it again, the power returns (fans start going
again) but the machine otherwise remains unresponsive: no display, no
network, keyboard lights don't toggle. Holding the power button to
shut the machine down works, but it returns to the same broken state
after switching it back on. The reset button will reboot normally.

   I've done some minimal debugging with /sys/power/pm_trace, and have
found the following output in dmesg after a failed suspend:

Apr 22 13:09:50 damon kernel: [    0.865323]   Magic number: 0:528:178
Apr 22 13:09:50 damon kernel: [    0.865325]   hash matches drivers/base/power/main.c:1063
Apr 22 13:09:50 damon kernel: [    0.865367] acpi device:0e: hash matches
Apr 22 13:09:50 damon kernel: [    0.865388]  platform: hash matches
Apr 22 13:09:50 damon kernel: [    0.865452] rtc_cmos 00:08: setting system clock to 2004-04-22 12:09:39 UTC (1082635779)

   I have also tried using /sys/power/pm_test. Using "freeze"
apparently worked successfully. Using "devices" gave this:

Jun 27 13:12:59 damon kernel: [ 2138.839223] PM: Syncing filesystems ... done.
Jun 27 13:12:59 damon kernel: [ 2138.860346] PM: Preparing system for mem sleep
Jun 27 13:12:59 damon kernel: [ 2138.860557] Freezing user space processes ... (elapsed 0.001 seconds) done.
Jun 27 13:12:59 damon kernel: [ 2138.862322] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
Jun 27 13:12:59 damon kernel: [ 2138.863729] PM: Entering mem sleep
Jun 27 13:12:59 damon kernel: [ 2138.863757] Suspending console(s) (use no_console_suspend to debug)
Jun 27 13:12:59 damon kernel: [ 2138.864608] sd 0:0:0:0: [sda] Synchronizing SCSI cache
Jun 27 13:12:59 damon kernel: [ 2138.864847] sd 0:0:0:0: [sda] Stopping disk
Jun 27 13:12:59 damon kernel: [ 2138.868264] serial 00:05: disabled
Jun 27 13:12:59 damon kernel: [ 2138.868299] i8042 kbd 00:04: System wakeup enabled by ACPI
Jun 27 13:12:59 damon kernel: [ 2139.459770] PM: suspend of devices complete after 595.864 msecs
Jun 27 13:12:59 damon kernel: [ 2139.459772] suspend debug: Waiting for 5 second(s).
Jun 27 13:12:59 damon kernel: [ 2144.419881] i8042 kbd 00:04: System wakeup disabled by ACPI
Jun 27 13:12:59 damon kernel: [ 2144.420904] serial 00:05: activated
Jun 27 13:12:59 damon kernel: [ 2144.420911] rtc_cmos 00:08: System wakeup disabled by ACPI
Jun 27 13:12:59 damon kernel: [ 2144.426382] sd 0:0:0:0: [sda] Starting disk
Jun 27 13:12:59 damon kernel: [ 2144.432169] r8169 0000:01:00.0 eth0: link down
Jun 27 13:12:59 damon kernel: [ 2144.448101] [drm] PCIE GART of 1024M enabled (table at 0x000000000078C000).
Jun 27 13:12:59 damon kernel: [ 2144.448240] radeon 0000:00:01.0: WB enabled
Jun 27 13:12:59 damon kernel: [ 2144.448246] radeon 0000:00:01.0: fence driver on ring 0 use gpu addr 0x0000000040000c00 and cpu addr 0xffff88042badbc00
Jun 27 13:12:59 damon kernel: [ 2144.448249] radeon 0000:00:01.0: fence driver on ring 1 use gpu addr 0x0000000040000c04 and cpu addr 0xffff88042badbc04
Jun 27 13:12:59 damon kernel: [ 2144.448251] radeon 0000:00:01.0: fence driver on ring 2 use gpu addr 0x0000000040000c08 and cpu addr 0xffff88042badbc08
Jun 27 13:12:59 damon kernel: [ 2144.448253] radeon 0000:00:01.0: fence driver on ring 3 use gpu addr 0x0000000040000c0c and cpu addr 0xffff88042badbc0c
Jun 27 13:12:59 damon kernel: [ 2144.448255] radeon 0000:00:01.0: fence driver on ring 4 use gpu addr 0x0000000040000c10 and cpu addr 0xffff88042badbc10
Jun 27 13:12:59 damon kernel: [ 2144.448650] radeon 0000:00:01.0: fence driver on ring 5 use gpu addr 0x0000000000076c98 and cpu addr 0xffffc90002036c98
Jun 27 13:12:59 damon kernel: [ 2144.448732] radeon 0000:00:01.0: fence driver on ring 6 use gpu addr 0x0000000040000c18 and cpu addr 0xffff88042badbc18
Jun 27 13:12:59 damon kernel: [ 2144.448734] radeon 0000:00:01.0: fence driver on ring 7 use gpu addr 0x0000000040000c1c and cpu addr 0xffff88042badbc1c
Jun 27 13:12:59 damon kernel: [ 2144.450670] [drm] ring test on 0 succeeded in 2 usecs
Jun 27 13:12:59 damon kernel: [ 2144.603679] [drm:cik_ring_test [radeon]] *ERROR* radeon: ring 1 test failed (scratch(0x3010C)=0xCAFEDEAD)
Jun 27 13:12:59 damon kernel: [ 2144.665747] usb 7-1: reset full-speed USB device number 2 using ohci-pci
Jun 27 13:12:59 damon kernel: [ 2144.745757] ata6: SATA link down (SStatus 0 SControl 300)
Jun 27 13:12:59 damon kernel: [ 2144.745785] ata8: SATA link down (SStatus 0 SControl 300)
Jun 27 13:12:59 damon kernel: [ 2144.745808] ata3: SATA link down (SStatus 0 SControl 300)
Jun 27 13:12:59 damon kernel: [ 2144.745831] ata7: SATA link down (SStatus 0 SControl 300)
Jun 27 13:12:59 damon kernel: [ 2144.745871] ata4: SATA link down (SStatus 0 SControl 300)
Jun 27 13:12:59 damon kernel: [ 2144.749763] ata5: SATA link down (SStatus 0 SControl 300)
Jun 27 13:12:59 damon kernel: [ 2144.755492] [drm:cik_ring_test [radeon]] *ERROR* radeon: ring 2 test failed (scratch(0x3010C)=0xCAFEDEAD)
Jun 27 13:12:59 damon kernel: [ 2144.755640] [drm] ring test on 3 succeeded in 3 usecs
Jun 27 13:12:59 damon kernel: [ 2144.755645] [drm] ring test on 4 succeeded in 3 usecs
Jun 27 13:12:59 damon kernel: [ 2144.801304] [drm] ring test on 5 succeeded in 1 usecs
Jun 27 13:12:59 damon kernel: [ 2144.821156] [drm] UVD initialized successfully.
Jun 27 13:12:59 damon kernel: [ 2144.913688] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Jun 27 13:12:59 damon kernel: [ 2144.917655] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
Jun 27 13:12:59 damon kernel: [ 2144.919702] ata1.00: supports DRM functions and may not be fully accessible
Jun 27 13:12:59 damon kernel: [ 2144.919753] ata1.00: failed to get NCQ Send/Recv Log Emask 0x1
Jun 27 13:12:59 damon kernel: [ 2144.919918] ata1.00: supports DRM functions and may not be fully accessible
Jun 27 13:12:59 damon kernel: [ 2144.919965] ata1.00: failed to get NCQ Send/Recv Log Emask 0x1
Jun 27 13:12:59 damon kernel: [ 2144.919968] ata1.00: configured for UDMA/133
Jun 27 13:12:59 damon kernel: [ 2144.921400] ata2.00: configured for UDMA/100
Jun 27 13:12:59 damon kernel: [ 2144.921528] [drm] ring test on 6 succeeded in 691 usecs
Jun 27 13:12:59 damon kernel: [ 2144.921538] [drm] ring test on 7 succeeded in 4 usecs
Jun 27 13:12:59 damon kernel: [ 2144.921539] [drm] VCE initialized successfully.
Jun 27 13:12:59 damon kernel: [ 2144.921566] [drm] ib test on ring 0 succeeded in 0 usecs
Jun 27 13:12:59 damon kernel: [ 2144.921625] [drm] ib test on ring 3 succeeded in 0 usecs
Jun 27 13:12:59 damon kernel: [ 2144.921663] [drm] ib test on ring 4 succeeded in 0 usecs
Jun 27 13:12:59 damon kernel: [ 2145.437715] [drm] ib test on ring 5 succeeded
Jun 27 13:12:59 damon kernel: [ 2145.458236] [drm] ib test on ring 6 succeeded
Jun 27 13:12:59 damon kernel: [ 2145.458769] [drm] ib test on ring 7 succeeded
Jun 27 13:12:59 damon kernel: [ 2145.603271] PM: resume of devices complete after 1184.323 msecs
Jun 27 13:12:59 damon kernel: [ 2145.603691] PM: Finishing wakeup.
Jun 27 13:12:59 damon kernel: [ 2145.603694] Restarting tasks ... done.
Jun 27 13:12:59 damon kernel: [ 2145.605913] video LNXVIDEO:00: Restoring backlight state

   A second subsequent attempt with "devices" resulted in a futher
failure in Radeon:

Jun 27 13:13:42 damon kernel: [ 2188.390538] [drm:cik_sdma_ring_test [radeon]] *ERROR* radeon: ring 4 test failed (0xCAFEDEAD)
Jun 27 13:13:42 damon kernel: [ 2188.390556] [drm:cik_resume [radeon]] *ERROR* cik startup failed on resume

followed by hundreds of these:

Jun 27 13:13:42 damon kernel: [ 2188.582376] ------------[ cut here ]------------
Jun 27 13:13:42 damon kernel: [ 2188.582409] WARNING: CPU: 1 PID: 1130 at drivers/gpu/drm/radeon/radeon_object.c:84 radeon_ttm_bo_destroy+0xf1/0x100 [radeon]()
Jun 27 13:13:42 damon kernel: [ 2188.582411] Modules linked in: nfsv3 nfsd nfs_acl rpcsec_gss_krb5 auth_rpcgss oid_registry nfsv4 dns_resolver nfs lockd grace sunrpc fscache nbd xfs libcrc32c kvm_amd kvm crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel aes_x86_64 lrw gf128mul glue_helper snd_hda_codec_realtek ablk_helper cryptd snd_hda_codec_generic evdev fam15h_power k10temp radeon edac_core drm_kms_helper snd_hda_intel ttm snd_hda_controller snd_hda_codec snd_hwdep drm tpm_infineon snd_hda_core tpm_tis i2c_algo_bit snd_pcm acpi_cpufreq i2c_core tpm video snd_timer processor button snd soundcore thermal_sys shpchp fuse autofs4 btrfs xor hid_generic usbhid hid raid6_pq dm_mod sg sr_mod cdrom sd_mod ohci_pci crc32c_intel ahci xhci_pci libahci ehci_pci ohci_hcd xhci_hcd ehci_hcd
  libata usbcore scsi_mod r8169 usb_common mii
Jun 27 13:13:42 damon kernel: [ 2188.582465] CPU: 1 PID: 1130 Comm: Xorg Not tainted 4.1.0+ #8
Jun 27 13:13:42 damon kernel: [ 2188.582467] Hardware name: Gigabyte Technology Co., Ltd. To be filled by O.E.M./F2A88XM-D3H, BIOS F5 01/09/2014
Jun 27 13:13:42 damon kernel: [ 2188.582469]  0000000000000000 ffffffffa05cc380 ffffffff814817bb 0000000000000000
Jun 27 13:13:42 damon kernel: [ 2188.582472]  ffffffff81042661 ffff8803eedc2468 ffff8803eedc2400 ffffffffffffffff
Jun 27 13:13:42 damon kernel: [ 2188.582475]  ffff88042afe0000 ffff88041af5d440 ffffffffa04bbd71 ffff88042afe0720
Jun 27 13:13:42 damon kernel: [ 2188.582478] Call Trace:
Jun 27 13:13:42 damon kernel: [ 2188.582488]  [<ffffffff814817bb>] ? dump_stack+0x40/0x50
Jun 27 13:13:42 damon kernel: [ 2188.582492]  [<ffffffff81042661>] ? warn_slowpath_common+0x81/0xb0
Jun 27 13:13:42 damon kernel: [ 2188.582506]  [<ffffffffa04bbd71>] ? radeon_ttm_bo_destroy+0xf1/0x100 [radeon]
Jun 27 13:13:42 damon kernel: [ 2188.582512]  [<ffffffffa044a3ad>] ? ttm_bo_release_list+0x9d/0x180 [ttm]
Jun 27 13:13:42 damon kernel: [ 2188.582524]  [<ffffffffa04bc2e8>] ? radeon_bo_unref+0x28/0x50 [radeon]
Jun 27 13:13:42 damon kernel: [ 2188.582538]  [<ffffffffa04d0f8a>] ? radeon_gem_object_free+0x3a/0x40 [radeon]
Jun 27 13:13:42 damon kernel: [ 2188.582547]  [<ffffffffa03ba7d8>] ? drm_gem_object_handle_unreference_unlocked+0x118/0x120 [drm]
Jun 27 13:13:42 damon kernel: [ 2188.582553]  [<ffffffffa03ba87a>] ? drm_gem_handle_delete+0x9a/0xe0 [drm]
Jun 27 13:13:42 damon kernel: [ 2188.582559]  [<ffffffffa03bb712>] ? drm_ioctl+0x172/0x5c0 [drm]
Jun 27 13:13:42 damon kernel: [ 2188.582564]  [<ffffffff81050c15>] ? __set_current_blocked+0x35/0x50
Jun 27 13:13:42 damon kernel: [ 2188.582573]  [<ffffffffa049c04a>] ? radeon_drm_ioctl+0x4a/0x80 [radeon]
Jun 27 13:13:42 damon kernel: [ 2188.582577]  [<ffffffff81199e38>] ? do_vfs_ioctl+0x2e8/0x4f0
Jun 27 13:13:42 damon kernel: [ 2188.582581]  [<ffffffff81034e8b>] ? __do_page_fault+0x17b/0x3e0
Jun 27 13:13:42 damon kernel: [ 2188.582583]  [<ffffffff8119a07b>] ? SyS_ioctl+0x3b/0x80
Jun 27 13:13:42 damon kernel: [ 2188.582587]  [<ffffffff8148699b>] ? system_call_fastpath+0x16/0x6e
Jun 27 13:13:42 damon kernel: [ 2188.582589] ---[ end trace 79d65ca9618ebe16 ]---

   After this, X died and restarted, and I seem to have lost most of
the "higher functions" of the video hardware (e.g. second display,
xrandr). I'm not sure where to go from this point, other than shouting
"help!", so I'm doing that here.

   Can anyone offer any suggestions?

   Thanks,
   Hugo.

-- 
Hugo Mills             | UNIX: British manufacturer of modular shelving units
hugo@... carfax.org.uk |
http://carfax.org.uk/  |
PGP: E2AB1DE4          |

--PNpeiK4tTqhYOExY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJVjpZYAAoJEFheFHXiqx3k5IcP/RPcaDtByh/pkV5/VX0VNeIl
SU+WFd/rsRF9pFW7w9vK2E2e6yMF2/kXhB8oVMtOevIAd1+WjgHFTpoNhVwaFpXu
BGOOD85unbpXLR/biBzMpcPq81y5m6fBGm7nYpYno+U4RSpXxgLGTQBpxx+AFrJS
2F4uv3ek7UzkFSUI1xRO0b8jdY19JhHoR0B6a8lz+QsLrJVXFcY9QrrZh6/gc4SY
PlbQJp7ecdKV7fA8jjkxUvGv1y3+sZhJsLaPFc7BBHVWb2Bb3TvNUxBtwIN8vo8c
4czXv4a/+4esIpXWQmiFJenks/dORe2h313mK+9HKIOjpGfXTBQ+jOeDrfNYlfEO
5SxQzbQ30OW1RkJQfN+MfzbDUfYHch2K/oGF+Tk+i+6Wa2YZgI4tkNqWrH1ic/FP
EOusXNNMkHLh/boOg0ip2bjLAJJIC41nQHVG536DB7+l57TqxnhjKyS6o1uK8BXP
l5EK8Jtonote4xQr+Q7sEjHLm5i15Op8Nk/6aN8zD2LyTImn1HR6RPov8eebUT5o
rVxUfy/gJKegqZSERXcXJvBTYEPPxuvS5ploa6lg1RK68mOlOUbxyJXbD6/al5Kx
PvQVdoAWJLYL/S1j7sflD6yfuWLXF0u8JTLXJe6gQ47FlmfauN5LseOTbb318qDg
4NQ7FzYeS18ji6+GF0bm
=QFHd
-----END PGP SIGNATURE-----

--PNpeiK4tTqhYOExY--
