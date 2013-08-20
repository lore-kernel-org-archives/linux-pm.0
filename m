From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 8/9] intel_idle: use the common cpuidle_[un]register() routines
Date: Tue, 20 Aug 2013 16:23:46 +0200
Message-ID: <1377008627-32691-9-git-send-email-b.zolnierkie@samsung.com>
References: <1377008627-32691-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:59206 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751039Ab3HTO0g (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 20 Aug 2013 10:26:36 -0400
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MRU000DD2SBTMI0@mailout3.samsung.com> for
 linux-pm@vger.kernel.org; Tue, 20 Aug 2013 23:26:35 +0900 (KST)
In-reply-to: <1377008627-32691-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: daniel.lezcano@linaro.org
Cc: rjw@sisk.pl, linux-pm@vger.kernel.org, kyungmin.park@samsung.com, b.zolnierkie@samsung.com, Len Brown <lenb@kernel.org>

It is now possible to use the common cpuidle_[un]register() routines
(instead of open-coding them) so do it.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Len Brown <lenb@kernel.org>
---
 drivers/idle/intel_idle.c | 114 ++++++++++++----------------------------------
 1 file changed, 29 insertions(+), 85 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 012a28a..4bfc6fc 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -93,10 +93,8 @@ struct idle_cpu {
 };
 
 static const struct idle_cpu *icpu;
-static struct cpuidle_device __percpu *intel_idle_cpuidle_devices;
 static int intel_idle(struct cpuidle_device *dev,
 			struct cpuidle_driver *drv, int index);
-static int intel_idle_cpu_init(int cpu);
 
 static struct cpuidle_state *cpuidle_state_table;
 
@@ -384,11 +382,27 @@ static void __setup_broadcast_timer(void *arg)
 	clockevents_notify(reason, &cpu);
 }
 
+static void auto_demotion_disable(void *dummy)
+{
+	unsigned long long msr_bits;
+
+	rdmsrl(MSR_NHM_SNB_PKG_CST_CFG_CTL, msr_bits);
+	msr_bits &= ~(icpu->auto_demotion_disable_flags);
+	wrmsrl(MSR_NHM_SNB_PKG_CST_CFG_CTL, msr_bits);
+}
+static void c1e_promotion_disable(void *dummy)
+{
+	unsigned long long msr_bits;
+
+	rdmsrl(MSR_IA32_POWER_CTL, msr_bits);
+	msr_bits &= ~0x2;
+	wrmsrl(MSR_IA32_POWER_CTL, msr_bits);
+}
+
 static int cpu_hotplug_notify(struct notifier_block *n,
 			      unsigned long action, void *hcpu)
 {
 	int hotcpu = (unsigned long)hcpu;
-	struct cpuidle_device *dev;
 
 	switch (action & 0xf) {
 	case CPU_ONLINE:
@@ -400,11 +414,15 @@ static int cpu_hotplug_notify(struct notifier_block *n,
 		/*
 		 * Some systems can hotplug a cpu at runtime after
 		 * the kernel has booted, we have to initialize the
-		 * driver in this case
+		 * hardware in this case.
 		 */
-		dev = per_cpu_ptr(intel_idle_cpuidle_devices, hotcpu);
-		if (!dev->registered)
-			intel_idle_cpu_init(hotcpu);
+		if (icpu->auto_demotion_disable_flags)
+			smp_call_function_single(hotcpu, auto_demotion_disable,
+						NULL, 1);
+
+		if (icpu->disable_promotion_to_c1e)
+			smp_call_function_single(hotcpu, c1e_promotion_disable,
+						NULL, 1);
 
 		break;
 	}
@@ -415,23 +433,6 @@ static struct notifier_block cpu_hotplug_notifier = {
 	.notifier_call = cpu_hotplug_notify,
 };
 
-static void auto_demotion_disable(void *dummy)
-{
-	unsigned long long msr_bits;
-
-	rdmsrl(MSR_NHM_SNB_PKG_CST_CFG_CTL, msr_bits);
-	msr_bits &= ~(icpu->auto_demotion_disable_flags);
-	wrmsrl(MSR_NHM_SNB_PKG_CST_CFG_CTL, msr_bits);
-}
-static void c1e_promotion_disable(void *dummy)
-{
-	unsigned long long msr_bits;
-
-	rdmsrl(MSR_IA32_POWER_CTL, msr_bits);
-	msr_bits &= ~0x2;
-	wrmsrl(MSR_IA32_POWER_CTL, msr_bits);
-}
-
 static const struct idle_cpu idle_cpu_nehalem = {
 	.state_table = nehalem_cstates,
 	.auto_demotion_disable_flags = NHM_C1_AUTO_DEMOTE | NHM_C3_AUTO_DEMOTE,
@@ -538,23 +539,6 @@ static int intel_idle_probe(void)
 }
 
 /*
- * intel_idle_cpuidle_devices_uninit()
- * unregister, free cpuidle_devices
- */
-static void intel_idle_cpuidle_devices_uninit(void)
-{
-	int i;
-	struct cpuidle_device *dev;
-
-	for_each_online_cpu(i) {
-		dev = per_cpu_ptr(intel_idle_cpuidle_devices, i);
-		cpuidle_unregister_device(dev);
-	}
-
-	free_percpu(intel_idle_cpuidle_devices);
-	return;
-}
-/*
  * intel_idle_cpuidle_driver_init()
  * allocate, initialize cpuidle_states
  */
@@ -610,37 +594,9 @@ static int intel_idle_cpuidle_driver_init(void)
 }
 
 
-/*
- * intel_idle_cpu_init()
- * allocate, initialize, register cpuidle_devices
- * @cpu: cpu/core to initialize
- */
-static int intel_idle_cpu_init(int cpu)
-{
-	struct cpuidle_device *dev;
-
-	dev = per_cpu_ptr(intel_idle_cpuidle_devices, cpu);
-
-	dev->cpu = cpu;
-
-	if (cpuidle_register_device(dev)) {
-		pr_debug(PREFIX "cpuidle_register_device %d failed!\n", cpu);
-		intel_idle_cpuidle_devices_uninit();
-		return -EIO;
-	}
-
-	if (icpu->auto_demotion_disable_flags)
-		smp_call_function_single(cpu, auto_demotion_disable, NULL, 1);
-
-	if (icpu->disable_promotion_to_c1e)
-		smp_call_function_single(cpu, c1e_promotion_disable, NULL, 1);
-
-	return 0;
-}
-
 static int __init intel_idle_init(void)
 {
-	int retval, i;
+	int retval;
 
 	/* Do not load intel_idle at all for now if idle= is passed */
 	if (boot_option_idle_override != IDLE_NO_OVERRIDE)
@@ -651,7 +607,8 @@ static int __init intel_idle_init(void)
 		return retval;
 
 	intel_idle_cpuidle_driver_init();
-	retval = cpuidle_register_driver(&intel_idle_driver);
+
+	retval = cpuidle_register(&intel_idle_driver, NULL);
 	if (retval) {
 		struct cpuidle_driver *drv = cpuidle_get_driver();
 		printk(KERN_DEBUG PREFIX "intel_idle yielding to %s",
@@ -659,17 +616,6 @@ static int __init intel_idle_init(void)
 		return retval;
 	}
 
-	intel_idle_cpuidle_devices = alloc_percpu(struct cpuidle_device);
-	if (intel_idle_cpuidle_devices == NULL)
-		return -ENOMEM;
-
-	for_each_online_cpu(i) {
-		retval = intel_idle_cpu_init(i);
-		if (retval) {
-			cpuidle_unregister_driver(&intel_idle_driver);
-			return retval;
-		}
-	}
 	register_cpu_notifier(&cpu_hotplug_notifier);
 
 	return 0;
@@ -677,9 +623,7 @@ static int __init intel_idle_init(void)
 
 static void __exit intel_idle_exit(void)
 {
-	intel_idle_cpuidle_devices_uninit();
-	cpuidle_unregister_driver(&intel_idle_driver);
-
+	cpuidle_unregister(&intel_idle_driver);
 
 	if (lapic_timer_reliable_states != LAPIC_TIMER_ALWAYS_RELIABLE)
 		on_each_cpu(__setup_broadcast_timer, (void *)false, 1);
-- 
1.8.2.3

