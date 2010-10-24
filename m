From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [BUG] atomic mode violation probably caused by pm
	code
Date: Sun, 24 Oct 2010 16:06:34 +0200
Message-ID: <201010241606.34176.rjw@sisk.pl>
References: <1287866524.3322.7.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1287866524.3322.7.camel@maxim-laptop>
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

On Saturday, October 23, 2010, Maxim Levitsky wrote:
> Hi,

Hi,

> On today's mainline I get this:
> 
> [   41.755886] BUG: sleeping function called from invalid context at /home/maxim/software/kernel/linux-2.6/mm/slub.c:1701
> [   41.755907] in_atomic(): 1, irqs_disabled(): 0, pid: 2629, name: ethtool
> [   41.755920] 2 locks held by ethtool/2629:
> [   41.755928]  #0:  (rtnl_mutex){......}, at: [<ffffffff81320102>] rtnl_lock+0x12/0x20
> [   41.755952]  #1:  (&(&tp->lock)->rlock){......}, at: [<ffffffffa04f7b41>] tg3_set_wol+0x51/0xe0 [tg3]
> [   41.755982] Pid: 2629, comm: ethtool Not tainted 2.6.36+ #191
> [   41.755993] Call Trace:
> [   41.756004]  [<ffffffff810353ce>] __might_sleep+0xfe/0x120
> [   41.756018]  [<ffffffff810de323>] kmem_cache_alloc+0xd3/0xf0
> [   41.756033]  [<ffffffff8127f465>] wakeup_source_create+0x25/0x70
> [   41.756046]  [<ffffffff8127f4be>] wakeup_source_register+0xe/0x30
> [   41.756059]  [<ffffffff8127f527>] device_wakeup_enable+0x47/0xa0
> [   41.756072]  [<ffffffff8127f5a3>] device_set_wakeup_enable+0x23/0x40
> [   41.756088]  [<ffffffffa04f7b98>] tg3_set_wol+0xa8/0xe0 [tg3]
> [   41.756101]  [<ffffffff81317519>] dev_ethtool+0x1619/0x1880
> [   41.756113]  [<ffffffff81320102>] ? rtnl_lock+0x12/0x20
> [   41.756126]  [<ffffffff81314026>] dev_ioctl+0x556/0x8d0
> [   41.756138]  [<ffffffff81035bc1>] ? get_parent_ip+0x11/0x50
> [   41.756150]  [<ffffffff81035bc1>] ? get_parent_ip+0x11/0x50
> [   41.756163]  [<ffffffff810380dd>] ? sub_preempt_count+0x9d/0xd0
> [   41.756176]  [<ffffffff8106fc9e>] ? put_lock_stats+0xe/0x40
> [   41.756188]  [<ffffffff8106fd7c>] ? lock_release_holdtime+0xac/0x150
> [   41.756204]  [<ffffffff812fb125>] sock_do_ioctl+0x55/0x60
> [   41.756216]  [<ffffffff812fb442>] sock_ioctl+0x82/0x2b0
> [   41.756229]  [<ffffffff810f2601>] do_vfs_ioctl+0xa1/0x640
> [   41.756242]  [<ffffffff813ae410>] ? _raw_spin_unlock+0x30/0x60
> [   41.756255]  [<ffffffff810e0a62>] ? fd_install+0x62/0x80
> [   41.756267]  [<ffffffff810f2bea>] sys_ioctl+0x4a/0x80
> [   41.756278]  [<ffffffff8106fd7c>] ? lock_release_holdtime+0xac/0x150
> [   41.756293]  [<ffffffff81002e6b>] system_call_fastpath+0x16/0x1b
> [   41.756333] BUG: scheduling while atomic: ethtool/2629/0x00000202
> [   41.756345] 2 locks held by ethtool/2629:
> [   41.756353]  #0:  (rtnl_mutex){......}, at: [<ffffffff81320102>] rtnl_lock+0x12/0x20
> [   41.756371]  #1:  (&(&tp->lock)->rlock){......}, at: [<ffffffffa04f7b41>] tg3_set_wol+0x51/0xe0 [tg3]
> [   41.756394] Modules linked in: af_packet nfsd exportfs nfs lockd nfs_acl auth_rpcgss dm_crypt iwl3945 uvcvideo videodev iwlcore v4l2_compat_ioctl32 mac80211 sunrpc firewire_net usb_storage uhci_hcd snd_hda_codec_realtek usb_libusual cpufreq_powersave cpufreq_conservative r852 ir_lirc_codec lirc_dev cpufreq_userspace ir_sony_decoder joydev acpi_cpufreq sm_common ehci_hcd snd_hda_intel tg3 ir_jvc_decoder mperf nand iTCO_wdt coretemp ir_rc6_decoder ac snd_hda_codec sbp2 usbcore cfg80211 sdhci_pci snd_hwdep battery firewire_ohci ir_rc5_decoder ieee1394 psmouse ene_ir snd_pcm sdhci ir_nec_decoder serio_raw mmc_core libphy nand_ids r592 memstick nand_ecc firewire_core mtd ir_core snd_page_alloc evdev sg dm_mirror dm_region_hash dm_log dm_mod nouveau ttm drm_kms_helper drm i2c_algo_bit therm
 al video
> [   41.756592] Pid: 2629, comm: ethtool Not tainted 2.6.36+ #191
> [   41.756602] Call Trace:
> [   41.756611]  [<ffffffff81037f53>] __schedule_bug+0x63/0x70
> [   41.756623]  [<ffffffff813aaa11>] schedule+0x941/0xaf0
> [   41.756637]  [<ffffffff8100b589>] ? native_sched_clock+0x29/0x80
> [   41.756650]  [<ffffffff813ab085>] schedule_timeout+0x245/0x2c0
> [   41.756663]  [<ffffffff81065d60>] ? sched_clock_cpu+0xc0/0x110
> [   41.756676]  [<ffffffff8106fc9e>] ? put_lock_stats+0xe/0x40
> [   41.756688]  [<ffffffff8106fd7c>] ? lock_release_holdtime+0xac/0x150
> [   41.756702]  [<ffffffff813a9eb7>] wait_for_common+0xd7/0x170
> [   41.756715]  [<ffffffff8103df60>] ? default_wake_function+0x0/0x10
> [   41.756730]  [<ffffffff813a9ff8>] wait_for_completion+0x18/0x20
> [   41.756744]  [<ffffffff8109d70b>] synchronize_rcu+0x5b/0x80
> [   41.756756]  [<ffffffff8105bf50>] ? wakeme_after_rcu+0x0/0x10
> [   41.756770]  [<ffffffff813a9e24>] ? wait_for_common+0x44/0x170
> [   41.756783]  [<ffffffff8127f300>] wakeup_source_add+0x80/0xa0
> [   41.756795]  [<ffffffff8127f4ce>] wakeup_source_register+0x1e/0x30
> [   41.756809]  [<ffffffff8127f527>] device_wakeup_enable+0x47/0xa0
> [   41.756822]  [<ffffffff8127f5a3>] device_set_wakeup_enable+0x23/0x40
> [   41.756837]  [<ffffffffa04f7b98>] tg3_set_wol+0xa8/0xe0 [tg3]
> [   41.756851]  [<ffffffff81317519>] dev_ethtool+0x1619/0x1880
> [   41.756863]  [<ffffffff81320102>] ? rtnl_lock+0x12/0x20
> [   41.756875]  [<ffffffff81314026>] dev_ioctl+0x556/0x8d0
> [   41.756887]  [<ffffffff81035bc1>] ? get_parent_ip+0x11/0x50
> [   41.756899]  [<ffffffff81035bc1>] ? get_parent_ip+0x11/0x50
> [   41.756912]  [<ffffffff810380dd>] ? sub_preempt_count+0x9d/0xd0
> [   41.756925]  [<ffffffff8106fc9e>] ? put_lock_stats+0xe/0x40
> [   41.756937]  [<ffffffff8106fd7c>] ? lock_release_holdtime+0xac/0x150
> [   41.756951]  [<ffffffff812fb125>] sock_do_ioctl+0x55/0x60
> [   41.756964]  [<ffffffff812fb442>] sock_ioctl+0x82/0x2b0
> [   41.756975]  [<ffffffff810f2601>] do_vfs_ioctl+0xa1/0x640
> [   41.756988]  [<ffffffff813ae410>] ? _raw_spin_unlock+0x30/0x60
> [   41.757000]  [<ffffffff810e0a62>] ? fd_install+0x62/0x80
> [   41.757012]  [<ffffffff810f2bea>] sys_ioctl+0x4a/0x80
> [   41.757024]  [<ffffffff8106fd7c>] ? lock_release_holdtime+0xac/0x150
> [   41.757038]  [<ffffffff81002e6b>] system_call_fastpath+0x16/0x1b
> [   41.770189] BUG: scheduling while atomic: ethtool/2629/0x00000202
> [   41.770194] 2 locks held by ethtool/2629:
> [   41.770197]  #0:  (rtnl_mutex){......}, at: [<ffffffff81320102>] rtnl_lock+0x12/0x20
> [   41.770206]  #1:  (&(&tp->lock)->rlock){......}, at: [<ffffffffa04f7b41>] tg3_set_wol+0x51/0xe0 [tg3]
> [   41.770218] Modules linked in: af_packet nfsd exportfs nfs lockd nfs_acl auth_rpcgss dm_crypt iwl3945 uvcvideo videodev iwlcore v4l2_compat_ioctl32 mac80211 sunrpc firewire_net usb_storage uhci_hcd snd_hda_codec_realtek usb_libusual cpufreq_powersave cpufreq_conservative r852 ir_lirc_codec lirc_dev cpufreq_userspace ir_sony_decoder joydev acpi_cpufreq sm_common ehci_hcd snd_hda_intel tg3 ir_jvc_decoder mperf nand iTCO_wdt coretemp ir_rc6_decoder ac snd_hda_codec sbp2 usbcore cfg80211 sdhci_pci snd_hwdep battery firewire_ohci ir_rc5_decoder ieee1394 psmouse ene_ir snd_pcm sdhci ir_nec_decoder serio_raw mmc_core libphy nand_ids r592 memstick nand_ecc firewire_core mtd ir_core snd_page_alloc evdev sg dm_mirror dm_region_hash dm_log dm_mod nouveau ttm drm_kms_helper drm i2c_algo_bit therm
 al video
> [   41.770294] Pid: 2629, comm: ethtool Not tainted 2.6.36+ #191
> [   41.770298] Call Trace:
> [   41.770303]  [<ffffffff81037f53>] __schedule_bug+0x63/0x70
> [   41.770309]  [<ffffffff813aaa11>] schedule+0x941/0xaf0
> [   41.770316]  [<ffffffff8100b589>] ? native_sched_clock+0x29/0x80
> [   41.770322]  [<ffffffff813ab085>] schedule_timeout+0x245/0x2c0
> [   41.770327]  [<ffffffff81065d60>] ? sched_clock_cpu+0xc0/0x110
> [   41.770333]  [<ffffffff8106fc9e>] ? put_lock_stats+0xe/0x40
> [   41.770338]  [<ffffffff8106fd7c>] ? lock_release_holdtime+0xac/0x150
> [   41.770345]  [<ffffffff813a9eb7>] wait_for_common+0xd7/0x170
> [   41.770351]  [<ffffffff8103df60>] ? default_wake_function+0x0/0x10
> [   41.770357]  [<ffffffff813a9ff8>] wait_for_completion+0x18/0x20
> [   41.770363]  [<ffffffff8109d70b>] synchronize_rcu+0x5b/0x80
> [   41.770369]  [<ffffffff8105bf50>] ? wakeme_after_rcu+0x0/0x10
> [   41.770374]  [<ffffffff813a9e24>] ? wait_for_common+0x44/0x170
> [   41.770381]  [<ffffffff8127f25b>] wakeup_source_remove+0x4b/0x70
> [   41.770386]  [<ffffffff8127f3b1>] wakeup_source_unregister+0x11/0x20
> [   41.770392]  [<ffffffff8127f55d>] device_wakeup_enable+0x7d/0xa0
> [   41.770398]  [<ffffffff8127f5a3>] device_set_wakeup_enable+0x23/0x40
> [   41.770406]  [<ffffffffa04f7b98>] tg3_set_wol+0xa8/0xe0 [tg3]
> [   41.770412]  [<ffffffff81317519>] dev_ethtool+0x1619/0x1880
> [   41.770418]  [<ffffffff81320102>] ? rtnl_lock+0x12/0x20
> [   41.770423]  [<ffffffff81314026>] dev_ioctl+0x556/0x8d0
> [   41.770429]  [<ffffffff81035bc1>] ? get_parent_ip+0x11/0x50
> [   41.770434]  [<ffffffff81035bc1>] ? get_parent_ip+0x11/0x50
> [   41.770440]  [<ffffffff810380dd>] ? sub_preempt_count+0x9d/0xd0
> [   41.770446]  [<ffffffff8106fc9e>] ? put_lock_stats+0xe/0x40
> [   41.770451]  [<ffffffff8106fd7c>] ? lock_release_holdtime+0xac/0x150
> [   41.770458]  [<ffffffff812fb125>] sock_do_ioctl+0x55/0x60
> [   41.770464]  [<ffffffff812fb442>] sock_ioctl+0x82/0x2b0
> [   41.770469]  [<ffffffff810f2601>] do_vfs_ioctl+0xa1/0x640
> [   41.770475]  [<ffffffff813ae410>] ? _raw_spin_unlock+0x30/0x60
> [   41.770482]  [<ffffffff810e0a62>] ? fd_install+0x62/0x80
> [   41.770487]  [<ffffffff810f2bea>] sys_ioctl+0x4a/0x80
> [   41.770492]  [<ffffffff8106fd7c>] ? lock_release_holdtime+0xac/0x150
> [   41.770499]  [<ffffffff81002e6b>] system_call_fastpath+0x16/0x1b
> [   42.688343] EXT4-fs (sda1): re-mounted. Opts: errors=remount-ro,commit=0
> [   44.524491] EXT4-fs (sda3): re-mounted. Opts: errors=remount-ro,commit=0
> [   51.277608] fuse init (API version 7.15)
> [   55.215763] BUG: sleeping function called from invalid context at /home/maxim/software/kernel/linux-2.6/mm/slub.c:1701
> [   55.215787] in_atomic(): 1, irqs_disabled(): 0, pid: 2852, name: ethtool
> [   55.215801] 2 locks held by ethtool/2852:
> [   55.215810]  #0:  (rtnl_mutex){......}, at: [<ffffffff81320102>] rtnl_lock+0x12/0x20
> [   55.215837]  #1:  (&(&tp->lock)->rlock){......}, at: [<ffffffffa04f7b41>] tg3_set_wol+0x51/0xe0 [tg3]
> [   55.215875] Pid: 2852, comm: ethtool Not tainted 2.6.36+ #191
> [   55.215887] Call Trace:
> [   55.215901]  [<ffffffff810353ce>] __might_sleep+0xfe/0x120
> [   55.215916]  [<ffffffff810de323>] kmem_cache_alloc+0xd3/0xf0
> [   55.215932]  [<ffffffff8127f465>] wakeup_source_create+0x25/0x70
> [   55.215946]  [<ffffffff8127f4be>] wakeup_source_register+0xe/0x30
> [   55.215960]  [<ffffffff8127f527>] device_wakeup_enable+0x47/0xa0
> [   55.215974]  [<ffffffff8127f5a3>] device_set_wakeup_enable+0x23/0x40
> [   55.215991]  [<ffffffffa04f7b98>] tg3_set_wol+0xa8/0xe0 [tg3]
> [   55.216006]  [<ffffffff81317519>] dev_ethtool+0x1619/0x1880
> [   55.216019]  [<ffffffff81320102>] ? rtnl_lock+0x12/0x20
> [   55.216032]  [<ffffffff81314026>] dev_ioctl+0x556/0x8d0
> [   55.216045]  [<ffffffff81035bc1>] ? get_parent_ip+0x11/0x50
> [   55.216058]  [<ffffffff81035bc1>] ? get_parent_ip+0x11/0x50
> [   55.216072]  [<ffffffff810380dd>] ? sub_preempt_count+0x9d/0xd0
> [   55.216087]  [<ffffffff8106fc9e>] ? put_lock_stats+0xe/0x40
> [   55.216100]  [<ffffffff8106fd7c>] ? lock_release_holdtime+0xac/0x150
> [   55.216117]  [<ffffffff812fb125>] sock_do_ioctl+0x55/0x60
> [   55.216130]  [<ffffffff812fb442>] sock_ioctl+0x82/0x2b0
> [   55.216143]  [<ffffffff810f2601>] do_vfs_ioctl+0xa1/0x640
> [   55.216158]  [<ffffffff813ae410>] ? _raw_spin_unlock+0x30/0x60
> [   55.216172]  [<ffffffff810e0a62>] ? fd_install+0x62/0x80
> [   55.216185]  [<ffffffff810f2bea>] sys_ioctl+0x4a/0x80
> [   55.216197]  [<ffffffff8106fd7c>] ? lock_release_holdtime+0xac/0x150
> [   55.216213]  [<ffffffff81002e6b>] system_call_fastpath+0x16/0x1b
> [   55.216254] BUG: scheduling while atomic: ethtool/2852/0x00000202
> [   55.216277] 2 locks held by ethtool/2852:
> [   55.216285]  #0:  (rtnl_mutex){......}, at: [<ffffffff81320102>] rtnl_lock+0x12/0x20
> [   55.216305]  #1:  (&(&tp->lock)->rlock){......}, at: [<ffffffffa04f7b41>] tg3_set_wol+0x51/0xe0 [tg3]
> [   55.216330] Modules linked in: fuse af_packet nfsd exportfs nfs lockd nfs_acl auth_rpcgss dm_crypt iwl3945 uvcvideo videodev iwlcore v4l2_compat_ioctl32 mac80211 sunrpc firewire_net usb_storage uhci_hcd snd_hda_codec_realtek usb_libusual cpufreq_powersave cpufreq_conservative r852 ir_lirc_codec lirc_dev cpufreq_userspace ir_sony_decoder joydev acpi_cpufreq sm_common ehci_hcd snd_hda_intel tg3 ir_jvc_decoder mperf nand iTCO_wdt coretemp ir_rc6_decoder ac snd_hda_codec sbp2 usbcore cfg80211 sdhci_pci snd_hwdep battery firewire_ohci ir_rc5_decoder ieee1394 psmouse ene_ir snd_pcm sdhci ir_nec_decoder serio_raw mmc_core libphy nand_ids r592 memstick nand_ecc firewire_core mtd ir_core snd_page_alloc evdev sg dm_mirror dm_region_hash dm_log dm_mod nouveau ttm drm_kms_helper drm i2c_algo_bit 
 thermal video
> [   55.216543] Pid: 2852, comm: ethtool Not tainted 2.6.36+ #191
> [   55.216554] Call Trace:
> [   55.216563]  [<ffffffff81037f53>] __schedule_bug+0x63/0x70
> [   55.216576]  [<ffffffff813aaa11>] schedule+0x941/0xaf0
> [   55.216591]  [<ffffffff8100b589>] ? native_sched_clock+0x29/0x80
> [   55.216605]  [<ffffffff813ab085>] schedule_timeout+0x245/0x2c0
> [   55.216619]  [<ffffffff81065d60>] ? sched_clock_cpu+0xc0/0x110
> [   55.216633]  [<ffffffff8106fc9e>] ? put_lock_stats+0xe/0x40
> [   55.216646]  [<ffffffff8106fd7c>] ? lock_release_holdtime+0xac/0x150
> [   55.216661]  [<ffffffff813a9eb7>] wait_for_common+0xd7/0x170
> [   55.216675]  [<ffffffff8103df60>] ? default_wake_function+0x0/0x10
> [   55.216690]  [<ffffffff813a9ff8>] wait_for_completion+0x18/0x20
> [   55.216705]  [<ffffffff8109d70b>] synchronize_rcu+0x5b/0x80
> [   55.216719]  [<ffffffff8105bf50>] ? wakeme_after_rcu+0x0/0x10
> [   55.216732]  [<ffffffff813a9e24>] ? wait_for_common+0x44/0x170
> [   55.216746]  [<ffffffff8127f300>] wakeup_source_add+0x80/0xa0
> [   55.216760]  [<ffffffff8127f4ce>] wakeup_source_register+0x1e/0x30
> [   55.216774]  [<ffffffff8127f527>] device_wakeup_enable+0x47/0xa0
> [   55.216788]  [<ffffffff8127f5a3>] device_set_wakeup_enable+0x23/0x40
> [   55.216804]  [<ffffffffa04f7b98>] tg3_set_wol+0xa8/0xe0 [tg3]
> [   55.216818]  [<ffffffff81317519>] dev_ethtool+0x1619/0x1880
> [   55.216831]  [<ffffffff81320102>] ? rtnl_lock+0x12/0x20
> [   55.216845]  [<ffffffff81314026>] dev_ioctl+0x556/0x8d0
> [   55.216857]  [<ffffffff81035bc1>] ? get_parent_ip+0x11/0x50
> [   55.216870]  [<ffffffff81035bc1>] ? get_parent_ip+0x11/0x50
> [   55.216884]  [<ffffffff810380dd>] ? sub_preempt_count+0x9d/0xd0
> [   55.216897]  [<ffffffff8106fc9e>] ? put_lock_stats+0xe/0x40
> [   55.216910]  [<ffffffff8106fd7c>] ? lock_release_holdtime+0xac/0x150
> [   55.216926]  [<ffffffff812fb125>] sock_do_ioctl+0x55/0x60
> [   55.216939]  [<ffffffff812fb442>] sock_ioctl+0x82/0x2b0
> [   55.216951]  [<ffffffff810f2601>] do_vfs_ioctl+0xa1/0x640
> [   55.216964]  [<ffffffff813ae410>] ? _raw_spin_unlock+0x30/0x60
> [   55.216978]  [<ffffffff810e0a62>] ? fd_install+0x62/0x80
> [   55.216991]  [<ffffffff810f2bea>] sys_ioctl+0x4a/0x80
> [   55.217003]  [<ffffffff8106fd7c>] ? lock_release_holdtime+0xac/0x150
> [   55.217018]  [<ffffffff81002e6b>] system_call_fastpath+0x16/0x1b
> [   55.217038] NOHZ: local_softirq_pending 10
> [   55.250502] BUG: scheduling while atomic: ethtool/2852/0x00000202
> [   55.250518] 2 locks held by ethtool/2852:
> [   55.250528]  #0:  (rtnl_mutex){......}, at: [<ffffffff81320102>] rtnl_lock+0x12/0x20
> [   55.250556]  #1:  (&(&tp->lock)->rlock){......}, at: [<ffffffffa04f7b41>] tg3_set_wol+0x51/0xe0 [tg3]
> [   55.250592] Modules linked in: fuse af_packet nfsd exportfs nfs lockd nfs_acl auth_rpcgss dm_crypt iwl3945 uvcvideo videodev iwlcore v4l2_compat_ioctl32 mac80211 sunrpc firewire_net usb_storage uhci_hcd snd_hda_codec_realtek usb_libusual cpufreq_powersave cpufreq_conservative r852 ir_lirc_codec lirc_dev cpufreq_userspace ir_sony_decoder joydev acpi_cpufreq sm_common ehci_hcd snd_hda_intel tg3 ir_jvc_decoder mperf nand iTCO_wdt coretemp ir_rc6_decoder ac snd_hda_codec sbp2 usbcore cfg80211 sdhci_pci snd_hwdep battery firewire_ohci ir_rc5_decoder ieee1394 psmouse ene_ir snd_pcm sdhci ir_nec_decoder serio_raw mmc_core libphy nand_ids r592 memstick nand_ecc firewire_core mtd ir_core snd_page_alloc evdev sg dm_mirror dm_region_hash dm_log dm_mod nouveau ttm drm_kms_helper drm i2c_algo_bit 
 thermal video
> [   55.250835] Pid: 2852, comm: ethtool Not tainted 2.6.36+ #191
> [   55.250849] Call Trace:
> [   55.250861]  [<ffffffff81037f53>] __schedule_bug+0x63/0x70
> [   55.250877]  [<ffffffff813aaa11>] schedule+0x941/0xaf0
> [   55.250894]  [<ffffffff8100b589>] ? native_sched_clock+0x29/0x80
> [   55.250910]  [<ffffffff813ab085>] schedule_timeout+0x245/0x2c0
> [   55.250926]  [<ffffffff81065d60>] ? sched_clock_cpu+0xc0/0x110
> [   55.250943]  [<ffffffff8106fc9e>] ? put_lock_stats+0xe/0x40
> [   55.250957]  [<ffffffff8106fd7c>] ? lock_release_holdtime+0xac/0x150
> [   55.250974]  [<ffffffff813a9eb7>] wait_for_common+0xd7/0x170
> [   55.250989]  [<ffffffff8103df60>] ? default_wake_function+0x0/0x10
> [   55.251007]  [<ffffffff813a9ff8>] wait_for_completion+0x18/0x20
> [   55.251023]  [<ffffffff8109d70b>] synchronize_rcu+0x5b/0x80
> [   55.251039]  [<ffffffff8105bf50>] ? wakeme_after_rcu+0x0/0x10
> [   55.251054]  [<ffffffff813a9e24>] ? wait_for_common+0x44/0x170
> [   55.251072]  [<ffffffff8127f25b>] wakeup_source_remove+0x4b/0x70
> [   55.251087]  [<ffffffff8127f3b1>] wakeup_source_unregister+0x11/0x20
> [   55.251104]  [<ffffffff8127f55d>] device_wakeup_enable+0x7d/0xa0
> [   55.251120]  [<ffffffff8127f5a3>] device_set_wakeup_enable+0x23/0x40
> [   55.251139]  [<ffffffffa04f7b98>] tg3_set_wol+0xa8/0xe0 [tg3]
> [   55.251155]  [<ffffffff81317519>] dev_ethtool+0x1619/0x1880
> [   55.251170]  [<ffffffff81320102>] ? rtnl_lock+0x12/0x20
> [   55.251185]  [<ffffffff81314026>] dev_ioctl+0x556/0x8d0
> [   55.251199]  [<ffffffff81035bc1>] ? get_parent_ip+0x11/0x50
> [   55.251214]  [<ffffffff81035bc1>] ? get_parent_ip+0x11/0x50
> [   55.251229]  [<ffffffff810380dd>] ? sub_preempt_count+0x9d/0xd0
> [   55.251245]  [<ffffffff8106fc9e>] ? put_lock_stats+0xe/0x40
> [   55.251259]  [<ffffffff8106fd7c>] ? lock_release_holdtime+0xac/0x150
> [   55.251278]  [<ffffffff812fb125>] sock_do_ioctl+0x55/0x60
> [   55.251293]  [<ffffffff812fb442>] sock_ioctl+0x82/0x2b0
> [   55.251308]  [<ffffffff810f2601>] do_vfs_ioctl+0xa1/0x640
> [   55.251323]  [<ffffffff813ae410>] ? _raw_spin_unlock+0x30/0x60
> [   55.251340]  [<ffffffff810e0a62>] ? fd_install+0x62/0x80
> [   55.251354]  [<ffffffff810f2bea>] sys_ioctl+0x4a/0x80
> [   55.251368]  [<ffffffff8106fd7c>] ? lock_release_holdtime+0xac/0x150
> [   55.251386]  [<ffffffff81002e6b>] system_call_fastpath+0x16/0x1b
> [   55.290319] BUG: spinlock wrong CPU on CPU#1, ethtool/2852
> [   55.302939]  lock: ffff88007975aa48, .magic: dead4ead, .owner: ethtool/2852, .owner_cpu: 0
> [   55.309875] Pid: 2852, comm: ethtool Not tainted 2.6.36+ #191
> [   55.315910] Call Trace:
> [   55.322675]  [<ffffffff811e89d2>] spin_bug+0xa2/0xf0
> [   55.322681]  [<ffffffff811e8a91>] do_raw_spin_unlock+0x71/0xa0
> [   55.322688]  [<ffffffff813ae306>] _raw_spin_unlock_bh+0x26/0x40
> [   55.322704]  [<ffffffffa04f7b65>] tg3_set_wol+0x75/0xe0 [tg3]
> [   55.322711]  [<ffffffff81317519>] dev_ethtool+0x1619/0x1880
> [   55.322717]  [<ffffffff81320102>] ? rtnl_lock+0x12/0x20
> [   55.322723]  [<ffffffff81314026>] dev_ioctl+0x556/0x8d0
> [   55.322729]  [<ffffffff81035bc1>] ? get_parent_ip+0x11/0x50
> [   55.322735]  [<ffffffff81035bc1>] ? get_parent_ip+0x11/0x50
> [   55.322741]  [<ffffffff810380dd>] ? sub_preempt_count+0x9d/0xd0
> [   55.322748]  [<ffffffff8106fc9e>] ? put_lock_stats+0xe/0x40
> [   55.322753]  [<ffffffff8106fd7c>] ? lock_release_holdtime+0xac/0x150
> [   55.322763]  [<ffffffff812fb125>] sock_do_ioctl+0x55/0x60
> [   55.322769]  [<ffffffff812fb442>] sock_ioctl+0x82/0x2b0
> [   55.322775]  [<ffffffff810f2601>] do_vfs_ioctl+0xa1/0x640
> [   55.322782]  [<ffffffff813ae410>] ? _raw_spin_unlock+0x30/0x60
> [   55.322790]  [<ffffffff810e0a62>] ? fd_install+0x62/0x80
> [   55.322796]  [<ffffffff810f2bea>] sys_ioctl+0x4a/0x80
> [   55.322802]  [<ffffffff8106fd7c>] ? lock_release_holdtime+0xac/0x150
> [   55.322809]  [<ffffffff81002e6b>] system_call_fastpath+0x16/0x1b

Incidentally, I have a patch for this issue, which is appended.  Please test
and let me know if it helps (and WoL still works for you).

Thanks,
Rafael

---
From: Rafael J. Wysocki <rjw@sisk.pl>
Subject: tg3: Do not call device_set_wakeup_enable() under a spinlock

The tg3 driver calls device_set_wakeup_enable() under a spinlock,
which causes a problem to happen after the recent core power
management changes, because this function can sleep now.  Fix this
by moving the device_set_wakeup_enable() call out of the
spinlock-protected area.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/net/tg3.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

Index: linux-2.6/drivers/net/tg3.c
===================================================================
--- linux-2.6.orig/drivers/net/tg3.c
+++ linux-2.6/drivers/net/tg3.c
@@ -9732,16 +9732,16 @@ static int tg3_set_wol(struct net_device
 	    !((tp->tg3_flags & TG3_FLAG_WOL_CAP) && device_can_wakeup(dp)))
 		return -EINVAL;
 
+	device_set_wakeup_enable(dp, wol->wolopts & WAKE_MAGIC);
+
 	spin_lock_bh(&tp->lock);
-	if (wol->wolopts & WAKE_MAGIC) {
+	if (device_may_wakeup(dp))
 		tp->tg3_flags |= TG3_FLAG_WOL_ENABLE;
-		device_set_wakeup_enable(dp, true);
-	} else {
+	else
 		tp->tg3_flags &= ~TG3_FLAG_WOL_ENABLE;
-		device_set_wakeup_enable(dp, false);
-	}
 	spin_unlock_bh(&tp->lock);
 
+
 	return 0;
 }
 
