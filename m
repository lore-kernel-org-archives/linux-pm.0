From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [Bug] ARM: mxs: STI: console can't wake up from freeze
Date: Sat, 5 Nov 2016 12:07:10 +0100 (CET)
Message-ID: <322177156.158733.9867e3e7-5710-4844-a098-6f44bd852a6d.open-xchange@email.1und1.de>
References: <315017958.66634.5d4fc19c-31cd-4900-8613-af4cadec5da4.open-xchange@email.1und1.de>
 <20161023133134.GI1041@n2100.armlinux.org.uk>
 <1709157673.85170.1cb53b4d-2805-48ea-aef1-dd282306d108.open-xchange@email.1und1.de>
 <20161031161700.GH1041@n2100.armlinux.org.uk>
 <847975190.29034.38a9c7fa-bdf8-4732-ac8b-cf15c21e3ce8.open-xchange@email.1und1.de>
 <20161101092304.GM1041@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.133]:62315 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752437AbcKELIJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 5 Nov 2016 07:08:09 -0400
In-Reply-To: <20161101092304.GM1041@n2100.armlinux.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, joerg.krause@embedded.rocks, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Fabio Estevam <fabio.estevam@nxp.com>, Zhang Rui <rui.zhang@intel.com>

Hi,

[add Rui]

> Russell King - ARM Linux <linux@armlinux.org.uk> hat am 1. November 2016 um
> 10:23 geschrieben:
> 
> 
> On Mon, Oct 31, 2016 at 08:54:33PM +0100, Stefan Wahren wrote:
> > [  366.696043] INFO: task ext4lazyinit:70 blocked for more than 120 seconds.
> > [  366.703046]       Not tainted 4.9.0-rc1 #7
> > [  366.707188] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
> > this
> > message.
> > [  366.715161] ext4lazyinit    D c05aa6ac     0    70      2 0x00000000
> 
> This looks like a very different problem - I guess one for ext4 people.
> 

i investigated the issue more further. This trace wasn't representative, because
the stacktrace is different in most cases. The "endless loop" is located in
freeze_enter(). So i added some debug messages:

-------------------------------->8------------------------------------
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 1e7f5da..079c08d 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -67,17 +67,20 @@ static void freeze_enter(void)
 	spin_unlock_irq(&suspend_freeze_lock);
 
 	get_online_cpus();
+	pr_info("PM: calling cpuidle_resume()\n");
 	cpuidle_resume();
 
 	/* Push all the CPUs into the idle loop. */
+	pr_info("PM: calling wake_up_all_idle_cpus()\n");
 	wake_up_all_idle_cpus();
-	pr_debug("PM: suspend-to-idle\n");
+	pr_info("PM: suspend-to-idle\n");
 	/* Make the current CPU wait so it can enter the idle loop too. */
 	wait_event(suspend_freeze_wait_head,
 		   suspend_freeze_state == FREEZE_STATE_WAKE);
-	pr_debug("PM: resume from suspend-to-idle\n");
+	pr_info("PM: resume from suspend-to-idle\n");
 
 	cpuidle_pause();
+	pr_info("PM: called cpuidle_pause()\n");
 	put_online_cpus();
 
 	spin_lock_irq(&suspend_freeze_lock);
@@ -91,6 +94,8 @@ void freeze_wake(void)
 {
 	unsigned long flags;
 
+	pr_info("PM: freeze_wake()\n");
+
 	spin_lock_irqsave(&suspend_freeze_lock, flags);
 	if (suspend_freeze_state > FREEZE_STATE_NONE) {
 		suspend_freeze_state = FREEZE_STATE_WAKE;

-------------------------------->8------------------------------------

and repeated the test cases for freeze which shows none the representative
stacktraces:

1. cmdline contains no_console_suspend

* echo freeze > /sys/power/state

...
[  139.371308] PM: suspend of devices complete after 1342.721 msecs
[  139.385203] PM: late suspend of devices complete after 7.668 msecs
[  139.399428] PM: noirq suspend of devices complete after 7.936 msecs
[  139.406639] PM: calling cpuidle_resume()
[  139.410619] PM: calling wake_up_all_idle_cpus()
[  139.415339] PM: suspend-to-idle

>>> no reaction to input via Debug UART

[  366.683570] INFO: task bash:373 blocked for more than 120 seconds.
[  366.689814]       Not tainted 4.9.0-rc1-dirty #14
[  366.694705] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
message.
[  366.702685] bash            D c05aa6ec     0   373    275 0x00000000
[  366.709227] [<c05aa6ec>] (__schedule) from [<c05aaff8>] (schedule+0x3c/0xbc)
[  366.716495] [<c05aaff8>] (schedule) from [<c005b588>]
(suspend_devices_and_enter+0x888/0xa78)
[  366.725228] [<c005b588>] (suspend_devices_and_enter) from [<c005bea4>]
(pm_suspend+0x72c/0x81c)
[  366.734150] [<c005bea4>] (pm_suspend) from [<c005a008>]
(state_store+0x80/0xcc)
[  366.741554] [<c005a008>] (state_store) from [<c02f0270>]
(kobj_attr_store+0x18/0x1c)
[  366.749515] [<c02f0270>] (kobj_attr_store) from [<c01911e8>]
(sysfs_kf_write+0x48/0x4c)
[  366.757735] [<c01911e8>] (sysfs_kf_write) from [<c0190308>]
(kernfs_fop_write+0xfc/0x1d0)
[  366.766130] [<c0190308>] (kernfs_fop_write) from [<c011f578>]
(__vfs_write+0x2c/0x124)
[  366.774255] [<c011f578>] (__vfs_write) from [<c011f724>]
(vfs_write+0xb4/0x1a4)
[  366.781640] [<c011f724>] (vfs_write) from [<c011f8e8>] (SyS_write+0x44/0x88)
[  366.788890] [<c011f8e8>] (SyS_write) from [<c000a2c0>]
(ret_fast_syscall+0x0/0x1c)
[  366.796627]
[  366.796627] Showing all locks held in the system:
[  366.803011] 2 locks held by khungtaskd/10:
[  366.807149]  #0: [  366.808931]  (
rcu_read_lock[  366.811784] ){......}
, at: [  366.814813] [<c0093a40>] watchdog+0xb4/0x61c
[  366.819128]  #1: [  366.820902]  (
tasklist_lock[  366.823876] ){.+.+..}
, at: [  366.826765] [<c0051dbc>] debug_show_all_locks+0x28/0x1bc
[  366.832151] 4 locks held by bash/373:
[  366.835973]  #0: [  366.837765]  (
sb_writers[  366.840365] #4
){.+.+.+}[  366.842987] , at:
[  366.845079] [<c011f804>] vfs_write+0x194/0x1a4
[  366.849551]  #1: [  366.851324]  (
&of->mutex[  366.854058] ){+.+.+.}
, at: [  366.856944] [<c01902cc>] kernfs_fop_write+0xc0/0x1d0
[  366.861941]  #2: [  366.863839]  (
s_active[  366.866288] #43
){.+.+.+}[  366.868877] , at:
[  366.870938] [<c01902d4>] kernfs_fop_write+0xc8/0x1d0
[  366.876053]  #3: [  366.877843]  (
pm_mutex[  366.880272] ){+.+.+.}
, at: [  366.883266] [<c005b808>] pm_suspend+0x90/0x81c
[  366.887757]
[  366.889268] =============================================
[  366.889268]

2. cmdline contains no_console_suspend

* echo enabled > /sys/class/tty/ttyAMA0/power/wakeup
* echo freeze > /sys/power/state

the same as in 1.

3. cmdline doesn't contains no_console_suspend

* echo enabled > /sys/class/tty/ttyAMA0/power/wakeup
* echo freeze > /sys/power/state

[  161.093187] PM: Syncing filesystems ... [  161.734413] done.
[  161.793242] Freezing user space processes ... (elapsed 0.008 seconds) done.
[  161.809797] Freezing remaining freezable tasks ... (elapsed 0.004 seconds)
done.
[  161.821953] Suspending console(s) (use no_console_suspend to debug)

>>>> no reaction to Debug UART

I expected that in all 3 cases freeze_wake() will be called. Why not?

Here my config again:

CONFIG_PM_SLEEP=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
CONFIG_PM=y
CONFIG_CPU_IDLE is not set
