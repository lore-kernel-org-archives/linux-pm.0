From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 04/22 v2] idle/intel: Convert to hotplug state machine
Date: Tue, 29 Nov 2016 10:51:43 +0100
Message-ID: <20161129095143.w6k2ytljvujbuatk@linutronix.de>
References: <20161126231350.10321-1-bigeasy@linutronix.de>
 <20161126231350.10321-5-bigeasy@linutronix.de>
 <alpine.DEB.2.20.1611281828050.3512@nanos>
 <20161129094000.5wqdcjutlx57kq4i@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:50402 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751522AbcK2Jvq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Nov 2016 04:51:46 -0500
Content-Disposition: inline
In-Reply-To: <20161129094000.5wqdcjutlx57kq4i@linutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-pm@vger.kernel.org, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, rt@linutronix.de

Install the callbacks via the state machine and let the core invoke the
callbacks on the already online CPUs.

The two smp_call_function_single() invocations in intel_idle_cpu_init() have
been removed because intel_idle_cpu_init() is now invoked via the hotplug
callback which runs on the target CPU. The IRQ-off calling convention for
auto_demotion_disable() and c1e_promotion_disable() has not been preserved
because only those two modify the MSR during CPU intialization.

Cc: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
v1…v2: drop the superfluous saving of the hotplug state (not a module
anymore).

 drivers/idle/intel_idle.c | 103 ++++++++++++++++++----------------------------
 1 file changed, 39 insertions(+), 64 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index f53b42a78186..df532c4398e5 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -98,8 +98,6 @@ static int intel_idle(struct cpuidle_device *dev,
 			struct cpuidle_driver *drv, int index);
 static void intel_idle_freeze(struct cpuidle_device *dev,
 			      struct cpuidle_driver *drv, int index);
-static int intel_idle_cpu_init(int cpu);
-
 static struct cpuidle_state *cpuidle_state_table;
 
 /*
@@ -907,50 +905,15 @@ static void intel_idle_freeze(struct cpuidle_device *dev,
 	mwait_idle_with_hints(eax, ecx);
 }
 
-static void __setup_broadcast_timer(void *arg)
+static void __setup_broadcast_timer(bool on)
 {
-	unsigned long on = (unsigned long)arg;
-
 	if (on)
 		tick_broadcast_enable();
 	else
 		tick_broadcast_disable();
 }
 
-static int cpu_hotplug_notify(struct notifier_block *n,
-			      unsigned long action, void *hcpu)
-{
-	int hotcpu = (unsigned long)hcpu;
-	struct cpuidle_device *dev;
-
-	switch (action & ~CPU_TASKS_FROZEN) {
-	case CPU_ONLINE:
-
-		if (lapic_timer_reliable_states != LAPIC_TIMER_ALWAYS_RELIABLE)
-			__setup_broadcast_timer((void *)true);
-
-		/*
-		 * Some systems can hotplug a cpu at runtime after
-		 * the kernel has booted, we have to initialize the
-		 * driver in this case
-		 */
-		dev = per_cpu_ptr(intel_idle_cpuidle_devices, hotcpu);
-		if (dev->registered)
-			break;
-
-		if (intel_idle_cpu_init(hotcpu))
-			return NOTIFY_BAD;
-
-		break;
-	}
-	return NOTIFY_OK;
-}
-
-static struct notifier_block cpu_hotplug_notifier = {
-	.notifier_call = cpu_hotplug_notify,
-};
-
-static void auto_demotion_disable(void *dummy)
+static void auto_demotion_disable(void)
 {
 	unsigned long long msr_bits;
 
@@ -958,7 +921,7 @@ static void auto_demotion_disable(void *dummy)
 	msr_bits &= ~(icpu->auto_demotion_disable_flags);
 	wrmsrl(MSR_NHM_SNB_PKG_CST_CFG_CTL, msr_bits);
 }
-static void c1e_promotion_disable(void *dummy)
+static void c1e_promotion_disable(void)
 {
 	unsigned long long msr_bits;
 
@@ -1372,12 +1335,11 @@ static void __init intel_idle_cpuidle_driver_init(void)
  * allocate, initialize, register cpuidle_devices
  * @cpu: cpu/core to initialize
  */
-static int intel_idle_cpu_init(int cpu)
+static int intel_idle_cpu_init(unsigned int cpu)
 {
 	struct cpuidle_device *dev;
 
 	dev = per_cpu_ptr(intel_idle_cpuidle_devices, cpu);
-
 	dev->cpu = cpu;
 
 	if (cpuidle_register_device(dev)) {
@@ -1386,17 +1348,36 @@ static int intel_idle_cpu_init(int cpu)
 	}
 
 	if (icpu->auto_demotion_disable_flags)
-		smp_call_function_single(cpu, auto_demotion_disable, NULL, 1);
+		auto_demotion_disable();
 
 	if (icpu->disable_promotion_to_c1e)
-		smp_call_function_single(cpu, c1e_promotion_disable, NULL, 1);
+		c1e_promotion_disable();
+
+	return 0;
+}
+
+static int intel_idle_cpu_online(unsigned int cpu)
+{
+	struct cpuidle_device *dev;
+
+	if (lapic_timer_reliable_states != LAPIC_TIMER_ALWAYS_RELIABLE)
+		__setup_broadcast_timer(true);
+
+	/*
+	 * Some systems can hotplug a cpu at runtime after
+	 * the kernel has booted, we have to initialize the
+	 * driver in this case
+	 */
+	dev = per_cpu_ptr(intel_idle_cpuidle_devices, cpu);
+	if (!dev->registered)
+		return intel_idle_cpu_init(cpu);
 
 	return 0;
 }
 
 static int __init intel_idle_init(void)
 {
-	int retval, i;
+	int retval;
 
 	/* Do not load intel_idle at all for now if idle= is passed */
 	if (boot_option_idle_override != IDLE_NO_OVERRIDE)
@@ -1416,35 +1397,29 @@ static int __init intel_idle_init(void)
 		struct cpuidle_driver *drv = cpuidle_get_driver();
 		printk(KERN_DEBUG PREFIX "intel_idle yielding to %s",
 			drv ? drv->name : "none");
-		free_percpu(intel_idle_cpuidle_devices);
-		return retval;
+		goto init_driver_fail;
 	}
 
-	cpu_notifier_register_begin();
-
-	for_each_online_cpu(i) {
-		retval = intel_idle_cpu_init(i);
-		if (retval) {
-			intel_idle_cpuidle_devices_uninit();
-			cpu_notifier_register_done();
-			cpuidle_unregister_driver(&intel_idle_driver);
-			free_percpu(intel_idle_cpuidle_devices);
-			return retval;
-		}
-	}
-	__register_cpu_notifier(&cpu_hotplug_notifier);
-
 	if (boot_cpu_has(X86_FEATURE_ARAT))	/* Always Reliable APIC Timer */
 		lapic_timer_reliable_states = LAPIC_TIMER_ALWAYS_RELIABLE;
-	else
-		on_each_cpu(__setup_broadcast_timer, (void *)true, 1);
 
-	cpu_notifier_register_done();
+	retval = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "idle/intel:online",
+				   intel_idle_cpu_online, NULL);
+	if (retval < 0)
+		goto hp_setup_fail;
 
 	pr_debug(PREFIX "lapic_timer_reliable_states 0x%x\n",
 		lapic_timer_reliable_states);
 
 	return 0;
+
+hp_setup_fail:
+	intel_idle_cpuidle_devices_uninit();
+	cpuidle_unregister_driver(&intel_idle_driver);
+init_driver_fail:
+	free_percpu(intel_idle_cpuidle_devices);
+	return retval;
+
 }
 device_initcall(intel_idle_init);
 
-- 
2.10.2

