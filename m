From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: ARM: mxs: warnings on PM resume
Date: Wed, 1 Jun 2016 22:51:23 +0200 (CEST)
Message-ID: <1713040590.199779.36789782-c361-4fe4-bc0d-b581fbce8069.open-xchange@email.1und1.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:61760 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750720AbcFAUwF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jun 2016 16:52:05 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Fabio Estevam <fabio.estevam@nxp.com>, Marek Vasut <marex@denx.de>
Cc: Shawn Guo <shawnguo@kernel.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de

Hi,

i'm currently working on standby support for MXS platform. If i trigger the
standby per sysfs everything works fine, but mostly on resume i get a bunch of
warnings (see below for full output):

[   67.040000] Interrupts enabled before system core resume.

My current working branch [1] based on Linux 4.5 ( cmdline has
no_console_suspend=1 ). The test hardware is a i.MX23 board (
iMX233-OLinuXino-MAXI ).

How can i narrow down this issue to the relevant driver / interrupt ?

What is the right way to fix this issue?

I have the suspicion it's triggered by clocksource/mxs-timer.c because the
vendor kernel 2.6.35 had a function call [2] to suspend the timers. 

[1] - https://github.com/lategoodbye/linux-mxs-power/tree/rebase-4.5
[2] -
http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/tree/arch/arm/mach-mx23/pm.c?h=imx_2.6.35_maintain#n284

Full output in error case:

# echo standy > /sys/power/state
[   65.820000] PM: Syncing filesystems ... done.
[   66.890000] Freezing user space processes ... (elapsed 0.018 seconds) done.
[   66.920000] Freezing remaining freezable tasks ... (elapsed 0.004 seconds)
done.
[   66.960000] smsc95xx 1-1.1:1.0 eth0: entering SUSPEND2 mode
[   66.990000] PM: suspend of devices complete after 56.500 msecs
[   67.010000] PM: late suspend of devices complete after 11.906 msecs
[   67.030000] PM: noirq suspend of devices complete after 12.250 msecs
[   67.040000] ------------[ cut here ]------------
[   67.040000] WARNING: CPU: 0 PID: 271 at drivers/base/syscore.c:99
syscore_resume+0x14c/0x1bc()
[   67.040000] Interrupts enabled before system core resume.
[   67.040000] Modules linked in: mxs_lradc(C) industrialio_triggered_buffer
[   67.040000] CPU: 0 PID: 271 Comm: bash Tainted: G         C
     4.5.0-g8b79a7d-dirty #86
[   67.040000] Hardware name: Freescale MXS (Device Tree)
[   67.040000] [<c000fdc4>] (unwind_backtrace) from [<c000de80>]
(show_stack+0x10/0x14)
[   67.040000] [<c000de80>] (show_stack) from [<c001d094>]
(warn_slowpath_common+0x7c/0xb4)
[   67.040000] [<c001d094>] (warn_slowpath_common) from [<c001d160>]
(warn_slowpath_fmt+0x30/0x40)
[   67.040000] [<c001d160>] (warn_slowpath_fmt) from [<c035c6b8>]
(syscore_resume+0x14c/0x1bc)
[   67.040000] [<c035c6b8>] (syscore_resume) from [<c005d37c>]
(suspend_devices_and_enter+0x480/0x770)
[   67.040000] [<c005d37c>] (suspend_devices_and_enter) from [<c005dad4>]
(pm_suspend+0x468/0x4e4)
[   67.040000] [<c005dad4>] (pm_suspend) from [<c005c324>]
(state_store+0x80/0xcc)
[   67.040000] [<c005c324>] (state_store) from [<c02dc0d8>]
(kobj_attr_store+0x18/0x1c)
[   67.040000] [<c02dc0d8>] (kobj_attr_store) from [<c0181988>]
(sysfs_kf_write+0x48/0x4c)
[   67.040000] [<c0181988>] (sysfs_kf_write) from [<c0180b34>]
(kernfs_fop_write+0xe0/0x1a0)
[   67.040000] [<c0180b34>] (kernfs_fop_write) from [<c0114b08>]
(__vfs_write+0x2c/0xe8)
[   67.040000] [<c0114b08>] (__vfs_write) from [<c0114c6c>]
(vfs_write+0xa8/0x198)
[   67.040000] [<c0114c6c>] (vfs_write) from [<c0114e30>] (SyS_write+0x44/0x88)
[   67.040000] [<c0114e30>] (SyS_write) from [<c000a280>]
(ret_fast_syscall+0x0/0x1c)
[   67.040000] ---[ end trace 22f59f91777b0ede ]---
[   67.040000] ------------[ cut here ]------------
[   67.040000] WARNING: CPU: 0 PID: 271 at drivers/base/syscore.c:107
syscore_resume+0xe8/0x1bc()
[   67.040000] Interrupts enabled after cpu_pm_resume+0x0/0x10
[   67.040000] Modules linked in: mxs_lradc(C) industrialio_triggered_buffer
[   67.040000] CPU: 0 PID: 271 Comm: bash Tainted: G        WC
     4.5.0-g8b79a7d-dirty #86
[   67.040000] Hardware name: Freescale MXS (Device Tree)
[   67.040000] [<c000fdc4>] (unwind_backtrace) from [<c000de80>]
(show_stack+0x10/0x14)
[   67.040000] [<c000de80>] (show_stack) from [<c001d094>]
(warn_slowpath_common+0x7c/0xb4)
[   67.040000] [<c001d094>] (warn_slowpath_common) from [<c001d160>]
(warn_slowpath_fmt+0x30/0x40)
[   67.040000] [<c001d160>] (warn_slowpath_fmt) from [<c035c654>]
(syscore_resume+0xe8/0x1bc)
[   67.040000] [<c035c654>] (syscore_resume) from [<c005d37c>]
(suspend_devices_and_enter+0x480/0x770)
[   67.040000] [<c005d37c>] (suspend_devices_and_enter) from [<c005dad4>]
(pm_suspend+0x468/0x4e4)
[   67.040000] [<c005dad4>] (pm_suspend) from [<c005c324>]
(state_store+0x80/0xcc)
[   67.040000] [<c005c324>] (state_store) from [<c02dc0d8>]
(kobj_attr_store+0x18/0x1c)
[   67.040000] [<c02dc0d8>] (kobj_attr_store) from [<c0181988>]
(sysfs_kf_write+0x48/0x4c)
[   67.040000] [<c0181988>] (sysfs_kf_write) from [<c0180b34>]
(kernfs_fop_write+0xe0/0x1a0)
[   67.040000] [<c0180b34>] (kernfs_fop_write) from [<c0114b08>]
(__vfs_write+0x2c/0xe8)
[   67.040000] [<c0114b08>] (__vfs_write) from [<c0114c6c>]
(vfs_write+0xa8/0x198)
[   67.040000] [<c0114c6c>] (vfs_write) from [<c0114e30>] (SyS_write+0x44/0x88)
[   67.040000] [<c0114e30>] (SyS_write) from [<c000a280>]
(ret_fast_syscall+0x0/0x1c)
[   67.040000] ---[ end trace 22f59f91777b0edf ]---
[   67.040000] ------------[ cut here ]------------
[   67.040000] WARNING: CPU: 0 PID: 271 at kernel/time/hrtimer.c:771
hrtimers_resume+0x40/0x5c()
[   67.040000] hrtimers_resume() called with IRQs enabled!
[   67.040000] Modules linked in: mxs_lradc(C) industrialio_triggered_buffer
[   67.040000] CPU: 0 PID: 271 Comm: bash Tainted: G        WC
     4.5.0-g8b79a7d-dirty #86
[   67.040000] Hardware name: Freescale MXS (Device Tree)
[   67.040000] [<c000fdc4>] (unwind_backtrace) from [<c000de80>]
(show_stack+0x10/0x14)
[   67.040000] [<c000de80>] (show_stack) from [<c001d094>]
(warn_slowpath_common+0x7c/0xb4)
[   67.040000] [<c001d094>] (warn_slowpath_common) from [<c001d160>]
(warn_slowpath_fmt+0x30/0x40)
[   67.040000] [<c001d160>] (warn_slowpath_fmt) from [<c006e1fc>]
(hrtimers_resume+0x40/0x5c)
[   67.040000] [<c006e1fc>] (hrtimers_resume) from [<c00763f8>]
(timekeeping_resume+0x1f4/0x388)
[   67.040000] [<c00763f8>] (timekeeping_resume) from [<c035c5e4>]
(syscore_resume+0x78/0x1bc)
[   67.040000] [<c035c5e4>] (syscore_resume) from [<c005d37c>]
(suspend_devices_and_enter+0x480/0x770)
[   67.040000] [<c005d37c>] (suspend_devices_and_enter) from [<c005dad4>]
(pm_suspend+0x468/0x4e4)
[   67.040000] [<c005dad4>] (pm_suspend) from [<c005c324>]
(state_store+0x80/0xcc)
[   67.040000] [<c005c324>] (state_store) from [<c02dc0d8>]
(kobj_attr_store+0x18/0x1c)
[   67.040000] [<c02dc0d8>] (kobj_attr_store) from [<c0181988>]
(sysfs_kf_write+0x48/0x4c)
[   67.040000] [<c0181988>] (sysfs_kf_write) from [<c0180b34>]
(kernfs_fop_write+0xe0/0x1a0)
[   67.040000] [<c0180b34>] (kernfs_fop_write) from [<c0114b08>]
(__vfs_write+0x2c/0xe8)
[   67.040000] [<c0114b08>] (__vfs_write) from [<c0114c6c>]
(vfs_write+0xa8/0x198)
[   67.040000] [<c0114c6c>] (vfs_write) from [<c0114e30>] (SyS_write+0x44/0x88)
[   67.040000] [<c0114e30>] (SyS_write) from [<c000a280>]
(ret_fast_syscall+0x0/0x1c)
[   67.040000] ---[ end trace 22f59f91777b0ee0 ]---
[   67.040000]
[   67.040000] =================================
[   67.040000] [ INFO: inconsistent lock state ]
[   67.040000] 4.5.0-g8b79a7d-dirty #86 Tainted: G        WC
[   67.040000] ---------------------------------
[   67.040000] inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
[   67.040000] bash/271 [HC0[0]:SC0[0]:HE1:SE1] takes:
[   67.040000]  (hrtimer_bases.lock){?.-.-.}, at: [<c006d668>]
retrigger_next_event+0x28/0x64
[   67.040000] {IN-HARDIRQ-W} state was registered at:
[   67.040000]   [<c057b2c0>] _raw_spin_lock+0x2c/0x3c
[   67.040000]   [<c006e83c>] hrtimer_run_queues+0x78/0xcc
[   67.040000]   [<c006c3fc>] run_local_timers+0x8/0x14
[   67.040000]   [<c006c430>] update_process_times+0x28/0x5c
[   67.040000]   [<c007c464>] tick_handle_periodic+0x18/0x90
[   67.040000]   [<c043e424>] mxs_timer_interrupt+0x20/0x2c
[   67.040000]   [<c00620f8>] handle_irq_event_percpu+0x80/0x260
[   67.040000]   [<c0062310>] handle_irq_event+0x38/0x5c
[   67.040000]   [<c00652c0>] handle_level_irq+0x9c/0x114
[   67.040000]   [<c0061f60>] generic_handle_irq+0x1c/0x24
[   67.040000]   [<c0061fb0>] __handle_domain_irq+0x48/0xa0
[   67.040000]   [<c000e734>] __irq_svc+0x54/0x6c
[   67.040000]   [<c0009f58>] calibrate_delay+0x3ec/0x594
[   67.040000]   [<c0787ca0>] start_kernel+0x2e0/0x398
[   67.040000]   [<40008048>] 0x40008048
[   67.040000] irq event stamp: 26069
[   67.040000] hardirqs last  enabled at (26069): [<c02d9624>]
_set_bit+0x44/0x60
[   67.040000] hardirqs last disabled at (26068): [<c02d9608>]
_set_bit+0x28/0x60
[   67.040000] softirqs last  enabled at (21866): [<c00212ac>]
__do_softirq+0x27c/0x3a8
[   67.040000] softirqs last disabled at (21859): [<c0021508>]
irq_exit+0xd0/0x11c
[   67.040000]
[   67.040000] other info that might help us debug this:
[   67.040000]  Possible unsafe locking scenario:
[   67.040000]
[   67.040000]        CPU0
[   67.040000]        ----
[   67.040000]   lock(hrtimer_bases.lock);
[   67.040000]   <Interrupt>
[   67.040000]     lock(hrtimer_bases.lock);
[   67.040000]
[   67.040000]  *** DEADLOCK ***
[   67.040000]
[   67.040000] 4 locks held by bash/271:
[   67.040000]  #0:  (sb_writers#4){.+.+.+}, at: [<c0115ed4>]
__sb_start_write+0xb8/0xc8
[   67.040000]  #1:  (&of->mutex){+.+.+.}, at: [<c0180ab8>]
kernfs_fop_write+0x64/0x1a0
[   67.040000]  #2:  (s_active#45){.+.+.+}, at: [<c0180ac0>]
kernfs_fop_write+0x6c/0x1a0
[   67.040000]  #3:  (pm_mutex){+.+.+.}, at: [<c005d6f4>] pm_suspend+0x88/0x4e4
[   67.040000]
[   67.040000] stack backtrace:
[   67.040000] CPU: 0 PID: 271 Comm: bash Tainted: G        WC
     4.5.0-g8b79a7d-dirty #86
[   67.040000] Hardware name: Freescale MXS (Device Tree)
[   67.040000] [<c000fdc4>] (unwind_backtrace) from [<c000de80>]
(show_stack+0x10/0x14)
[   67.040000] [<c000de80>] (show_stack) from [<c0053c88>]
(print_usage_bug+0x1c0/0x2b0)
[   67.040000] [<c0053c88>] (print_usage_bug) from [<c00541c8>]
(mark_lock+0x450/0x68c)
[   67.040000] [<c00541c8>] (mark_lock) from [<c0057878>]
(__lock_acquire+0x534/0xd28)
[   67.040000] [<c0057878>] (__lock_acquire) from [<c0058124>]
(lock_acquire+0xb8/0x140)
[   67.040000] [<c0058124>] (lock_acquire) from [<c057b2c0>]
(_raw_spin_lock+0x2c/0x3c)
[   67.040000] [<c057b2c0>] (_raw_spin_lock) from [<c006d668>]
(retrigger_next_event+0x28/0x64)
[   67.040000] [<c006d668>] (retrigger_next_event) from [<c006e1d4>]
(hrtimers_resume+0x18/0x5c)
[   67.040000] [<c006e1d4>] (hrtimers_resume) from [<c00763f8>]
(timekeeping_resume+0x1f4/0x388)
[   67.040000] [<c00763f8>] (timekeeping_resume) from [<c035c5e4>]
(syscore_resume+0x78/0x1bc)
[   67.040000] [<c035c5e4>] (syscore_resume) from [<c005d37c>]
(suspend_devices_and_enter+0x480/0x770)
[   67.040000] [<c005d37c>] (suspend_devices_and_enter) from [<c005dad4>]
(pm_suspend+0x468/0x4e4)
[   67.040000] [<c005dad4>] (pm_suspend) from [<c005c324>]
(state_store+0x80/0xcc)
[   67.040000] [<c005c324>] (state_store) from [<c02dc0d8>]
(kobj_attr_store+0x18/0x1c)
[   67.040000] [<c02dc0d8>] (kobj_attr_store) from [<c0181988>]
(sysfs_kf_write+0x48/0x4c)
[   67.040000] [<c0181988>] (sysfs_kf_write) from [<c0180b34>]
(kernfs_fop_write+0xe0/0x1a0)
[   67.040000] [<c0180b34>] (kernfs_fop_write) from [<c0114b08>]
(__vfs_write+0x2c/0xe8)
[   67.040000] [<c0114b08>] (__vfs_write) from [<c0114c6c>]
(vfs_write+0xa8/0x198)
[   67.040000] [<c0114c6c>] (vfs_write) from [<c0114e30>] (SyS_write+0x44/0x88)
[   67.040000] [<c0114e30>] (SyS_write) from [<c000a280>]
(ret_fast_syscall+0x0/0x1c)
[   67.040000] PM: noirq resume of devices complete after 6.187 msecs

[   67.050000] PM: early resume of devices complete after 5.937 msecs
[   67.300000] PM: resume of devices complete after 235.468 msecs
[   67.300000] PM: Finishing wakeup.
[   67.310000] Restarting tasks ...
[   67.310000] usb 1-1: USB disconnect, device number 2
[   67.320000] usb 1-1.1: USB disconnect, device number 3
[   67.370000] done.
[   67.370000] smsc95xx 1-1.1:1.0 eth0: unregister 'smsc95xx' usb-ci_hdrc.0-1.1,
smsc95xx USB 2.0 Ethernet

# cat /proc/interrupts
           CPU0
 16:      13873         -  28 Edge      MXS Timer Tick
 17:        819         -   0 Edge      uart-pl011
 18:       4703         -  14 Edge      mxs-dma
 19:          0         -  20 Edge      mxs-dma
 21:          6         -  15 Edge      80010000.ssp
124:          0         -  26 Edge      mxs-dma
132:          0         -   2 Edge      80034000.ssp
134:          0         -  36 Edge      mxs-lradc-touchscreen
135:          0         -  37 Edge      mxs-lradc-channel0
136:          0         -  38 Edge      mxs-lradc-channel1
137:          0         -  39 Edge      mxs-lradc-channel2
138:          0         -  40 Edge      mxs-lradc-channel3
139:          0         -  41 Edge      mxs-lradc-channel4
140:          0         -  42 Edge      mxs-lradc-channel5
141:          0         -  43 Edge      mxs-lradc-channel6
142:          0         -  44 Edge      mxs-lradc-channel7
143:          0         -  27 Edge      80058000.i2c
144:          0         -  22 Edge      RTC alarm
148:          0         -  24 Edge      8006c000.serial
149:        557         -  11 Edge      80080000.usb
Err:          0
