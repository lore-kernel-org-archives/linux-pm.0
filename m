From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: PM freeze does not work on AT91
Date: Tue, 15 Jul 2014 10:07:09 +0200
Message-ID: <3082229.H5zoEYePBM@ws-stein>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:33928 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756256AbaGOIKP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Jul 2014 04:10:15 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org

Hi,

I tried using the PM features in linux on my at91sam9263 custom board. Using 'echo mem > state' and 'echo standby > mem' works in general. But when using 'echo freeze > state' I get the following oops.

sh-3.2:/sys/power# echo freeze > state
[   22.559000] PM: Syncing filesystems ... done.
[   23.073000] Freezing user space processes ... (elapsed 0.001 seconds) done.
[   23.092000] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
[   23.101000] Unable to handle kernel NULL pointer dereference at virtual address 00000000
[   23.109000] pgd = c283c000
[   23.112000] [00000000] *pgd=23384831, *pte=00000000, *ppte=00000000
[   23.118000] Internal error: Oops: 17 [#1] PREEMPT ARM
[   23.118000] Modules linked in:
[   23.118000] CPU: 0 PID: 106 Comm: sh Not tainted 3.16.0-rc5+ #3
[   23.118000] task: c3369c00 ti: c33e0000 task.ti: c33e0000
[   23.118000] PC is at suspend_devices_and_enter+0x6c/0x32c
[   23.118000] LR is at pm_suspend+0x160/0x27c
[   23.118000] pc : [<c004111c>]    lr : [<c004153c>]    psr: 60000013
[   23.118000] sp : c33e1eb8  ip : 000008e0  fp : 00000000
[   23.118000] r10: c280480c  r9 : c2804800  r8 : 00000007
[   23.118000] r7 : c05527f8  r6 : 00000001  r5 : 00000001  r4 : c056ca00
[   23.118000] r3 : 00000000  r2 : 01ffff3f  r1 : 60000013  r0 : 00000001
[   23.118000] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
[   23.118000] Control: 0005317f  Table: 2283c000  DAC: 00000015
[   23.118000] Process sh (pid: 106, stack limit = 0xc33e01c0)
[   23.118000] Stack: (0xc33e1eb8 to 0xc33e2000)
[   23.118000] 1ea0:                                                       00000000 c0391454
[   23.118000] 1ec0: c049e549 c33e1edc 60000013 c33e1edc 00000000 c056ca00 00000000 00000001
[   23.118000] 1ee0: c05527f8 00000007 c2804800 c004153c c055e2bc c3064000 00000007 c282a0c0
[   23.118000] 1f00: c33e1f80 c0040304 c3064000 c282a0c0 c282a0c0 c01abd94 00000007 c00f0e54
[   23.118000] 1f20: c00f0e18 00000000 00000000 c00f0050 00000000 00000000 c33c93c0 b6fa6000
[   23.118000] 1f40: c33e1f80 00000007 00000007 b6fa6000 00000000 c009a19c c33c93c0 b6fa6000
[   23.118000] 1f60: 00000007 00000000 00000000 c33c93c0 c33c93c0 00000007 b6fa6000 c009a70c
[   23.118000] 1f80: 00000000 00000000 00000007 00000007 b6fa6000 b6f76b38 00000004 c0009764
[   23.118000] 1fa0: c33e0000 c0009600 00000007 b6fa6000 00000001 b6fa6000 00000007 00000000
[   23.118000] 1fc0: 00000007 b6fa6000 b6f76b38 00000004 00000007 b6fa6000 00000007 00000000
[   23.118000] 1fe0: 00000000 be83ba9c b6eaeadc b6f0317c 60000010 00000001 00000000 00000000
[   23.118000] [<c004111c>] (suspend_devices_and_enter) from [<c004153c>] (pm_suspend+0x160/0x27c)
[   23.118000] [<c004153c>] (pm_suspend) from [<c0040304>] (state_store+0x40/0x68)
[   23.118000] [<c0040304>] (state_store) from [<c01abd94>] (kobj_attr_store+0x14/0x20)
[   23.118000] [<c01abd94>] (kobj_attr_store) from [<c00f0e54>] (sysfs_kf_write+0x3c/0x48)
[   23.118000] [<c00f0e54>] (sysfs_kf_write) from [<c00f0050>] (kernfs_fop_write+0x100/0x158)
[   23.118000] [<c00f0050>] (kernfs_fop_write) from [<c009a19c>] (vfs_write+0xb4/0x188)
[   23.118000] [<c009a19c>] (vfs_write) from [<c009a70c>] (SyS_write+0x3c/0x7c)
[   23.118000] [<c009a70c>] (SyS_write) from [<c0009600>] (ret_fast_syscall+0x0/0x2c)
[   23.118000] Code: eafffff3 1afffff2 e59f32ac e5933008 (e5933000)
[   23.358000] ---[ end trace 9206ef60cdd758d9 ]---

The systems hangs here now.
It seems that freeze_ops is used without beeing checked if non-NULL. Unfortunately the attached doesn't work. The system freezes but it cannot be woken up, e.g. with attached GPIO keys. The latter works when using mem or standby.
AFAICS only ACPI based systems support those freeze ops, maybe it is reasonable to restrict freeze to those systems?

Best regards,
Alexander

