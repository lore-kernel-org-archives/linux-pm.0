From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 04/22] idle/intel: Convert to hotplug state machine
Date: Sun, 27 Nov 2016 00:13:32 +0100
Message-ID: <20161126231350.10321-5-bigeasy@linutronix.de>
References: <20161126231350.10321-1-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:43470 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752504AbcKZXOP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 26 Nov 2016 18:14:15 -0500
In-Reply-To: <20161126231350.10321-1-bigeasy@linutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: rt@linutronix.de, tglx@linutronix.de, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org

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
 drivers/idle/intel_idle.c | 106 ++++++++++++++++++------------------------=
----
 1 file changed, 42 insertions(+), 64 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index f53b42a78186..d9631db1b4f5 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -98,8 +98,6 @@ static int intel_idle(struct cpuidle_device *dev,
 			struct cpuidle_driver *drv, int index);
 static void intel_idle_freeze(struct cpuidle_device *dev,
 			      struct cpuidle_driver *drv, int index);
-static int intel_idle_cpu_init(int cpu);
-
 static struct cpuidle_state *cpuidle_state_table;
=20
 /*
@@ -907,50 +905,15 @@ static void intel_idle_freeze(struct cpuidle_device *=
dev,
 	mwait_idle_with_hints(eax, ecx);
 }
=20
-static void __setup_broadcast_timer(void *arg)
+static void __setup_broadcast_timer(bool on)
 {
-	unsigned long on =3D (unsigned long)arg;
-
 	if (on)
 		tick_broadcast_enable();
 	else
 		tick_broadcast_disable();
 }
=20
-static int cpu_hotplug_notify(struct notifier_block *n,
-			      unsigned long action, void *hcpu)
-{
-	int hotcpu =3D (unsigned long)hcpu;
-	struct cpuidle_device *dev;
-
-	switch (action & ~CPU_TASKS_FROZEN) {
-	case CPU_ONLINE:
-
-		if (lapic_timer_reliable_states !=3D LAPIC_TIMER_ALWAYS_RELIABLE)
-			__setup_broadcast_timer((void *)true);
-
-		/*
-		 * Some systems can hotplug a cpu at runtime after
-		 * the kernel has booted, we have to initialize the
-		 * driver in this case
-		 */
-		dev =3D per_cpu_ptr(intel_idle_cpuidle_devices, hotcpu);
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
-static struct notifier_block cpu_hotplug_notifier =3D {
-	.notifier_call =3D cpu_hotplug_notify,
-};
-
-static void auto_demotion_disable(void *dummy)
+static void auto_demotion_disable(void)
 {
 	unsigned long long msr_bits;
=20
@@ -958,7 +921,7 @@ static void auto_demotion_disable(void *dummy)
 	msr_bits &=3D ~(icpu->auto_demotion_disable_flags);
 	wrmsrl(MSR_NHM_SNB_PKG_CST_CFG_CTL, msr_bits);
 }
-static void c1e_promotion_disable(void *dummy)
+static void c1e_promotion_disable(void)
 {
 	unsigned long long msr_bits;
=20
@@ -1372,12 +1335,11 @@ static void __init intel_idle_cpuidle_driver_init(v=
oid)
  * allocate, initialize, register cpuidle_devices
  * @cpu: cpu/core to initialize
  */
-static int intel_idle_cpu_init(int cpu)
+static int intel_idle_cpu_init(unsigned int cpu)
 {
 	struct cpuidle_device *dev;
=20
 	dev =3D per_cpu_ptr(intel_idle_cpuidle_devices, cpu);
-
 	dev->cpu =3D cpu;
=20
 	if (cpuidle_register_device(dev)) {
@@ -1386,17 +1348,38 @@ static int intel_idle_cpu_init(int cpu)
 	}
=20
 	if (icpu->auto_demotion_disable_flags)
-		smp_call_function_single(cpu, auto_demotion_disable, NULL, 1);
+		auto_demotion_disable();
=20
 	if (icpu->disable_promotion_to_c1e)
-		smp_call_function_single(cpu, c1e_promotion_disable, NULL, 1);
+		c1e_promotion_disable();
=20
 	return 0;
 }
=20
+static int intel_idle_cpu_online(unsigned int cpu)
+{
+	struct cpuidle_device *dev;
+
+	if (lapic_timer_reliable_states !=3D LAPIC_TIMER_ALWAYS_RELIABLE)
+		__setup_broadcast_timer(true);
+
+	/*
+	 * Some systems can hotplug a cpu at runtime after
+	 * the kernel has booted, we have to initialize the
+	 * driver in this case
+	 */
+	dev =3D per_cpu_ptr(intel_idle_cpuidle_devices, cpu);
+	if (!dev->registered)
+		return intel_idle_cpu_init(cpu);
+
+	return 0;
+}
+
+static enum cpuhp_state hp_online;
+
 static int __init intel_idle_init(void)
 {
-	int retval, i;
+	int retval;
=20
 	/* Do not load intel_idle at all for now if idle=3D is passed */
 	if (boot_option_idle_override !=3D IDLE_NO_OVERRIDE)
@@ -1416,35 +1399,30 @@ static int __init intel_idle_init(void)
 		struct cpuidle_driver *drv =3D cpuidle_get_driver();
 		printk(KERN_DEBUG PREFIX "intel_idle yielding to %s",
 			drv ? drv->name : "none");
-		free_percpu(intel_idle_cpuidle_devices);
-		return retval;
+		goto init_driver_fail;
 	}
=20
-	cpu_notifier_register_begin();
-
-	for_each_online_cpu(i) {
-		retval =3D intel_idle_cpu_init(i);
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
 		lapic_timer_reliable_states =3D LAPIC_TIMER_ALWAYS_RELIABLE;
-	else
-		on_each_cpu(__setup_broadcast_timer, (void *)true, 1);
=20
-	cpu_notifier_register_done();
+	retval =3D cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "idle/intel:online",
+				   intel_idle_cpu_online, NULL);
+	if (retval < 0)
+		goto hp_setup_fail;
+	hp_online =3D retval;
=20
 	pr_debug(PREFIX "lapic_timer_reliable_states 0x%x\n",
 		lapic_timer_reliable_states);
=20
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
=20
--=20
2.10.2

