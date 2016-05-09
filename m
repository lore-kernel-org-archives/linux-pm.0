From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: ARM: mxs: STI: console can't wake up from freeze
Date: Mon, 9 May 2016 22:49:36 +0200 (CEST)
Message-ID: <1474284101.292364.2298f4ae-2c4a-4dbb-9e38-0a6190db0f92.open-xchange@email.1und1.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:49250 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751447AbcEIUuR (ORCPT
	<rfc822;Linux-pm@vger.kernel.org>); Mon, 9 May 2016 16:50:17 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: fabio.estevam@nxp.com, marex@denx.de
Cc: Linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, joerg.krause@embedded.rocks

Hi,

i'm faced with the issue that on i.MX28 the console is unable to wake up from
freeze ( suspend to idle). I tested it with Linux 3.18 and 4.5 ( cmdline has
no_console_suspend=1 ) and also with a i.MX23 with the same result. The suspend
seems to work, but there is no reaction to the console after the freeze.
Strangely the suspend to RAM from console and using freeze in combination with
pm_test works without any issues.

Any ideas to narrow down the problem?

Here is the console output:

root@duckbill:~# echo freeze > /sys/power/state 
[   54.163568] PM: Syncing filesystems ... done.
[   57.916487] Freezing user space processes ... (elapsed 0.007 seconds) done.
[   57.930987] Freezing remaining freezable tasks ... (elapsed 0.004 seconds)
done.
[   57.970490] PM: suspend of devices complete after 22.813 msecs
[   57.983052] PM: late suspend of devices complete after 6.480 msecs
[   57.997832] PM: noirq suspend of devices complete after 8.500 msecs
[  240.633397] INFO: task ext4lazyinit:73 blocked for more than 120 seconds.
[  240.640245]       Not tainted 3.18.0-01974-gb2776bf #12
[  240.645639] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
message.
[  240.653619] ext4lazyinit    D c0511a80     0    73      2 0x00000000
[  240.660147] [<c0511a80>] (__schedule) from [<c05153c0>]
(schedule_timeout+0x138/0x1e4)
[  240.668265] [<c05153c0>] (schedule_timeout) from [<c05117bc>]
(io_schedule_timeout+0x94/0xfc)
[  240.676983] [<c05117bc>] (io_schedule_timeout) from [<c0512b10>]
(T.312+0x9c/0x120)
[  240.684848] [<c0512b10>] (T.312) from [<c02a9138>]
(__blkdev_issue_zeroout+0x1f8/0x210)
[  240.693059] [<c02a9138>] (__blkdev_issue_zeroout) from [<c02a942c>]
(blkdev_issue_zeroout+0x94/0xa0)
[  240.702265] [<c02a942c>] (blkdev_issue_zeroout) from [<c017fd74>]
(ext4_init_inode_table+0x1a0/0x394)
[  240.711689] [<c017fd74>] (ext4_init_inode_table) from [<c019e050>]
(ext4_lazyinit_thread+0x100/0x2f0)
[  240.721126] [<c019e050>] (ext4_lazyinit_thread) from [<c0032fd4>]
(kthread+0xb8/0xd4)
[  240.729145] [<c0032fd4>] (kthread) from [<c0009680>]
(ret_from_fork+0x14/0x34)
[  240.736535] 4 locks held by ext4lazyinit/73:
[  240.740839]  #0:  (&eli->li_list_mtx){+.+...}, at: [<c019df90>]
ext4_lazyinit_thread+0x40/0x2f0
[  240.749815]  #1:  (sb_writers#3){.+.+.+}, at: [<c019dfdc>]
ext4_lazyinit_thread+0x8c/0x2f0
[  240.758373]  #2:  (jbd2_handle){+.+...}, at: [<c01d3880>]
start_this_handle+0x174/0x5dc
[  240.766630]  #3:  (&meta_group_info[i]->alloc_sem){++++..}, at: [<c017fc8c>]
ext4_init_inode_table+0xb8/0x394
[  240.776855] INFO: task bash:465 blocked for more than 120 seconds.
[  240.783191]       Not tainted 3.18.0-01974-gb2776bf #12
[  240.788456] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
message.
[  240.796417] bash            D c0511a80     0   465    311 0x00000000
[  240.803062] [<c0511a80>] (__schedule) from [<c0051044>]
(suspend_devices_and_enter+0x308/0x62c)
[  240.811840] [<c0051044>] (suspend_devices_and_enter) from [<c0051648>]
(pm_suspend+0x2e0/0x400)
[  240.820729] [<c0051648>] (pm_suspend) from [<c004ff10>]
(state_store+0x80/0xcc)
[  240.828226] [<c004ff10>] (state_store) from [<c02bd950>]
(kobj_attr_store+0x18/0x1c)
[  240.836169] [<c02bd950>] (kobj_attr_store) from [<c0157d18>]
(sysfs_kf_write+0x48/0x4c)
[  240.844363] [<c0157d18>] (sysfs_kf_write) from [<c0156f10>]
(kernfs_fop_write+0xc8/0x184)
[  240.852624] [<c0156f10>] (kernfs_fop_write) from [<c00f5058>]
(vfs_write+0xb8/0x1d8)
[  240.860559] [<c00f5058>] (vfs_write) from [<c00f524c>] (SyS_write+0x44/0x88)
[  240.867783] [<c00f524c>] (SyS_write) from [<c00095c0>]
(ret_fast_syscall+0x0/0x44)
[  240.875517] 4 locks held by bash/465:
[  240.879214]  #0:  (sb_writers#4){.+.+.+}, at: [<c00f511c>]
vfs_write+0x17c/0x1d8
[  240.886898]  #1:  (&of->mutex){+.+.+.}, at: [<c0156ed4>]
kernfs_fop_write+0x8c/0x184
[  240.894883]  #2:  (s_active#39){.+.+.+}, at: [<c0156edc>]
kernfs_fop_write+0x94/0x184
[  240.902996]  #3:  (pm_mutex){+.+.+.}, at: [<c00513e8>] pm_suspend+0x80/0x400
