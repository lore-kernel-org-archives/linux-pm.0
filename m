From: Juri Lelli <juri.lelli@arm.com>
Subject: [RFC PATCH 06/19] cpufreq: always access cpufreq_policy_list while holding cpufreq_driver_lock
Date: Mon, 11 Jan 2016 17:35:47 +0000
Message-ID: <1452533760-13787-7-git-send-email-juri.lelli@arm.com>
References: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, juri.lelli@arm.com
List-Id: linux-pm@vger.kernel.org

Commit highlights paths where we access cpufreq_policy_list without
holding cpufreq_driver_lock; one example being the following:

[    8.245779] ------------[ cut here ]------------
[    8.305977] WARNING: CPU: 2 PID: 1 at kernel/drivers/cpufreq/cpufreq.c:2447 cpufreq_register_driver+0xfd/0x120()
[    8.438611] Modules linked in:
[    8.493751] CPU: 2 PID: 1 Comm: swapper/0 Not tainted 4.4.0-rc4+ #369
[    8.561039] Hardware name: ARM-Versatile Express
[    8.622765] [<c0014215>] (unwind_backtrace) from [<c0010e25>] (show_stack+0x11/0x14)
[    8.629651] atkbd serio0: keyboard reset failed on 1c060000.kmi
[    8.810905] [<c0010e25>] (show_stack) from [<c02ece7d>] (dump_stack+0x55/0x78)
[    8.935122] [<c02ece7d>] (dump_stack) from [<c00202cd>] (warn_slowpath_common+0x59/0x84)
[    9.067097] [<c00202cd>] (warn_slowpath_common) from [<c002030f>] (warn_slowpath_null+0x17/0x1c)
[    9.204101] [<c002030f>] (warn_slowpath_null) from [<c03ba329>] (cpufreq_register_driver+0xfd/0x120)
[    9.209603] usb 1-1.2: new high-speed USB device number 3 using isp1760
[    9.419507] [<c03ba329>] (cpufreq_register_driver) from [<c03bc481>] (bL_cpufreq_register+0x49/0x98)
[    9.560548] [<c03bc481>] (bL_cpufreq_register) from [<c0342517>] (platform_drv_probe+0x3b/0x6c)
[    9.573806] usb-storage 1-1.2:1.0: USB Mass Storage device detected
[    9.575468] scsi host0: usb-storage 1-1.2:1.0
[    9.855845] [<c0342517>] (platform_drv_probe) from [<c03412e7>] (driver_probe_device+0x153/0x1bc)
[   10.006137] [<c03412e7>] (driver_probe_device) from [<c03413a7>] (__driver_attach+0x57/0x58)
[   10.009576] atkbd serio1: keyboard reset failed on 1c070000.kmi
[   10.237057] [<c03413a7>] (__driver_attach) from [<c0340199>] (bus_for_each_dev+0x2d/0x4c)
[   10.387824] [<c0340199>] (bus_for_each_dev) from [<c0340bd7>] (bus_add_driver+0xa3/0x14c)
[   10.539200] [<c0340bd7>] (bus_add_driver) from [<c0341bff>] (driver_register+0x3b/0x88)
[   10.691023] [<c0341bff>] (driver_register) from [<c0009613>] (do_one_initcall+0x5b/0x150)
[   10.703809] scsi 0:0:0:0: Direct-Access     General  USB Flash Disk   1.0  PQ: 0 ANSI: 2
[   10.713081] sd 0:0:0:0: [sda] 7831552 512-byte logical blocks: (4.00 GB/3.73 GiB)
[   10.713973] sd 0:0:0:0: [sda] Write Protect is off
[   10.713984] sd 0:0:0:0: [sda] Mode Sense: 03 00 00 00
[   10.730783] sd 0:0:0:0: [sda] No Caching mode page found
[   10.730814] sd 0:0:0:0: [sda] Assuming drive cache: write through
[   10.779815]  sda: sda1 sda2
[   10.823590] sd 0:0:0:0: [sda] Attached SCSI removable disk
[   11.581894] [<c0009613>] (do_one_initcall) from [<c0734b45>] (kernel_init_freeable+0x18d/0x22c)
[   11.720454] [<c0734b45>] (kernel_init_freeable) from [<c04f45f9>] (kernel_init+0xd/0xa4)
[   11.857340] [<c04f45f9>] (kernel_init) from [<c000dfb9>] (ret_from_fork+0x11/0x38)
[   11.993082] ---[ end trace 62ff5522fb3f41dd ]---

Fix this, and others, with proper locking of cpufreq_driver_lock.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Juri Lelli <juri.lelli@arm.com>
---
 drivers/cpufreq/cpufreq.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 63d6efb..98adbc2 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1585,6 +1585,7 @@ EXPORT_SYMBOL(cpufreq_generic_suspend);
 void cpufreq_suspend(void)
 {
 	struct cpufreq_policy *policy;
+	unsigned long flags;
 
 	if (!cpufreq_driver)
 		return;
@@ -1594,6 +1595,7 @@ void cpufreq_suspend(void)
 
 	pr_debug("%s: Suspending Governors\n", __func__);
 
+	read_lock_irqsave(&cpufreq_driver_lock, flags);
 	for_each_active_policy(policy) {
 		if (__cpufreq_governor(policy, CPUFREQ_GOV_STOP))
 			pr_err("%s: Failed to stop governor for policy: %p\n",
@@ -1603,6 +1605,7 @@ void cpufreq_suspend(void)
 			pr_err("%s: Failed to suspend driver: %p\n", __func__,
 				policy);
 	}
+	read_unlock_irqrestore(&cpufreq_driver_lock, flags);
 
 suspend:
 	cpufreq_suspended = true;
@@ -1617,6 +1620,7 @@ suspend:
 void cpufreq_resume(void)
 {
 	struct cpufreq_policy *policy;
+	unsigned long flags;
 
 	if (!cpufreq_driver)
 		return;
@@ -1628,6 +1632,7 @@ void cpufreq_resume(void)
 
 	pr_debug("%s: Resuming Governors\n", __func__);
 
+	read_lock_irqsave(&cpufreq_driver_lock, flags);
 	for_each_active_policy(policy) {
 		if (cpufreq_driver->resume && cpufreq_driver->resume(policy))
 			pr_err("%s: Failed to resume driver: %p\n", __func__,
@@ -1637,6 +1642,7 @@ void cpufreq_resume(void)
 			pr_err("%s: Failed to start governor for policy: %p\n",
 				__func__, policy);
 	}
+	read_unlock_irqrestore(&cpufreq_driver_lock, flags);
 
 	/*
 	 * schedule call cpufreq_update_policy() for first-online CPU, as that
@@ -2287,7 +2293,9 @@ static int cpufreq_boost_set_sw(int state)
 	struct cpufreq_frequency_table *freq_table;
 	struct cpufreq_policy *policy;
 	int ret = -EINVAL;
+	unsigned long flags;
 
+	read_lock_irqsave(&cpufreq_driver_lock, flags);
 	for_each_active_policy(policy) {
 		freq_table = cpufreq_frequency_get_table(policy->cpu);
 		if (freq_table) {
@@ -2302,6 +2310,7 @@ static int cpufreq_boost_set_sw(int state)
 			__cpufreq_governor(policy, CPUFREQ_GOV_LIMITS);
 		}
 	}
+	read_unlock_irqrestore(&cpufreq_driver_lock, flags);
 
 	return ret;
 }
@@ -2432,14 +2441,16 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data)
 	if (ret)
 		goto err_boost_unreg;
 
-	lockdep_assert_held(&cpufreq_driver_lock);
+	read_lock_irqsave(&cpufreq_driver_lock, flags);
 	if (!(cpufreq_driver->flags & CPUFREQ_STICKY) &&
 	    list_empty(&cpufreq_policy_list)) {
 		/* if all ->init() calls failed, unregister */
 		pr_debug("%s: No CPU initialized for driver %s\n", __func__,
 			 driver_data->name);
+		read_unlock_irqrestore(&cpufreq_driver_lock, flags);
 		goto err_if_unreg;
 	}
+	read_unlock_irqrestore(&cpufreq_driver_lock, flags);
 
 	register_hotcpu_notifier(&cpufreq_cpu_notifier);
 	pr_debug("driver %s up and running\n", driver_data->name);
-- 
2.2.2
