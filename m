From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: cpufreq warning with kernel 3.11
Date: Sun, 01 Sep 2013 22:42:26 +0200
Message-ID: <9800169.8Do56q7MsY@vostro.rjw.lan>
References: <52234788.1090607@gmail.com> <CAKohpokCLKWpDOJsLTjbT8aO15aw93q57cufFCMtrXjbAi2hyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohpokCLKWpDOJsLTjbT8aO15aw93q57cufFCMtrXjbAi2hyg@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Alessandro Bono <alessandro.bono@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sunday, September 01, 2013 10:40:32 PM Viresh Kumar wrote:
> On 1 September 2013 19:26, Alessandro Bono <alessandro.bono@gmail.com> wrote:
> > Hi
> >
> > With kernel 3.11 I see follow messsages
> > previously I used standard kernel from ubuntu 3.8.0 without this messages
> >
> > [29932.092075] WARNING: CPU: 0 PID: 14543 at
> > /home/apw/COD/linux/drivers/cpufreq/cpufreq.c:317
> > __cpufreq_notify_transition+0x238/0x260()
> > [29932.092080] In middle of another frequency transition
> > [29932.092084] Modules linked in: hidp ip6table_filter ip6_tables
> > ebtable_nat ebtables ipt_MASQUERADE iptable_nat nf_nat_ipv4 nf_nat
> > nf_conntrack_ipv4 nf_defrag_ipv4 xt_state nf_conntrack ipt_REJECT
> > xt_CHECKSUM iptable_mangle xt_tcpudp iptable_filter ip_tables x_tables
> > bridge stp llc deflate zlib_deflate ctr twofish_generic twofish_x86_64_3way
> > twofish_x86_64 twofish_common camellia_generic camellia_x86_64
> > serpent_sse2_x86_64 serpent_generic lrw glue_helper blowfish_generic
> > blowfish_x86_64 blowfish_common cast5_generic cast_common ablk_helper cryptd
> > des_generic cmac pata_pcmcia xcbc rmd160 joydev hp_wmi sparse_keymap
> > crypto_null af_key xfrm_algo snd_seq_midi btusb snd_seq_midi_event
> > tpm_infineon snd_hda_codec_hdmi dm_multipath arc4 scsi_dh
> > snd_hda_codec_analog snd_rawmidi iwl4965 snd_hda_intel pcmcia snd_hda_codec
> > snd_hwdep iwlegacy snd_pcm snd_seq mac80211 yenta_socket pcmcia_rsrc psmouse
> > pcmcia_core serio_raw lpc_ich snd_seq_device snd_page_alloc cfg80211
> > snd_timer snd hp_accel lis3lv02d input_polldev soundcore tpm_tis parport_pc
> > ppdev bnep mac_hid rfcomm bluetooth lp parport binfmt_misc ext2 xts gf128mul
> > hid_generic usbhid hid dm_crypt firewire_ohci firewire_core sdhci_pci sdhci
> > ahci libahci crc_itu_t radeon e1000e ptp pps_core i2c_algo_bit video ttm
> > drm_kms_helper wmi drm
> > [29932.092337] CPU: 0 PID: 14543 Comm: kworker/0:1 Not tainted
> > 3.11.0-999-generic #201308280510
> > [29932.092342] Hardware name: Hewlett-Packard HP Compaq 8510p
> > (GR539AW#ABZ)/30C5, BIOS 68MVD Ver. F.20 12/01/2011
> > [29932.092353] Workqueue: kacpi_notify acpi_os_execute_deferred
> > [29932.092359]  000000000000013d ffff880133665988 ffffffff81720daa
> > 0000000000000007
> > [29932.092369]  ffff8801336659d8 ffff8801336659c8 ffffffff8106534c
> > ffffffff815b8560
> > [29932.092377]  ffff8800259eee00 ffff880133665ab8 0000000000000001
> > 0000000000000001
> > [29932.092390] Call Trace:
> > [29932.092396]  [<ffffffff81720daa>] dump_stack+0x46/0x58
> > [29932.092400]  [<ffffffff8106534c>] warn_slowpath_common+0x8c/0xc0
> > [29932.092404]  [<ffffffff815b8560>] ? acpi_cpufreq_target+0x320/0x320
> > [29932.092407]  [<ffffffff81065436>] warn_slowpath_fmt+0x46/0x50
> > [29932.092410]  [<ffffffff815b1ec8>] __cpufreq_notify_transition+0x238/0x260
> > [29932.092413]  [<ffffffff815b33be>] cpufreq_notify_transition+0x3e/0x70
> > [29932.092416]  [<ffffffff815b345d>] cpufreq_out_of_sync+0x6d/0xb0
> > [29932.092419]  [<ffffffff815b370c>] cpufreq_update_policy+0x10c/0x160
> > [29932.092422]  [<ffffffff815b3760>] ? cpufreq_update_policy+0x160/0x160
> > [29932.092426]  [<ffffffff81413813>] cpufreq_set_cur_state+0x8c/0xb5
> > [29932.092429]  [<ffffffff814138df>] processor_set_cur_state+0xa3/0xcf
> > [29932.092434]  [<ffffffff8158e13c>] thermal_cdev_update+0x9c/0xb0
> > [29932.092437]  [<ffffffff8159046a>] step_wise_throttle+0x5a/0x90
> > [29932.092440]  [<ffffffff8158e21f>] handle_thermal_trip+0x4f/0x140
> > [29932.092443]  [<ffffffff8158e377>] thermal_zone_device_update+0x57/0xa0
> > [29932.092446]  [<ffffffff81415b36>] acpi_thermal_check+0x2e/0x30
> > [29932.092449]  [<ffffffff81415ca0>] acpi_thermal_notify+0x40/0xdc
> > [29932.092452]  [<ffffffff813e7dbd>] acpi_device_notify+0x19/0x1b
> > [29932.092456]  [<ffffffff813f8241>] acpi_ev_notify_dispatch+0x41/0x5c
> > [29932.092459]  [<ffffffff813e3fbe>] acpi_os_execute_deferred+0x25/0x32
> > [29932.092463]  [<ffffffff81081060>] process_one_work+0x170/0x4a0
> > [29932.092466]  [<ffffffff81082121>] worker_thread+0x121/0x390
> > [29932.092469]  [<ffffffff81082000>] ? manage_workers.isra.20+0x170/0x170
> > [29932.092472]  [<ffffffff81088fe0>] kthread+0xc0/0xd0
> > [29932.092476]  [<ffffffff81088f20>] ? flush_kthread_worker+0xb0/0xb0
> > [29932.092479]  [<ffffffff8173582c>] ret_from_fork+0x7c/0xb0
> > [29932.092482]  [<ffffffff81088f20>] ? flush_kthread_worker+0xb0/0xb0
> > [29932.092484] ---[ end trace a5e2dde8816c52d8 ]---
> > [29932.092486] ------------[ cut here ]------------
> > [29932.092489] WARNING: CPU: 0 PID: 14543 at
> > /home/apw/COD/linux/drivers/cpufreq/cpufreq.c:342
> > __cpufreq_notify_transition+0x1f6/0x260()
> > [29932.092490] No frequency transition in progress
> > [29932.092492] Modules linked in: hidp ip6table_filter ip6_tables
> > ebtable_nat ebtables ipt_MASQUERADE iptable_nat nf_nat_ipv4 nf_nat
> > nf_conntrack_ipv4 nf_defrag_ipv4 xt_state nf_conntrack ipt_REJECT
> > xt_CHECKSUM iptable_mangle xt_tcpudp iptable_filter ip_tables x_tables
> > bridge stp llc deflate zlib_deflate ctr twofish_generic twofish_x86_64_3way
> > twofish_x86_64 twofish_common camellia_generic camellia_x86_64
> > serpent_sse2_x86_64 serpent_generic lrw glue_helper blowfish_generic
> > blowfish_x86_64 blowfish_common cast5_generic cast_common ablk_helper cryptd
> > des_generic cmac pata_pcmcia xcbc rmd160 joydev hp_wmi sparse_keymap
> > crypto_null af_key xfrm_algo snd_seq_midi btusb snd_seq_midi_event
> > tpm_infineon snd_hda_codec_hdmi dm_multipath arc4 scsi_dh
> > snd_hda_codec_analog snd_rawmidi iwl4965 snd_hda_intel pcmcia snd_hda_codec
> > snd_hwdep iwlegacy snd_pcm snd_seq mac80211 yenta_socket pcmcia_rsrc psmouse
> > pcmcia_core serio_raw lpc_ich snd_seq_device snd_page_alloc cfg80211
> > snd_timer snd hp_accel lis3lv02d input_polldev soundcore tpm_tis parport_pc
> > ppdev bnep mac_hid rfcomm bluetooth lp parport binfmt_misc ext2 xts gf128mul
> > hid_generic usbhid hid dm_crypt firewire_ohci firewire_core sdhci_pci sdhci
> > ahci libahci crc_itu_t radeon e1000e ptp pps_core i2c_algo_bit video ttm
> > drm_kms_helper wmi drm
> > [29932.092564] CPU: 0 PID: 14543 Comm: kworker/0:1 Tainted: G        W
> > 3.11.0-999-generic #201308280510
> > [29932.092566] Hardware name: Hewlett-Packard HP Compaq 8510p
> > (GR539AW#ABZ)/30C5, BIOS 68MVD Ver. F.20 12/01/2011
> > [29932.092568] Workqueue: kacpi_notify acpi_os_execute_deferred
> > [29932.092569]  0000000000000156 ffff880133665988 ffffffff81720daa
> > 0000000000000007
> > [29932.092572]  ffff8801336659d8 ffff8801336659c8 ffffffff8106534c
> > ffffffff815b8560
> > [29932.092575]  ffff8800259eee00 ffff880133665ab8 0000000000000001
> > 0000000000000001
> > [29932.092578] Call Trace:
> > [29932.092581]  [<ffffffff81720daa>] dump_stack+0x46/0x58
> > [29932.092584]  [<ffffffff8106534c>] warn_slowpath_common+0x8c/0xc0
> > [29932.092587]  [<ffffffff815b8560>] ? acpi_cpufreq_target+0x320/0x320
> > [29932.092590]  [<ffffffff81065436>] warn_slowpath_fmt+0x46/0x50
> > [29932.092593]  [<ffffffff815b1e86>] __cpufreq_notify_transition+0x1f6/0x260
> > [29932.092596]  [<ffffffff815b33be>] cpufreq_notify_transition+0x3e/0x70
> > [29932.092604]  [<ffffffff815b346e>] cpufreq_out_of_sync+0x7e/0xb0
> > [29932.092607]  [<ffffffff815b370c>] cpufreq_update_policy+0x10c/0x160
> > [29932.092610]  [<ffffffff815b3760>] ? cpufreq_update_policy+0x160/0x160
> > [29932.092613]  [<ffffffff81413813>] cpufreq_set_cur_state+0x8c/0xb5
> > [29932.092615]  [<ffffffff814138df>] processor_set_cur_state+0xa3/0xcf
> > [29932.092618]  [<ffffffff8158e13c>] thermal_cdev_update+0x9c/0xb0
> > [29932.092621]  [<ffffffff8159046a>] step_wise_throttle+0x5a/0x90
> > [29932.092623]  [<ffffffff8158e21f>] handle_thermal_trip+0x4f/0x140
> > [29932.092626]  [<ffffffff8158e377>] thermal_zone_device_update+0x57/0xa0
> > [29932.092629]  [<ffffffff81415b36>] acpi_thermal_check+0x2e/0x30
> > [29932.092631]  [<ffffffff81415ca0>] acpi_thermal_notify+0x40/0xdc
> > [29932.092634]  [<ffffffff813e7dbd>] acpi_device_notify+0x19/0x1b
> > [29932.092637]  [<ffffffff813f8241>] acpi_ev_notify_dispatch+0x41/0x5c
> > [29932.092639]  [<ffffffff813e3fbe>] acpi_os_execute_deferred+0x25/0x32
> > [29932.092642]  [<ffffffff81081060>] process_one_work+0x170/0x4a0
> > [29932.092645]  [<ffffffff81082121>] worker_thread+0x121/0x390
> > [29932.092648]  [<ffffffff81082000>] ? manage_workers.isra.20+0x170/0x170
> > [29932.092650]  [<ffffffff81088fe0>] kthread+0xc0/0xd0
> > [29932.092653]  [<ffffffff81088f20>] ? flush_kthread_worker+0xb0/0xb0
> > [29932.092656]  [<ffffffff8173582c>] ret_from_fork+0x7c/0xb0
> > [29932.092658]  [<ffffffff81088f20>] ? flush_kthread_worker+0xb0/0xb0
> > [29932.092660] ---[ end trace a5e2dde8816c52d9 ]---
> >
> > kernel binary taken from this url
> > http://kernel.ubuntu.com/~kernel-ppa/mainline/daily/2013-08-28-saucy/
> >
> > cpu information
> >
> > processor       : 0
> > vendor_id       : GenuineIntel
> > cpu family      : 6
> > model           : 15
> > model name      : Intel(R) Core(TM)2 Duo CPU     T7700  @ 2.40GHz
> > stepping        : 11
> > microcode       : 0xba
> > cpu MHz         : 800.000
> > cache size      : 4096 KB
> > physical id     : 0
> > siblings        : 2
> > core id         : 0
> > cpu cores       : 2
> > apicid          : 0
> > initial apicid  : 0
> > fpu             : yes
> > fpu_exception   : yes
> > cpuid level     : 10
> > wp              : yes
> > flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
> > cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx lm
> > constant_tsc arch_perfmon pebs bts rep_good nopl aperfmperf pni dtes64
> > monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm lahf_lm ida dtherm
> > tpr_shadow vnmi flexpriority
> > bogomips        : 4787.95
> > clflush size    : 64
> > cache_alignment : 64
> > address sizes   : 36 bits physical, 48 bits virtual
> > power management:
> >
> > processor       : 1
> > vendor_id       : GenuineIntel
> > cpu family      : 6
> > model           : 15
> > model name      : Intel(R) Core(TM)2 Duo CPU     T7700  @ 2.40GHz
> > stepping        : 11
> > microcode       : 0xba
> > cpu MHz         : 2401.000
> > cache size      : 4096 KB
> > physical id     : 0
> > siblings        : 2
> > core id         : 1
> > cpu cores       : 2
> > apicid          : 1
> > initial apicid  : 1
> > fpu             : yes
> > fpu_exception   : yes
> > cpuid level     : 10
> > wp              : yes
> > flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
> > cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx lm
> > constant_tsc arch_perfmon pebs bts rep_good nopl aperfmperf pni dtes64
> > monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm lahf_lm ida dtherm
> > tpr_shadow vnmi flexpriority
> > bogomips        : 4787.95
> > clflush size    : 64
> > cache_alignment : 64
> > address sizes   : 36 bits physical, 48 bits virtual
> > power management:
> >
> > Tell me if you need other informations
> > thank you
> 
> Not really.. I have added lists in cc too so that people don't miss this patch.
> Please try the attached patch and see if problem still exists:
> 
> From: Viresh Kumar <viresh.kumar@linaro.org>
> Date: Sun, 1 Sep 2013 22:19:37 +0530
> Subject: [PATCH] cpufreq: check transition status cpufreq_out_of_sync()
> 
> This patch tried to serialize frequency transitions:
> commit 7c30ed532cf798a8d924562f2f44d03d7652f7a7
> Author: Viresh Kumar <viresh.kumar@linaro.org>
> Date:   Wed Jun 19 10:16:55 2013 +0530
> 
>    cpufreq: make sure frequency transitions are serialized
> 
> But there still are few scenarios where notifications can be done in parallel.
> These aren't originated from ->target() but from cpufreq_out_of_sync().
> 
> This causes following crash sometimes:

Please don't call this a crash, especially not in a patch changelog.
That is confusing.  It's better to say "This triggers the following warning
sometimes:".

> WARNING: CPU: 0 PID: 14543 at drivers/cpufreq/cpufreq.c:317
> __cpufreq_notify_transition+0x238/0x260()
> In middle of another frequency transition
> 
> <snip>
> 
> all Trace:
> [<ffffffff81720daa>] dump_stack+0x46/0x58
> [<ffffffff8106534c>] warn_slowpath_common+0x8c/0xc0
> [<ffffffff815b8560>] ? acpi_cpufreq_target+0x320/0x320
> [<ffffffff81065436>] warn_slowpath_fmt+0x46/0x50
> [<ffffffff815b1ec8>] __cpufreq_notify_transition+0x238/0x260
> [<ffffffff815b33be>] cpufreq_notify_transition+0x3e/0x70
> [<ffffffff815b345d>] cpufreq_out_of_sync+0x6d/0xb0
> [<ffffffff815b370c>] cpufreq_update_policy+0x10c/0x160
> [<ffffffff815b3760>] ? cpufreq_update_policy+0x160/0x160
> [<ffffffff81413813>] cpufreq_set_cur_state+0x8c/0xb5
> [<ffffffff814138df>] processor_set_cur_state+0xa3/0xcf
> [<ffffffff8158e13c>] thermal_cdev_update+0x9c/0xb0
> [<ffffffff8159046a>] step_wise_throttle+0x5a/0x90
> [<ffffffff8158e21f>] handle_thermal_trip+0x4f/0x140
> [<ffffffff8158e377>] thermal_zone_device_update+0x57/0xa0
> [<ffffffff81415b36>] acpi_thermal_check+0x2e/0x30
> [<ffffffff81415ca0>] acpi_thermal_notify+0x40/0xdc
> [<ffffffff813e7dbd>] acpi_device_notify+0x19/0x1b
> [<ffffffff813f8241>] acpi_ev_notify_dispatch+0x41/0x5c
> [<ffffffff813e3fbe>] acpi_os_execute_deferred+0x25/0x32
> [<ffffffff81081060>] process_one_work+0x170/0x4a0
> [<ffffffff81082121>] worker_thread+0x121/0x390
> [<ffffffff81082000>] ? manage_workers.isra.20+0x170/0x170
> [<ffffffff81088fe0>] kthread+0xc0/0xd0
> [<ffffffff81088f20>] ? flush_kthread_worker+0xb0/0xb0
> [<ffffffff8173582c>] ret_from_fork+0x7c/0xb0
> [<ffffffff81088f20>] ? flush_kthread_worker+0xb0/0xb0
> 
> This patch modifies cpufreq_out_of_sync() and returns without sending
> notifications in case another transition is in progress. We are anyway going to
> override whatever is the current frequency of cpu, and so we can return from
> here in case another transaction is in progress.
> 
> Reported-by: Alessandro Bono <alessandro.bono@gmail.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index be2e5f4..f6378eb 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1326,6 +1326,14 @@ static void cpufreq_out_of_sync(unsigned int
> cpu, unsigned int old_freq,
>   policy = per_cpu(cpufreq_cpu_data, cpu);
>   read_unlock_irqrestore(&cpufreq_driver_lock, flags);
> 
> + /*
> + * We are anyway going to override whatever is the current frequency of
> + * cpu, and so we can return from here in case another transaction is in
> + * progress
> + */

OK, so first, I think that this transition_ongoing thing needs to be modified
and checked under cpufreq_driver_lock.  Otherwise this code will be racy,
because someone may have updated policy->transition_ongoing after we've read
policy.

Second, in my opinion the comment should say something like "The role of this
function is to make sure that the CPU frequency we use is the same as the
CPU is actually running at.  Therefore, if a CPU frequency change notification
is in progress, it will do the update anyway, so we have nothing to do here in
that case."  Or is it not correct?

> + if (policy->transition_ongoing)
> + return;
> +
>   cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
>   cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
>  }
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
