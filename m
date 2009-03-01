From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: Very rare resume bug
Date: Sun, 01 Mar 2009 15:17:30 +0200
Message-ID: <1235913450.9793.0.camel@localhost>
References: <1235912755.7665.4.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1235912755.7665.4.camel@localhost>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sun, 2009-03-01 at 15:05 +0200, Maxim Levitsky wrote:
> I currently am testing suspend/resume on my desktop system.
> I already kept it in suspend to ram state in 2 weeks, and now
> I resumed it, and screen didn't came back, I tried switching vts
> it did seem to help, but then everything hung.
> 
> I got this in logs:
> 
> 
> 
> > Feb 27 21:45:12 MAIN kernel: [47277.954656] WARNING: at /build/buildd/linux-2.6.27/kernel/power/main.c:176 suspend_test_finish+0x74/0x80()
> > Feb 27 21:45:12 MAIN kernel: [47277.954658] Modules linked in: videodev v4l1_compat af_packet binfmt_misc ipv6 nfsd auth_rpcgss exportfs ppdev video output battery container wmi sbs pci_slot sbshc nfs lockd nfs_acl sunrpc iptable_filter ip_tables x_tables ext2 mbcache vfat fat ac kvm_intel kvm i2c_dev snd_virmidi snd_seq_virmidi coretemp cpufreq_ondemand cpufreq_powersave cpufreq_userspace acpi_cpufreq freq_table sbp2 eeprom lp snd_hda_intel snd_seq_dummy snd_seq_oss snd_seq_midi nvidia(P) snd_pcm_oss joydev snd_mixer_oss snd_rawmidi snd_pcm parport_pc snd_seq_midi_event snd_seq psmouse intel_agp shpchp evdev iTCO_wdt serio_raw pci_hotplug i2c_i801 parport button iTCO_vendor_support agpgart snd_timer snd_seq_device snd soundcore i2c_core snd_page_alloc heci reiserfs sd_mod crc_t10dif s
 r_mod cdrom sg usbhid hid ata_piix pata_marvell ata_generic ohci1394 pata_acpi ieee1394 libata scsi_mod dock uhci_hcd ehci_hcd usbcore e1000e dm_mirror dm_log dm_snapshot dm_mod thermal pro!
 cessor fan fuse vesafb fbcon tileblit f
> > Feb 27 21:45:12 MAIN kernel: nt bitblit softcursor [last unloaded: microcode]
> > Feb 27 21:45:12 MAIN kernel: [47277.954720] Pid: 27868, comm: pm-suspend Tainted: P        W 2.6.27-11-generic #1
> > Feb 27 21:45:12 MAIN kernel: [47277.954722]  [<c037d236>] ? printk+0x1d/0x1f
> > Feb 27 21:45:12 MAIN kernel: [47277.954726]  [<c0131e99>] warn_on_slowpath+0x59/0x90
> > Feb 27 21:45:12 MAIN kernel: [47277.954730]  [<c014d305>] ? sched_clock_cpu+0xd5/0x170
> > Feb 27 21:45:12 MAIN kernel: [47277.954734]  [<c014c15f>] ? down_trylock+0x2f/0x40
> > Feb 27 21:45:12 MAIN kernel: [47277.954737]  [<c0132572>] ? try_acquire_console_sem+0x12/0x40
> > Feb 27 21:45:12 MAIN kernel: [47277.954740]  [<c024ed00>] ? kobject_put+0x20/0x50
> > Feb 27 21:45:12 MAIN kernel: [47277.954744]  [<c015d2b4>] suspend_test_finish+0x74/0x80
> > Feb 27 21:45:12 MAIN kernel: [47277.954747]  [<c015d3a6>] suspend_devices_and_enter+0xe6/0x190
> > Feb 27 21:45:12 MAIN kernel: [47277.954750]  [<c015d621>] enter_state+0xd1/0x100
> > Feb 27 21:45:12 MAIN kernel: [47277.954752]  [<c015d6d5>] state_store+0x85/0xd0
> > Feb 27 21:45:12 MAIN kernel: [47277.954754]  [<c015d650>] ? state_store+0x0/0xd0
> > Feb 27 21:45:12 MAIN kernel: [47277.954757]  [<c024ebc4>] kobj_attr_store+0x24/0x30
> > Feb 27 21:45:12 MAIN kernel: [47277.954759]  [<c01ffac7>] sysfs_write_file+0x97/0x100
> > Feb 27 21:45:12 MAIN kernel: [47277.954763]  [<c01b2760>] vfs_write+0xa0/0x110
> > Feb 27 21:45:12 MAIN kernel: [47277.954765]  [<c01ffa30>] ? sysfs_write_file+0x0/0x100
> > Feb 27 21:45:12 MAIN kernel: [47277.954768]  [<c01b28a2>] sys_write+0x42/0x70
> > Feb 27 21:45:12 MAIN kernel: [47277.954771]  [<c0103f7b>] sysenter_do_call+0x12/0x2f
> > Feb 27 21:45:12 MAIN kernel: [47277.954774]  [<c0370000>] ? enable_nonboot_cpus+0x60/0xc0
> > Feb 27 21:45:12 MAIN kernel: [47277.954777]  =======================
> > Feb 27 21:45:12 MAIN kernel: [47277.954779] ---[ end trace f9ae6cac97d5cf9f ]---
> 
> 
> I have nvidia driver loaded - otherwise nothing suspends.
> 
> Best regards,
> 	Maxim Levitsky
> 


Actually above warning is unrelated, at least I now get it on each
resume, but system works.


Best regards,
	Maxim Levitsky
