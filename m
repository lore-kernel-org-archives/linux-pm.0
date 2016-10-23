From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: [Bug] ARM: mxs: STI: console can't wake up from freeze
Date: Sun, 23 Oct 2016 11:19:26 +0200 (CEST)
Message-ID: <315017958.66634.5d4fc19c-31cd-4900-8613-af4cadec5da4.open-xchange@email.1und1.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:53241 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755771AbcJWJUN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 23 Oct 2016 05:20:13 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, joerg.krause@embedded.rocks, linux-arm-kernel@lists.infradead.org

Hi,

i'm faced with the issue that on i.MX28 the console is unable to wake up from
freeze ( suspend to idle). I tested it with Linux 4.9-rc1, 4.8 and 3.18 (
cmdline has
no_console_suspend=1 ) and also with a i.MX23 with the same result. The suspend
seems to work, but there is no reaction to the console after the freeze except
an hung task warning after some time:

echo freeze > /sys/power/state

Strangely the suspend to RAM from console works without any issues:

echo mem > /sys/power/state

Any ideas what could be the problem?

Here is the console output:

root@duckbill:~# echo mem > /sys/power/state
[   44.881170] PM: Syncing filesystems ... [   49.726565] done.
[   49.787188] Freezing user space processes ... (elapsed 0.008 seconds) done.
[   49.803455] Freezing remaining freezable tasks ... (elapsed 0.004 seconds)
done.
[   50.553231] PM: suspend of devices complete after 731.338 msecs
[   50.566850] PM: late suspend of devices complete after 7.436 msecs
[   50.581416] PM: noirq suspend of devices complete after 8.124 msecs
[   50.598957] PM: noirq resume of devices complete after 10.888 msecs

[   50.615757] PM: early resume of devices complete after 7.115 msecs
[   50.641481] Suspended for 1.283 seconds
[   50.646424] PM: resume of devices complete after 24.225 msecs
[   50.660304] Restarting tasks ... [   50.706421] done.
root@duckbill:~# echo freeze > /sys/power/state
[   64.701251] PM: Syncing filesystems ... [   65.992083] done.
[   66.014271] Freezing user space processes ... (elapsed 0.004 seconds) done.
[   66.026151] Freezing remaining freezable tasks ... (elapsed 0.002 seconds)
done.
[   66.204858] PM: suspend of devices complete after 163.009 msecs
[   66.218808] PM: late suspend of devices complete after 7.762 msecs
[   66.232985] PM: noirq suspend of devices complete after 7.887 msecs
[  192.228595] random: crng init done
[  243.817366] INFO: task ext4lazyinit:69 blocked for more than 120 seconds.
[  243.824216]       Not tainted 4.9.0-rc1 #1
[  243.828482] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
message.
[  243.836359] ext4lazyinit    D c05a9fdc     0    69      2 0x00000000
[  243.843028] [<c05a9fdc>] (__schedule) from [<c05aa8e8>] (schedule+0x3c/0xbc)
[  243.850292] [<c05aa8e8>] (schedule) from [<c05ae768>]
(schedule_timeout+0x23c/0x3d8)
[  243.858247] [<c05ae768>] (schedule_timeout) from [<c05a9cc8>]
(io_schedule_timeout+0xb8/0x13c)
[  243.866934] [<c05a9cc8>] (io_schedule_timeout) from [<c05ab308>]
(T.1434+0xac/0x12c)
[  243.874884] [<c05ab308>] (T.1434) from [<c02c7304>]
(submit_bio_wait+0x50/0x68)
[  243.882419] [<c02c7304>] (submit_bio_wait) from [<c02d96f4>]
(blkdev_issue_zeroout+0x174/0x1ec)
[  243.891323] [<c02d96f4>] (blkdev_issue_zeroout) from [<c0196ae8>]
(ext4_init_inode_table+0x1ac/0x3b0)
[  243.900753] [<c0196ae8>] (ext4_init_inode_table) from [<c01ba40c>]
(ext4_lazyinit_thread+0x280/0x398)
[  243.910177] [<c01ba40c>] (ext4_lazyinit_thread) from [<c003bce4>]
(kthread+0xc4/0xe0)
[  243.918213] [<c003bce4>] (kthread) from [<c000a34c>]
(ret_from_fork+0x14/0x28)
[  243.925479]
[  243.925479] Showing all locks held in the system:
[  243.931849] 2 locks held by khungtaskd/10:
[  243.935987]  #0: [  243.937869]  (
rcu_read_lock[  243.940746] ){......}
, at: [  243.943624] [<c00936ac>] watchdog+0xb4/0x61c
[  243.948054]  #1: [  243.949843]  (
tasklist_lock[  243.952700] ){.+.+..}
, at: [  243.955576] [<c0051dbc>] debug_show_all_locks+0x28/0x1bc
[  243.961074] 4 locks held by ext4lazyinit/69:
[  243.965380]  #0: [  243.967273]  (
&type->s_umount_key[  243.970673] #22
){++++++}[  243.973257] , at:
[  243.975320] [<c01ba260>] ext4_lazyinit_thread+0xd4/0x398
[  243.980776]  #1: [  243.982566]  (
sb_writers[  243.985167] #3
){.+.+.+}[  243.987778] , at:
[  243.989861] [<c01ba278>] ext4_lazyinit_thread+0xec/0x398
[  243.995201]  #2: [  243.996973]  (
jbd2_handle[  243.999903] ){++++..}
, at: [  244.002796] [<c01f62b8>] start_this_handle+0xec/0x404
[  244.008014]  #3: [  244.009805]  (
&meta_group_info[i]->alloc_sem[  244.014141] ){++++..}
, at: [  244.017138] [<c01969f4>] ext4_init_inode_table+0xb8/0x3b0
[  244.022619] 4 locks held by bash/386:
[  244.026306]  #0: [  244.028204]  (
sb_writers[  244.030825] #4
){.+.+.+}[  244.033326] , at:
[  244.035390] [<c011f470>] vfs_write+0x194/0x1a4
[  244.039985]  #1: [  244.041772]  (
&of->mutex[  244.044374] ){+.+.+.}
, at: [  244.047366] [<c018ff38>] kernfs_fop_write+0xc0/0x1d0
[  244.052381]  #2: [  244.054154]  (
s_active[  244.056571] #44
){.+.+.+}[  244.059289] , at:
[  244.061364] [<c018ff40>] kernfs_fop_write+0xc8/0x1d0
[  244.066354]  #3: [  244.068247]  (
pm_mutex[  244.070690] ){+.+.+.}
, at: [  244.073576] [<c005b520>] pm_suspend+0x98/0x784
[  244.078179]
[  244.079713] =============================================
[  244.079713]
[  244.086660] INFO: task bash:386 blocked for more than 120 seconds.
[  244.092998]       Not tainted 4.9.0-rc1 #1
[  244.097233] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
message.
[  244.105109] bash            D c05a9fdc     0   386    289 0x00000000
[  244.111762] [<c05a9fdc>] (__schedule) from [<c05aa8e8>] (schedule+0x3c/0xbc)
[  244.119028] [<c05aa8e8>] (schedule) from [<c005aee4>]
(suspend_devices_and_enter+0x480/0xa24)
[  244.127771] [<c005aee4>] (suspend_devices_and_enter) from [<c005b8a8>]
(pm_suspend+0x420/0x784)
[  244.136551] [<c005b8a8>] (pm_suspend) from [<c0059dd8>]
(state_store+0x80/0xcc)
[  244.144075] [<c0059dd8>] (state_store) from [<c02efed0>]
(kobj_attr_store+0x18/0x1c)
[  244.152030] [<c02efed0>] (kobj_attr_store) from [<c0190e54>]
(sysfs_kf_write+0x48/0x4c)
[  244.160217] [<c0190e54>] (sysfs_kf_write) from [<c018ff74>]
(kernfs_fop_write+0xfc/0x1d0)
[  244.168600] [<c018ff74>] (kernfs_fop_write) from [<c011f1e4>]
(__vfs_write+0x2c/0x124)
[  244.176591] [<c011f1e4>] (__vfs_write) from [<c011f390>]
(vfs_write+0xb4/0x1a4)
[  244.184093] [<c011f390>] (vfs_write) from [<c011f554>] (SyS_write+0x44/0x88)
[  244.191326] [<c011f554>] (SyS_write) from [<c000a2c0>]
(ret_fast_syscall+0x0/0x1c)
[  244.199057]
[  244.199057] Showing all locks held in the system:
[  244.205321] 2 locks held by khungtaskd/10:
[  244.209569]  #0: [  244.211361]  (
rcu_read_lock[  244.214221] ){......}
, at: [  244.217216] [<c00936ac>] watchdog+0xb4/0x61c
[  244.221536]  #1: [  244.223308]  (
tasklist_lock[  244.226157] ){.+.+..}
, at: [  244.229244] [<c0051dbc>] debug_show_all_locks+0x28/0x1bc
[  244.234628] 4 locks held by ext4lazyinit/69:
[  244.239047]  #0: [  244.240835]  (
&type->s_umount_key[  244.244214] #22
){++++++}[  244.246796] , at:
[  244.248987] [<c01ba260>] ext4_lazyinit_thread+0xd4/0x398
[  244.254340]  #1: [  244.256116]  (
sb_writers[  244.258845] #3
){.+.+.+}[  244.261355] , at:
[  244.263417] [<c01ba278>] ext4_lazyinit_thread+0xec/0x398
[  244.268876]  #2: [  244.270667]  (
jbd2_handle[  244.273350] ){++++..}
, at: [  244.276230] [<c01f62b8>] start_this_handle+0xec/0x404
[  244.281439]  #3: [  244.283228]  (
&meta_group_info[i]->alloc_sem[  244.287682] ){++++..}
, at: [  244.290589] [<c01969f4>] ext4_init_inode_table+0xb8/0x3b0
[  244.296045] 4 locks held by bash/386:
[  244.299857]  #0: [  244.301644]  (
sb_writers[  244.304241] #4
){.+.+.+}[  244.306738] , at:
[  244.308925] [<c011f470>] vfs_write+0x194/0x1a4
[  244.313408]  #1: [  244.315183]  (
&of->mutex[  244.317895] ){+.+.+.}
, at: [  244.320792] [<c018ff38>] kernfs_fop_write+0xc0/0x1d0
[  244.325791]  #2: [  244.327679]  (
s_active[  244.330126] #44
){.+.+.+}[  244.332713] , at:
[  244.334771] [<c018ff40>] kernfs_fop_write+0xc8/0x1d0
[  244.339881]  #3: [  244.341668]  (
pm_mutex[  244.344087] ){+.+.+.}
, at: [  244.346963] [<c005b520>] pm_suspend+0x98/0x784
[  244.351579]
[  244.353102] =============================================
[  244.353102]
