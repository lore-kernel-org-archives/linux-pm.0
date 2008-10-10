From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: WARNING: at kernel/power/main.c:176
	suspend_test_finish+0x70/0x80()
Date: Fri, 10 Oct 2008 14:52:27 +0200
Message-ID: <200810101452.27929.rjw__27218.616862274$1223643590$gmane$org@sisk.pl>
References: <f7848160810091814o516a9129nf6176efba67f316e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <f7848160810091814o516a9129nf6176efba67f316e@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Parag Warudkar <parag.lkml@gmail.com>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Friday, 10 of October 2008, Parag Warudkar wrote:
> 2.6.27 seems to be taking long time to resume, it hits this WARN_ON in
> kernel/power/main.c:176 suspend_test_finish -
> Never seen earlier.

Resuming devices takes too much time (more than 5 sec. actually)
and the stack trace indicates USB.

Can you test with the USB modules unloaded?


> [  295.600086] PM: resume devices took 10.180 seconds
> [  295.600091] ------------[ cut here ]------------
> [  295.600092] WARNING: at kernel/power/main.c:176
> suspend_test_finish+0x70/0x80()
> [  295.600094] Modules linked in: i2c_i801 i2c_core nls_iso8859_1
> nls_cp437 vfat fat isofs udf af_packet binfmt_misc ipv6 sco bnep
> rfcomm l2cap bluetooth ipt_MASQUERADE iptable_nat nf_nat
> nf_conntrack_ipv4 xt_state nf_conntrack ipt_REJECT xt_tcpudp bridge
> stp llc kvm_intel kvm ppdev acpi_cpufreq cpufreq_conservative
> cpufreq_ondemand cpufreq_stats freq_table cpufreq_userspace
> cpufreq_powersave wmi video output pci_slot container battery
> iptable_filter ip_tables x_tables ac firewire_sbp2 lp snd_hda_intel
> snd_pcm_oss snd_mixer_oss snd_pcm snd_seq_dummy snd_seq_oss
> snd_seq_midi serio_raw snd_rawmidi evdev dm_multipath psmouse pcspkr
> scsi_dh snd_seq_midi_event snd_seq snd_timer snd_seq_device
> appledisplay snd parport_serial parport_pc soundcore parport shpchp
> snd_page_alloc pci_hotplug button iTCO_wdt iTCO_vendor_support
> intel_agp sd_mod sr_mod crc_t10dif cdrom usb_storage usbhid libusual
> hid sg firewire_ohci firewire_core crc_itu_t ahci libata scsi_mod dock
> ehci_hcd uhci_hcd usbcore e1000e dm_mirror dm_log dm_snapshot dm_mod
> thermal processor fan fuse
> [  295.600141] Pid: 7470, comm: pm-suspend Not tainted 2.6.27 #2
> [  295.600142]
> [  295.600142] Call Trace:
> [  295.600147]  [<ffffffff802471ff>] warn_on_slowpath+0x5f/0x90
> [  295.600150]  [<ffffffff804be7de>] ? printk+0x67/0x69
> [  295.600164]  [<ffffffffa006fc10>] ? usb_autopm_do_device+0xc0/0x110 [usbcore]
> [  295.600166]  [<ffffffff80377307>] ? kobject_put+0x27/0x60
> [  295.600169]  [<ffffffff803f95c5>] ? put_device+0x15/0x20
> [  295.600172]  [<ffffffff804017ba>] ? device_resume+0x39a/0x460
> [  295.600174]  [<ffffffff802742e0>] suspend_test_finish+0x70/0x80
> [  295.600176]  [<ffffffff802743d4>] suspend_devices_and_enter+0xe4/0x200
> [  295.600178]  [<ffffffff80274666>] enter_state+0x146/0x1d0
> [  295.600180]  [<ffffffff802747aa>] state_store+0xba/0x100
> [  295.600181]  [<ffffffff803771c7>] kobj_attr_store+0x17/0x20
> [  295.600184]  [<ffffffff80326475>] sysfs_write_file+0xc5/0x140
> [  295.600186]  [<ffffffff802cd14b>] vfs_write+0xcb/0x190
> [  295.600188]  [<ffffffff802cd300>] sys_write+0x50/0x90
> [  295.600191]  [<ffffffff8021168a>] system_call_fastpath+0x16/0x1b
> [  295.600192]
> [  295.600193] ---[ end trace 8a154931a4b75ee4 ]---
> [  295.600333] PM: Finishing wakeup.
> 
> 
