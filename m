From: Robert =?ISO-8859-1?Q?Sch=F6ne?= <robert.schoene@tu-dresden.de>
Subject: PROBLEM: Kernel OOPS and possible system freeze after concurrent
 writing to cpufreq/scaling_governor (Resend)
Date: Thu, 24 Jul 2014 09:11:52 +0200
Message-ID: <1406185912.2406.3.camel@x200t>
References: <1405522398.2348.42.camel@x200t>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.zih.tu-dresden.de ([141.30.67.73]:34139 "EHLO
	mailout2.zih.tu-dresden.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934061AbaGXHMD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 24 Jul 2014 03:12:03 -0400
In-Reply-To: <1405522398.2348.42.camel@x200t>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org

(Resend, because there hasn't been a reply within the last week)

1. Summary:
When two or more processes concurrently activate the ondemand governor, Linux might crash.

2. Problem:
When I write concurrently to the cpufreq sysfs scaling_governor files, the kernel gives me first a warning and as a follow-up multiple oops'. Afterwards several systems within the kernel fail and I have to reboot the system. While the bug report is based on the current Ubuntu kernel (3.13.0-27-generic), it also appears on the latest mainline (3.16-rc5). However, I only managed to get the kernel log from the older Ubuntu kernel.


3. Keywords: cpufreq, governor, policy, ondemand

4. Kernel Version
Linux version 3.13.0-27-generic (buildd@akateko) (gcc version 4.8.2 (Ubuntu 4.8.2-19ubuntu1) ) #50-Ubuntu SMP Thu May 15 18:06:16 UTC 2014

5. Warning message, followed by OOPS messages:

Jul 16 09:47:39 basti kernel: [  398.441455] ------------[ cut here ]------------
Jul 16 09:47:39 basti kernel: [  398.441462] WARNING: CPU: 5 PID: 4263 at /build/buildd/linux-3.13.0/drivers/cpufreq/cpufreq_governor.c:203 cpufreq_governor_dbs+0x682/0x6f0()
Jul 16 09:47:39 basti kernel: [  398.441494] Modules linked in: vtsspp(OF) sep3_15(OF) pax(OF) apwr3_1(OF) nfsv3 rfcomm bnep bluetooth binfmt_misc nfsd auth_rpcgss nfs_acl nfs lockd sunrpc fscache snd_hda_codec_hdmi snd_hda_codec_conexant ppdev gpio_ich intel_rapl x86_pkg
_temp_thermal intel_powerclamp coretemp kvm_intel kvm crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel aes_x86_64 lrw gf128mul glue_helper ablk_helper cryptd parport_pc serio_raw snd_hda_intel snd_hda_codec i915 snd_hwdep lpc_ich snd_pcm video drm_kms_helper 
tpm_infineon drm snd_page_alloc mei_me snd_timer mei snd i2c_algo_bit soundcore mac_hid lp parport e1000e ahci psmouse libahci ptp pps_core
Jul 16 09:47:39 basti kernel: [  398.441496] CPU: 5 PID: 4263 Comm: tee Tainted: GF          O 3.13.0-27-generic #50-Ubuntu
Jul 16 09:47:39 basti kernel: [  398.441497] Hardware name: FUJITSU ESPRIMO P700/D3061-A1, BIOS V4.6.4.0 R1.12.0 for D3061-A1x 07/04/2011
Jul 16 09:47:39 basti kernel: [  398.441500]  0000000000000009 ffff8800b3081bc0 ffffffff817199c4 0000000000000000
Jul 16 09:47:39 basti kernel: [  398.441502]  ffff8800b3081bf8 ffffffff810676bd 0000000000000000 ffff88022ebb4e00
Jul 16 09:47:39 basti kernel: [  398.441504]  0000000000000004 0000000000000002 ffffffff81cd3ae0 ffff8800b3081c08
Jul 16 09:47:39 basti kernel: [  398.441504] Call Trace:
Jul 16 09:47:39 basti kernel: [  398.441509]  [<ffffffff817199c4>] dump_stack+0x45/0x56
Jul 16 09:47:39 basti kernel: [  398.441512]  [<ffffffff810676bd>] warn_slowpath_common+0x7d/0xa0
Jul 16 09:47:39 basti kernel: [  398.441513]  [<ffffffff8106779a>] warn_slowpath_null+0x1a/0x20
Jul 16 09:47:39 basti kernel: [  398.441515]  [<ffffffff815c7142>] cpufreq_governor_dbs+0x682/0x6f0
Jul 16 09:47:39 basti kernel: [  398.441518]  [<ffffffff81725ebc>] ? notifier_call_chain+0x4c/0x70
Jul 16 09:47:39 basti kernel: [  398.441520]  [<ffffffff815c4fc7>] od_cpufreq_governor_dbs+0x17/0x20
Jul 16 09:47:39 basti kernel: [  398.441522]  [<ffffffff815c10cd>] __cpufreq_governor+0xfd/0x230
Jul 16 09:47:39 basti kernel: [  398.441524]  [<ffffffff815c1349>] cpufreq_set_policy+0x149/0x2e0
Jul 16 09:47:39 basti kernel: [  398.441526]  [<ffffffff815c28bd>] store_scaling_governor+0xad/0xf0
Jul 16 09:47:39 basti kernel: [  398.441527]  [<ffffffff815c2260>] ? cpufreq_update_policy+0x170/0x170
Jul 16 09:47:39 basti kernel: [  398.441529]  [<ffffffff815c1a19>] store+0x79/0xc0
Jul 16 09:47:39 basti kernel: [  398.441532]  [<ffffffff812325b8>] sysfs_write_file+0x128/0x1c0
Jul 16 09:47:39 basti kernel: [  398.441534]  [<ffffffff811bc664>] vfs_write+0xb4/0x1f0
Jul 16 09:47:39 basti kernel: [  398.441536]  [<ffffffff811bd099>] SyS_write+0x49/0xa0
Jul 16 09:47:39 basti kernel: [  398.441539]  [<ffffffff8172a5bf>] tracesys+0xe1/0xe6
Jul 16 09:47:39 basti kernel: [  398.441540] ---[ end trace 9a9b0afb92b8c41f ]---
Jul 16 09:47:39 basti kernel: [  398.441545] BUG: unable to handle kernel NULL pointer dereference at           (null)
Jul 16 09:47:39 basti kernel: [  398.441547] IP: [<ffffffff815c6b12>] cpufreq_governor_dbs+0x52/0x6f0
Jul 16 09:47:39 basti kernel: [  398.441549] PGD b39cc067 PUD b30cb067 PMD 0 
Jul 16 09:47:39 basti kernel: [  398.441550] Oops: 0000 [#1] SMP 
Jul 16 09:47:39 basti kernel: [  398.441571] Modules linked in: vtsspp(OF) sep3_15(OF) pax(OF) apwr3_1(OF) nfsv3 rfcomm bnep bluetooth binfmt_misc nfsd auth_rpcgss nfs_acl nfs lockd sunrpc fscache snd_hda_codec_hdmi snd_hda_codec_conexant ppdev gpio_ich intel_rapl x86_pkg
_temp_thermal intel_powerclamp coretemp kvm_intel kvm crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel aes_x86_64 lrw gf128mul glue_helper ablk_helper cryptd parport_pc serio_raw snd_hda_intel snd_hda_codec i915 snd_hwdep lpc_ich snd_pcm video drm_kms_helper 
tpm_infineon drm snd_page_alloc mei_me snd_timer mei snd i2c_algo_bit soundcore mac_hid lp parport e1000e ahci psmouse libahci ptp pps_core
Jul 16 09:47:39 basti kernel: [  398.441573] CPU: 5 PID: 4263 Comm: tee Tainted: GF       W  O 3.13.0-27-generic #50-Ubuntu
Jul 16 09:47:39 basti kernel: [  398.441573] Hardware name: FUJITSU ESPRIMO P700/D3061-A1, BIOS V4.6.4.0 R1.12.0 for D3061-A1x 07/04/2011
Jul 16 09:47:39 basti kernel: [  398.441574] task: ffff88022e5f17f0 ti: ffff8800b3080000 task.ti: ffff8800b3080000
Jul 16 09:47:39 basti kernel: [  398.441576] RIP: 0010:[<ffffffff815c6b12>]  [<ffffffff815c6b12>] cpufreq_governor_dbs+0x52/0x6f0
Jul 16 09:47:39 basti kernel: [  398.441577] RSP: 0018:ffff8800b3081c18  EFLAGS: 00010293
Jul 16 09:47:39 basti kernel: [  398.441577] RAX: 0000000000000024 RBX: 0000000000000000 RCX: 00000000000096aa
Jul 16 09:47:39 basti kernel: [  398.441578] RDX: 0000000096aa96aa RSI: 0000000000000000 RDI: 0000000000000009
Jul 16 09:47:39 basti kernel: [  398.441579] RBP: ffff8800b3081c88 R08: 0000000000000082 R09: ffffffff81ecdd30
Jul 16 09:47:39 basti kernel: [  398.441579] R10: 000000000002f8a0 R11: 0000000000040000 R12: ffff88022ebb4e00
Jul 16 09:47:39 basti kernel: [  398.441580] R13: 0000000000000004 R14: 0000000000000002 R15: ffffffff81cd3ae0
Jul 16 09:47:39 basti kernel: [  398.441580] FS:  00002b53b77acb80(0000) GS:ffff88023e340000(0000) knlGS:0000000000000000
Jul 16 09:47:39 basti kernel: [  398.441581] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Jul 16 09:47:39 basti kernel: [  398.441582] CR2: 0000000000000000 CR3: 00000000b395c000 CR4: 00000000000407e0
Jul 16 09:47:39 basti kernel: [  398.441582] Stack:
Jul 16 09:47:39 basti kernel: [  398.441583]  0000000000000000 0000000000000002 ffff8800b3081d00 0000000000000000
Jul 16 09:47:39 basti kernel: [  398.441584]  ffff8800b3081c70 ffffffff81725ebc ffffffff81cd3520 0000000000000000
Jul 16 09:47:39 basti kernel: [  398.441586]  0000000000000002 ffff88022ebb4e00 0000000000000002 ffffffff81cd3b40
Jul 16 09:47:39 basti kernel: [  398.441586] Call Trace:
Jul 16 09:47:39 basti kernel: [  398.441587]  [<ffffffff81725ebc>] ? notifier_call_chain+0x4c/0x70
Jul 16 09:47:39 basti kernel: [  398.441589]  [<ffffffff815c4fc7>] od_cpufreq_governor_dbs+0x17/0x20
Jul 16 09:47:39 basti kernel: [  398.441590]  [<ffffffff815c10cd>] __cpufreq_governor+0xfd/0x230
Jul 16 09:47:39 basti kernel: [  398.441591]  [<ffffffff815c1349>] cpufreq_set_policy+0x149/0x2e0
Jul 16 09:47:39 basti kernel: [  398.441592]  [<ffffffff815c28bd>] store_scaling_governor+0xad/0xf0
Jul 16 09:47:39 basti kernel: [  398.441593]  [<ffffffff815c2260>] ? cpufreq_update_policy+0x170/0x170
Jul 16 09:47:39 basti kernel: [  398.441594]  [<ffffffff815c1a19>] store+0x79/0xc0
Jul 16 09:47:39 basti kernel: [  398.441595]  [<ffffffff812325b8>] sysfs_write_file+0x128/0x1c0
Jul 16 09:47:39 basti kernel: [  398.441597]  [<ffffffff811bc664>] vfs_write+0xb4/0x1f0
Jul 16 09:47:39 basti kernel: [  398.441600]  [<ffffffff811bd099>] SyS_write+0x49/0xa0
Jul 16 09:47:39 basti kernel: [  398.441601]  [<ffffffff8172a5bf>] tracesys+0xe1/0xe6
Jul 16 09:47:39 basti kernel: [  398.441611] Code: ff 84 c0 0f 84 40 02 00 00 49 8b 5c 24 70 48 85 db 0f 84 29 06 00 00 41 83 fe 04 0f 84 60 02 00 00 41 83 fe 05 0f 84 2e 02 00 00 <48> 8b 03 44 89 ef ff 50 20 48 89 45 c0 48 8b 03 83 38 01 0f 84 
Jul 16 09:47:39 basti kernel: [  398.441612] RIP  [<ffffffff815c6b12>] cpufreq_governor_dbs+0x52/0x6f0
Jul 16 09:47:39 basti kernel: [  398.441613]  RSP <ffff8800b3081c18>
Jul 16 09:47:39 basti kernel: [  398.441613] CR2: 0000000000000000
Jul 16 09:47:39 basti kernel: [  398.441615] ---[ end trace 9a9b0afb92b8c420 ]---
Jul 16 09:47:39 basti kernel: [  398.444572] general protection fault: 0000 [#2] SMP 
Jul 16 09:47:39 basti kernel: [  398.444628] Modules linked in: vtsspp(OF) sep3_15(OF) pax(OF) apwr3_1(OF) nfsv3 rfcomm bnep bluetooth binfmt_misc nfsd auth_rpcgss nfs_acl nfs lockd sunrpc fscache snd_hda_codec_hdmi snd_hda_codec_conexant ppdev gpio_ich intel_rapl x86_pkg
_temp_thermal intel_powerclamp coretemp kvm_intel kvm crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel aes_x86_64 lrw gf128mul glue_helper ablk_helper cryptd parport_pc serio_raw snd_hda_intel snd_hda_codec i915 snd_hwdep lpc_ich snd_pcm video drm_kms_helper tpm_infineon drm snd_page_alloc mei_me snd_timer mei snd i2c_algo_bit soundcore mac_hid lp parport e1000e ahci psmouse libahci ptp pps_core
Jul 16 09:47:39 basti kernel: [  398.444629] CPU: 4 PID: 126 Comm: kworker/4:1 Tainted: GF     D W  O 3.13.0-27-generic #50-Ubuntu
Jul 16 09:47:39 basti kernel: [  398.444630] Hardware name: FUJITSU ESPRIMO P700/D3061-A1, BIOS V4.6.4.0 R1.12.0 for D3061-A1x 07/04/2011
Jul 16 09:47:39 basti kernel: [  398.444633] Workqueue: events od_dbs_timer
Jul 16 09:47:39 basti kernel: [  398.444634] task: ffff88022e5a97f0 ti: ffff88022e69e000 task.ti: ffff88022e69e000
Jul 16 09:47:39 basti kernel: [  398.444636] RIP: 0010:[<ffffffff815c5957>]  [<ffffffff815c5957>] od_dbs_timer+0x57/0x160
Jul 16 09:47:39 basti kernel: [  398.444636] RSP: 0000:ffff88022e69fde8  EFLAGS: 00010246
Jul 16 09:47:39 basti kernel: [  398.444637] RAX: ffff88022e5a97f0 RBX: ffff88023e310e20 RCX: 0000000000000004
Jul 16 09:47:39 basti kernel: [  398.444637] RDX: 0000000000000004 RSI: 00000000170e170c RDI: ffff88023e310ec8
Jul 16 09:47:39 basti kernel: [  398.444638] RBP: ffff88022e69fe20 R08: 2008f8c439200000 R09: 7240000000000000
Jul 16 09:47:39 basti kernel: [  398.444638] R10: dff68f3e05110e48 R11: 0000000000000004 R12: 0000000000000000
Jul 16 09:47:39 basti kernel: [  398.444639] R13: ffff880231144b80 R14: ffff88023e310e48 R15: dead000000100100
Jul 16 09:47:39 basti kernel: [  398.444640] FS:  0000000000000000(0000) GS:ffff88023e300000(0000) knlGS:0000000000000000
Jul 16 09:47:39 basti kernel: [  398.444640] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Jul 16 09:47:39 basti kernel: [  398.444641] CR2: 00002b8959f3f1f0 CR3: 000000022e68f000 CR4: 00000000000407e0
Jul 16 09:47:39 basti kernel: [  398.444641] Stack:
Jul 16 09:47:39 basti kernel: [  398.444643]  000000042e61f700 ffff88023e310ec8 ffff88022eb3c800 ffff88023e313cc0
Jul 16 09:47:39 basti kernel: [  398.444644]  ffff88023e310e48 0000000000000000 0000000000000100 ffff88022e69fe68
Jul 16 09:47:39 basti kernel: [  398.444645]  ffffffff810838a2 000000003e313cd8 ffff88023e317e00 ffff88023e313cd8
Jul 16 09:47:39 basti kernel: [  398.444645] Call Trace:
Jul 16 09:47:39 basti kernel: [  398.444649]  [<ffffffff810838a2>] process_one_work+0x182/0x450
Jul 16 09:47:39 basti kernel: [  398.444651]  [<ffffffff81084641>] worker_thread+0x121/0x410
Jul 16 09:47:39 basti kernel: [  398.444652]  [<ffffffff81084520>] ? rescuer_thread+0x3e0/0x3e0
Jul 16 09:47:39 basti kernel: [  398.444654]  [<ffffffff8108b312>] kthread+0xd2/0xf0
Jul 16 09:47:39 basti kernel: [  398.444655]  [<ffffffff8108b240>] ? kthread_create_on_node+0x1d0/0x1d0
Jul 16 09:47:39 basti kernel: [  398.444658]  [<ffffffff8172a2fc>] ret_from_fork+0x7c/0xb0
Jul 16 09:47:39 basti kernel: [  398.444659]  [<ffffffff8108b240>] ? kthread_create_on_node+0x1d0/0x1d0
Jul 16 09:47:39 basti kernel: [  398.444668] Code: d1 4d 8b 7d 10 89 55 cc 48 03 1c cd 60 28 d1 81 48 8d 83 a8 00 00 00 44 0f b6 a3 f0 00 00 00 48 89 c7 48 89 45 d0 e8 99 a8 15 00 <41> 8b 77 04 48 89 df 41 83 e4 01 e8 19 10 00 00 84 c0 8b 55 cc 
Jul 16 09:47:39 basti kernel: [  398.444670] RIP  [<ffffffff815c5957>] od_dbs_timer+0x57/0x160
Jul 16 09:47:39 basti kernel: [  398.444670]  RSP <ffff88022e69fde8>
Jul 16 09:47:39 basti kernel: [  398.444671] ---[ end trace 9a9b0afb92b8c421 ]---
Jul 16 09:47:39 basti kernel: [  398.444703] BUG: unable to handle kernel paging request at ffffffffffffffd8
Jul 16 09:47:39 basti kernel: [  398.444706] IP: [<ffffffff8108b9b0>] kthread_data+0x10/0x20
Jul 16 09:47:39 basti kernel: [  398.444710] PGD 1c11067 PUD 1c13067 PMD 0 
Jul 16 09:47:39 basti kernel: [  398.444713] Oops: 0000 [#3] SMP 
Jul 16 09:47:39 basti kernel: [  398.444725] Modules linked in: vtsspp(OF) sep3_15(OF) pax(OF) apwr3_1(OF) nfsv3 rfcomm bnep bluetooth binfmt_misc nfsd auth_rpcgss nfs_acl nfs lockd sunrpc fscache snd_hda_codec_hdmi snd_hda_codec_conexant ppdev gpio_ich intel_rapl x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel aes_x86_64 lrw gf128mul glue_helper ablk_helper cryptd parport_pc serio_raw snd_hda_intel snd_hda_codec i915 snd_hwdep lpc_ich snd_pcm video drm_kms_helper tpm_infineon drm snd_page_alloc mei_me snd_timer mei snd i2c_algo_bit soundcore mac_hid lp parport e1000e ahci psmouse libahci ptp pps_core
Jul 16 09:47:39 basti kernel: [  398.444726] CPU: 4 PID: 126 Comm: kworker/4:1 Tainted: GF     D W  O 3.13.0-27-generic #50-Ubuntu
Jul 16 09:47:39 basti kernel: [  398.444727] Hardware name: FUJITSU ESPRIMO P700/D3061-A1, BIOS V4.6.4.0 R1.12.0 for D3061-A1x 07/04/2011
Jul 16 09:47:39 basti kernel: [  398.444732] task: ffff88022e5a97f0 ti: ffff88022e69e000 task.ti: ffff88022e69e000
Jul 16 09:47:39 basti kernel: [  398.444733] RIP: 0010:[<ffffffff8108b9b0>]  [<ffffffff8108b9b0>] kthread_data+0x10/0x20
Jul 16 09:47:39 basti kernel: [  398.444734] RSP: 0000:ffff88022e69fba0  EFLAGS: 00010002
Jul 16 09:47:39 basti kernel: [  398.444734] RAX: 0000000000000000 RBX: 0000000000000004 RCX: 000000000000000d
Jul 16 09:47:39 basti kernel: [  398.444735] RDX: 0000000000000005 RSI: 0000000000000004 RDI: ffff88022e5a97f0
Jul 16 09:47:39 basti kernel: [  398.444735] RBP: ffff88022e69fba0 R08: 0000000000000000 R09: 0000000000000000
Jul 16 09:47:39 basti kernel: [  398.444736] R10: ffffffff8106518c R11: ffffea0008c99800 R12: ffff88023e314440
Jul 16 09:47:39 basti kernel: [  398.444736] R13: 0000000000000004 R14: ffff88022e5a97e0 R15: ffff88022e5a97f0
Jul 16 09:47:39 basti kernel: [  398.444738] FS:  0000000000000000(0000) GS:ffff88023e300000(0000) knlGS:0000000000000000
Jul 16 09:47:39 basti kernel: [  398.444740] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Jul 16 09:47:39 basti kernel: [  398.444741] CR2: 0000000000000028 CR3: 000000022e68f000 CR4: 00000000000407e0
Jul 16 09:47:39 basti kernel: [  398.444742] Stack:
Jul 16 09:47:39 basti kernel: [  398.444748]  ffff88022e69fbb8 ffffffff81084d51 ffff88022e5a97f0 ffff88022e69fc18
Jul 16 09:47:39 basti kernel: [  398.444753]  ffffffff8171db79 ffff88022e5a97f0 ffff88022e69ffd8 0000000000014440
Jul 16 09:47:39 basti kernel: [  398.444757]  0000000000014440 ffff88022e5a97f0 ffff88022e5a9e28 ffff88022e5a97e0
Jul 16 09:47:39 basti kernel: [  398.444757] Call Trace:
Jul 16 09:47:39 basti kernel: [  398.444759]  [<ffffffff81084d51>] wq_worker_sleeping+0x11/0x90
Jul 16 09:47:39 basti kernel: [  398.444761]  [<ffffffff8171db79>] __schedule+0x589/0x7d0
Jul 16 09:47:39 basti kernel: [  398.444762]  [<ffffffff8171dde9>] schedule+0x29/0x70
Jul 16 09:47:39 basti kernel: [  398.444764]  [<ffffffff8106a02f>] do_exit+0x6df/0xa50
Jul 16 09:47:39 basti kernel: [  398.444765]  [<ffffffff81722e79>] oops_end+0xa9/0x150
Jul 16 09:47:39 basti kernel: [  398.444767]  [<ffffffff810171cb>] die+0x4b/0x70
Jul 16 09:47:39 basti kernel: [  398.444768]  [<ffffffff8172280e>] do_general_protection+0x11e/0x1b0
Jul 16 09:47:39 basti kernel: [  398.444770]  [<ffffffff81722128>] general_protection+0x28/0x30
Jul 16 09:47:39 basti kernel: [  398.444773]  [<ffffffff815c5957>] ? od_dbs_timer+0x57/0x160
Jul 16 09:47:39 basti kernel: [  398.444776]  [<ffffffff815c5957>] ? od_dbs_timer+0x57/0x160
Jul 16 09:47:39 basti kernel: [  398.444779]  [<ffffffff810838a2>] process_one_work+0x182/0x450
Jul 16 09:47:39 basti kernel: [  398.444781]  [<ffffffff81084641>] worker_thread+0x121/0x410
Jul 16 09:47:39 basti kernel: [  398.444784]  [<ffffffff81084520>] ? rescuer_thread+0x3e0/0x3e0
Jul 16 09:47:39 basti kernel: [  398.444787]  [<ffffffff8108b312>] kthread+0xd2/0xf0
Jul 16 09:47:39 basti kernel: [  398.444790]  [<ffffffff8108b240>] ? kthread_create_on_node+0x1d0/0x1d0
Jul 16 09:47:39 basti kernel: [  398.444793]  [<ffffffff8172a2fc>] ret_from_fork+0x7c/0xb0
Jul 16 09:47:39 basti kernel: [  398.444795]  [<ffffffff8108b240>] ? kthread_create_on_node+0x1d0/0x1d0
Jul 16 09:47:39 basti kernel: [  398.444806] Code: 00 48 89 e5 5d 48 8b 40 c8 48 c1 e8 02 83 e0 01 c3 66 2e 0f 1f 84 00 00 00 00 00 66 66 66 66 90 48 8b 87 a8 03 00 00 55 48 89 e5 <48> 8b 40 d8 5d c3 66 2e 0f 1f 84 00 00 00 00 00 66 66 66 66 90 
Jul 16 09:47:39 basti kernel: [  398.444807]  RSP <ffff88022e69fba0>
Jul 16 09:47:39 basti kernel: [  398.444808] CR2: ffffffffffffffd8
Jul 16 09:47:39 basti kernel: [  398.444808] ---[ end trace 9a9b0afb92b8c422 ]---
Jul 16 09:47:39 basti kernel: [  398.444808] Fixing recursive fault but reboot is needed!

6. Two small shell script to trigger the bug (on an 8 CPU machine)

crash_governor.sh:
#!/bin/sh
# this is called concurrently via runme.sh
for I in `seq 1000`
do
	echo ondemand | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
	echo userspace | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
done

runme.sh:
#!/bin/sh
# run 8 concurrent instances
for I in `seq 8`
do
	./crash_governor.sh &
done

Just run runme.sh and crash your system :)

7. Environment
7.1. ver_linux

Linux basti 3.13.0-27-generic #50-Ubuntu SMP Thu May 15 18:06:16 UTC 2014 x86_64 x86_64 x86_64 GNU/Linux
 
Gnu C                  4.8
Gnu make               3.81
binutils               2.24
util-linux             2.20.1
mount                  support
module-init-tools      15
e2fsprogs              1.42.9
Linux C Library        2.19
Dynamic linker (ldd)   2.19
Procps                 3.3.9
Net-tools              1.60
Kbd                    1.15.5
Sh-utils               8.21
wireless-tools         30
Modules Loaded         sep3_15 pax apwr3_1 nfsv3 rfcomm bnep bluetooth binfmt_misc nfsd auth_rpcgss nfs_acl nfs lockd sunrpc fscache snd_hda_codec_hdmi snd_hda_codec_conexant gpio_ich intel_rapl x86_pkg_temp_thermal intel_powerclamp coretemp ppdev kvm_intel kvm crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel aes_x86_64 lrw gf128mul glue_helper ablk_helper cryptd parport_pc snd_hda_intel snd_hda_codec serio_raw i915 snd_hwdep snd_pcm video snd_page_alloc tpm_infineon drm_kms_helper snd_timer drm snd lpc_ich soundcore mei_me mac_hid mei i2c_algo_bit lp parport e1000e psmouse ahci ptp libahci pps_core

7.2. /proc/cpuinfo (first out of 8 CPUs (4 cores plus hyper threading))
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 42
model name	: Intel(R) Core(TM) i7-2600 CPU @ 3.40GHz
stepping	: 7
microcode	: 0x18
cpu MHz		: 1600.000
cache size	: 8192 KB
physical id	: 0
siblings	: 8
core id		: 0
cpu cores	: 4
apicid		: 0
initial apicid	: 0
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx lahf_lm ida arat epb xsaveopt pln pts dtherm tpr_shadow vnmi flexpriority ept vpid
bogomips	: 6782.74
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

7.3. /proc/modules
sep3_15 517400 0 - Live 0x0000000000000000 (OF)
pax 13181 0 - Live 0x0000000000000000 (OF)
apwr3_1 56811 0 - Live 0x0000000000000000 (OF)
nfsv3 39326 1 - Live 0x0000000000000000
rfcomm 69160 0 - Live 0x0000000000000000
bnep 19624 2 - Live 0x0000000000000000
bluetooth 395423 10 rfcomm,bnep, Live 0x0000000000000000
binfmt_misc 17468 1 - Live 0x0000000000000000
nfsd 280297 2 - Live 0x0000000000000000
auth_rpcgss 59338 1 nfsd, Live 0x0000000000000000
nfs_acl 12837 2 nfsv3,nfsd, Live 0x0000000000000000
nfs 236636 2 nfsv3, Live 0x0000000000000000
lockd 93977 3 nfsv3,nfsd,nfs, Live 0x0000000000000000
sunrpc 284404 21 nfsv3,nfsd,auth_rpcgss,nfs_acl,nfs,lockd, Live 0x0000000000000000
fscache 63988 1 nfs, Live 0x0000000000000000
snd_hda_codec_hdmi 46207 1 - Live 0x0000000000000000
snd_hda_codec_conexant 57441 1 - Live 0x0000000000000000
gpio_ich 13476 0 - Live 0x0000000000000000
intel_rapl 18773 0 - Live 0x0000000000000000
x86_pkg_temp_thermal 14205 0 - Live 0x0000000000000000
intel_powerclamp 14705 0 - Live 0x0000000000000000
coretemp 13435 0 - Live 0x0000000000000000
ppdev 17671 0 - Live 0x0000000000000000
kvm_intel 143060 0 - Live 0x0000000000000000
kvm 451511 1 kvm_intel, Live 0x0000000000000000
crct10dif_pclmul 14289 0 - Live 0x0000000000000000
crc32_pclmul 13113 0 - Live 0x0000000000000000
ghash_clmulni_intel 13216 0 - Live 0x0000000000000000
aesni_intel 55624 0 - Live 0x0000000000000000
aes_x86_64 17131 1 aesni_intel, Live 0x0000000000000000
lrw 13286 1 aesni_intel, Live 0x0000000000000000
gf128mul 14951 1 lrw, Live 0x0000000000000000
glue_helper 13990 1 aesni_intel, Live 0x0000000000000000
ablk_helper 13597 1 aesni_intel, Live 0x0000000000000000
cryptd 20359 3 ghash_clmulni_intel,aesni_intel,ablk_helper, Live 0x0000000000000000
parport_pc 32701 1 - Live 0x0000000000000000
snd_hda_intel 52355 0 - Live 0x0000000000000000
snd_hda_codec 192906 3 snd_hda_codec_hdmi,snd_hda_codec_conexant,snd_hda_intel, Live 0x0000000000000000
serio_raw 13462 0 - Live 0x0000000000000000
i915 783485 1 - Live 0x0000000000000000
snd_hwdep 13602 1 snd_hda_codec, Live 0x0000000000000000
snd_pcm 102099 3 snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec, Live 0x0000000000000000
video 19476 1 i915, Live 0x0000000000000000
snd_page_alloc 18710 2 snd_hda_intel,snd_pcm, Live 0x0000000000000000
tpm_infineon 17372 0 - Live 0x0000000000000000
drm_kms_helper 52758 1 i915, Live 0x0000000000000000
snd_timer 29482 1 snd_pcm, Live 0x0000000000000000
drm 302817 2 i915,drm_kms_helper, Live 0x0000000000000000
snd 69238 7 snd_hda_codec_hdmi,snd_hda_codec_conexant,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_timer, Live 0x0000000000000000
lpc_ich 21080 0 - Live 0x0000000000000000
soundcore 12680 1 snd, Live 0x0000000000000000
mei_me 18627 0 - Live 0x0000000000000000
mac_hid 13205 0 - Live 0x0000000000000000
mei 82274 1 mei_me, Live 0x0000000000000000
i2c_algo_bit 13413 1 i915, Live 0x0000000000000000
lp 17759 0 - Live 0x0000000000000000
parport 42348 3 ppdev,parport_pc,lp, Live 0x0000000000000000
e1000e 254433 0 - Live 0x0000000000000000
psmouse 102222 0 - Live 0x0000000000000000
ahci 25819 2 - Live 0x0000000000000000
ptp 18933 1 e1000e, Live 0x0000000000000000
libahci 32168 1 ahci, Live 0x0000000000000000
pps_core 19382 1 ptp, Live 0x0000000000000000


-- 

Dipl.-Inf. Robert Schoene
Computer Scientist - R&D Energy Efficient Computing

Technische Universitaet Dresden
Center for Information Services and High Performance Computing
Distributed and Data Intensive Computing
01062 Dresden
Tel.: +49 (351) 463-42483
Fax : +49 (351) 463-37773
E-Mail: Robert.Schoene@tu-dresden.de



