From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: OPP's mutex locking issue
Date: Wed, 20 Sep 2017 19:22:06 +0900
Message-ID: <59C2414E.6020803@samsung.com>
References: <CGME20170920102206epcas1p2ae5b3a2020efa368f6c0640403695cbd@epcas1p2.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:30039 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751623AbdITKWJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Sep 2017 06:22:09 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>
Cc: "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, =?UTF-8?B?Iuy1nOywrOyasCAoc2Ftc3VuZy5jb20pIg==?= <cw00.choi@samsung.com>, "Chanwoo Choi (chanwoo@kernel.org)" <chanwoo@kernel.org>, =?UTF-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>, =?UTF-8?B?64yA7J246riw?= <inki.dae@samsung.com>

Dear all,

The commit 052c6f19141dd ("PM / OPP: Move away from RCU locking")
used the mutex instead of RCU locking. After that, I get a deadlock issue
between Devfreq framework and Devfreq-Cooling device of thermal framework.


[Description]
Originally, Devfreq framework used the opp_notifier (dev_pm_opp_register_notifier)
in order to catch the OPP_EVENT_*. When Devfreq receives the notification,
it called the 'update_devfreq()' which updates the frequency of devfreq device
according to the available status of OPP. Because the dev_pm_opp_disable/enable()
could affect the minimum/maximum frequency of devfreq device.

The commit a76caf55e5b35 ("thermal: Add devfreq cooling") allows
the devfreq device to be used the cooling device. When the cooling down
are required, the devfreq_cooling.c calls dev_pm_opp_disable()
in order to disable the specific OPP.

In this case, the deadlock occurs.

In order to resolve this issue on the device driver side,
the OPP functions should not be used in the .notifier_call function.
Or, the .notifier_call function have to use the workqueue.


[Deadlock Sequence]
- base commit: v4.14-rc1
- I tried to change the 'cur_state' value of devfreq-cooling device directly.

root@localhost:~# cat /sys/class/thermal/cooling_device0/type 
thermal-devfreq-0
root@localhost:~# echo 2 > /sys/class/thermal/cooling_device0/cur_state
devfreq_cooling_set_cur_state() in drivers/thermal/devfreq_cooling.c
	partition_enable_opps()
		dev_pm_opp_disable();
	
dev_pm_opp_disable()
	mutex_lock(&opp_table->lock); : Firstly, lock mutex
	blocking_notifier_call_chain(&opp_table->head, OPP_EVNET_ENABLE/DISABLE, opp);
		--> devfreq_notifier_call() (.notifiear_call callback function of opp_notifier)				
			update_devfreq(devfreq); 
				devfreq->profile->target()
					devfreq_recommended_opp() (in drivers/devfreq/exynos-bus.c)
						dev_pm_opp_find_freq_floor/ceil()
							mutex_lock(&opp_table->lock); : Second, lock mutex : deadlock


[Kernel Log]
root@localhost:~# echo 2 > /sys/class/thermal/cooling_device0/cur_state                                                      
[   71.144017] INFO: task kworker/u16:1:108 blocked for more than 2 seconds.
[   71.144292]       Not tainted 4.14.0-rc1+ #48
[   71.144471] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[   71.144780] kworker/u16:1   D    0   108      2 0x00000000
[   71.146134] Workqueue: devfreq_wq devfreq_monitor
[   71.151437] Call trace:
[   71.153645] [<ffffff8008086360>] __switch_to+0xa0/0xb4
[   71.158671] [<ffffff8008aba76c>] __schedule+0x1f4/0x6c8
[   71.163958] [<ffffff8008abac74>] schedule+0x34/0x94
[   71.168782] [<ffffff8008abb158>] schedule_preempt_disabled+0x14/0x24
[   71.175024] [<ffffff8008abbe74>] __mutex_lock.isra.6+0x1a8/0x6c0
[   71.181041] [<ffffff8008abc39c>] __mutex_lock_slowpath+0x10/0x18
[   71.186782] [<ffffff8008abc3d4>] mutex_lock+0x30/0x38
[   71.191889] [<ffffff800875f77c>] devfreq_monitor+0x24/0x88
[   71.197309] [<ffffff80080b6680>] process_one_work+0x148/0x3f4
[   71.203070] [<ffffff80080b6984>] worker_thread+0x58/0x3c8
[   71.208416] [<ffffff80080bc484>] kthread+0x100/0x12c
[   71.213365] [<ffffff8008085380>] ret_from_fork+0x10/0x20
[   71.218715] INFO: task bash:795 blocked for more than 2 seconds.
[   71.224657]       Not tainted 4.14.0-rc1+ #48
[   71.228995] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[   71.236794] bash            D    0   795    340 0x00400200
[   71.242274] Call trace:
[   71.244697] [<ffffff8008086360>] __switch_to+0xa0/0xb4
[   71.249831] [<ffffff8008aba76c>] __schedule+0x1f4/0x6c8
[   71.255197] [<ffffff8008abac74>] schedule+0x34/0x94
[   71.259875] [<ffffff8008abb158>] schedule_preempt_disabled+0x14/0x24
[   71.266199] [<ffffff8008abbe74>] __mutex_lock.isra.6+0x1a8/0x6c0
[   71.272203] [<ffffff8008abc39c>] __mutex_lock_slowpath+0x10/0x18
[   71.278175] [<ffffff8008abc3d4>] mutex_lock+0x30/0x38
[   71.283225] [<ffffff8008547ed4>] _find_freq_ceil+0x24/0xb4
[   71.288697] [<ffffff80085489c4>] dev_pm_opp_find_freq_ceil+0x34/0x80
[   71.295030] [<ffffff800875f588>] devfreq_recommended_opp+0x34/0x5c
[   71.301179] [<ffffff8008760b4c>] exynos_bus_target+0x28/0x1f4
[   71.306919] [<ffffff800875f678>] update_devfreq+0xc8/0x1a8
[   71.312378] [<ffffff800875f804>] devfreq_notifier_call+0x24/0x40
[   71.318378] [<ffffff80080bdb70>] notifier_call_chain+0x4c/0x88
[   71.324196] [<ffffff80080bdf20>] __blocking_notifier_call_chain+0x4c/0x8c
[   71.331421] [<ffffff80080bdf74>] blocking_notifier_call_chain+0x14/0x1c
[   71.337573] [<ffffff80085490f0>] _opp_set_availability+0xcc/0x114
[   71.343642] [<ffffff8008549160>] dev_pm_opp_disable+0x10/0x18
[   71.349372] [<ffffff80086d9840>] devfreq_cooling_set_cur_state+0xe0/0x12c
[   71.356163] [<ffffff80086d6c1c>] thermal_cooling_device_cur_state_store+0x4c/0x74
[   71.363593] [<ffffff800852ecf4>] dev_attr_store+0x18/0x28
[   71.368993] [<ffffff800825d9c8>] sysfs_kf_write+0x40/0x50
[   71.374351] [<ffffff800825ccd4>] kernfs_fop_write+0xc0/0x1d0
[   71.380016] [<ffffff80081e9bec>] __vfs_write+0x28/0x124
[   71.385203] [<ffffff80081e9e9c>] vfs_write+0xa0/0x170
[   71.390517] [<ffffff80081ea0fc>] SyS_write+0x44/0xa0
[   71.395314] Exception stack(0xffffff801259bec0 to 0xffffff801259c000)
[   71.401639] bec0: 0000000000000001 00000000004d78f8 0000000000000002 0000000000000000
[   71.409434] bee0: 0000000000000002 00000000004d78f8 00000000f7b29d50 0000000000000004
[   71.417590] bf00: 0000000000000002 0000000000000002 0000000000000001 0000000000000000
[   71.425072] bf20: 0000000000000000 00000000ffc1d8dc 00000000f7a5a0cc 0000000000000000
[   71.433290] bf40: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
[   71.440672] bf60: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
[   71.448493] bf80: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
[   71.456324] bfa0: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
[   71.464115] bfc0: 00000000f7ab20a0 0000000060060010 0000000000000001 0000000000000004
[   71.471920] bfe0: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
[   71.479745] [<ffffff8008083808>] __sys_trace_return+0x0/0x4


[Register exynos-bus devfreq device as a cooling device]
diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
index 49f68929e024..e299f2ed6a83 100644
--- a/drivers/devfreq/exynos-bus.c
+++ b/drivers/devfreq/exynos-bus.c
@@ -15,6 +15,7 @@
 #include <linux/clk.h>
 #include <linux/devfreq.h>
 #include <linux/devfreq-event.h>
+#include <linux/devfreq_cooling.h>
 #include <linux/device.h>
 #include <linux/export.h>
 #include <linux/module.h>
@@ -41,6 +42,8 @@ struct exynos_bus {
        struct clk *clk;
        unsigned int voltage_tolerance;
        unsigned int ratio;
+
+       struct thermal_cooling_device *cdev;
 };

 /*
@@ -467,6 +470,14 @@ static int exynos_bus_probe(struct platform_device *pdev)
                goto err;
        }

+       /* Register devfreq cooling device */
+       bus->cdev = of_devfreq_cooling_register(np, bus->devfreq);
+       if (IS_ERR(bus->cdev) < 0) {
+               dev_err(dev, "failed to register cooling device\n");
+               ret = PTR_ERR(bus->cdev);
+               goto err;
+       }
+
        goto out;
 passive:
        /* Initialize the struct profile and governor data for passive device */

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
