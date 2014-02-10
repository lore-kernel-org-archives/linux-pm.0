From: poma <pomidorabelisima@gmail.com>
Subject: WARNING: CPU: 1 PID: 0 at kernel/time/tick-broadcast.c:668 tick_broadcast_oneshot_control+0x17d/0x190()
Date: Mon, 10 Feb 2014 04:42:19 +0100
Message-ID: <52F84A9B.5020008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ee0-f49.google.com ([74.125.83.49]:52542 "EHLO
	mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752387AbaBJDmY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 9 Feb 2014 22:42:24 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Cc: linux-pm@vger.kernel.org, Olaf Hering <olaf@aepfle.de>, Dave Jones <davej@redhat.com>, "Justin M. Forbes" <jforbes@redhat.com>, Josh Boyer <jwboyer@redhat.com>, Thomas Gleixner <tglx@linutronix.de>


Let's have one last round of Champions!


[   83.558497] ------------[ cut here ]------------
[   83.558503] WARNING: CPU: 1 PID: 0 at
kernel/time/tick-broadcast.c:668
tick_broadcast_oneshot_control+0x17d/0x190()
[   83.558527] Modules linked in: ipt_MASQUERADE iptable_nat nf_nat_ipv4
nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack
xt_CHECKSUM iptable_mangle fuse ip6table_filter ip6_tables ebtable_nat
ebtables kvm_amd kvm ppdev microcode serio_raw nouveau mxm_wmi video
i2c_algo_bit ttm edac_core edac_mce_amd drm_kms_helper k10temp drm
parport_serial parport_pc parport wmi shpchp i2c_nforce2 i2c_core
acpi_cpufreq nfsd auth_rpcgss nfs_acl lockd sunrpc binfmt_misc
ata_generic pata_acpi pata_amd 8021q garp mrp tun bridge stp llc bonding
[   83.558530] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W
3.14.0-0.rc1.git5.1.fc21.1.x86_64 #1
[   83.558530] Hardware name: Gigabyte Technology Co., Ltd.
M720-US3/M720-US3, BIOS F7n 09/07/2010
[   83.558533]  0000000000000000 184f2fadf588e594 ffff880128bb9dd0
ffffffff817cf05d
[   83.558535]  0000000000000000 ffff880128bb9e08 ffffffff810966cd
0000000000000001
[   83.558536]  0000000000000001 ffff88012a80df00 0000000000000092
ffffffff81c28940
[   83.558537] Call Trace:
[   83.558541]  [<ffffffff817cf05d>] dump_stack+0x4d/0x66
[   83.558544]  [<ffffffff810966cd>] warn_slowpath_common+0x7d/0xa0
[   83.558545]  [<ffffffff810967fa>] warn_slowpath_null+0x1a/0x20
[   83.558547]  [<ffffffff811243dd>]
tick_broadcast_oneshot_control+0x17d/0x190
[   83.558549]  [<ffffffff81122dd8>] clockevents_notify+0x178/0x1a0
[   83.558551]  [<ffffffff81025b17>] amd_e400_idle+0x87/0x130
[   83.558553]  [<ffffffff8102639e>] arch_cpu_idle+0x2e/0x40
[   83.558555]  [<ffffffff8110d375>] cpu_startup_entry+0xf5/0x420
[   83.558558]  [<ffffffff8104dc90>] start_secondary+0x240/0x300
[   83.558559] ---[ end trace d6d150ba17d5207c ]---


https://bugzilla.redhat.com/attachment.cgi?id=861203
https://bugzilla.redhat.com/show_bug.cgi?id=1063108
Also,
https://bugzilla.redhat.com/show_bug.cgi?id=1033310
https://bugzilla.redhat.com/show_bug.cgi?id=1031296
https://bugzilla.redhat.com/show_bug.cgi?id=996973
https://bugzilla.redhat.com/show_bug.cgi?id=989718

>From kernel-3.10 to 3.14,
http://thread.gmane.org/gmane.linux.kernel/1529924
http://thread.gmane.org/gmane.linux.power-management.general/37437


poma


At 600km above planet Earth the temperature
fluctuates between +125 and -100 degrees Celsius

There is nothing to carry sound
No air pressure
No oxygen

Life in space is impossible

LINUX KERNEL LIST


