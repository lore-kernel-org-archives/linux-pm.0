From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch V2 12/12] thermal/x86 pkg temp: Convert to hotplug state
 machine
Date: Tue, 22 Nov 2016 17:57:15 -0000
Message-ID: <20161122175357.874883446@linutronix.de>
References: <20161122175256.922158782@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:60571 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933968AbcKVSAR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Nov 2016 13:00:17 -0500
Content-Disposition: inline;
 filename=thermalx86_pkg_temp_Convert_to_hotplug_state_machine.patch
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Rui Zhang <rui.zhang@intel.com>, edubezval@gmail.com, Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, linux-pm@vger.kernel.org, x86@kernel.org, rt@linutronix.de, Srinivas Pandruvada <srinivas.pandruvada@intel.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Install the callbacks via the state machine and let the core invoke
the callbacks on the already online CPUs.

Replace the wrmsr/rdmrs_on_cpu() calls in the hotplug callbacks as they are
guaranteed to be invoked on the incoming/outgoing cpu.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 drivers/thermal/x86_pkg_temp_thermal.c |   80 +++++++++------------------------
 1 file changed, 23 insertions(+), 57 deletions(-)

--- a/drivers/thermal/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/x86_pkg_temp_thermal.c
@@ -79,6 +79,9 @@ static DEFINE_SPINLOCK(pkg_temp_lock);
 /* Protects zone operation in the work function against hotplug removal */
 static DEFINE_MUTEX(thermal_zone_mutex);
 
+/* The dynamically assigned cpu hotplug state for module_exit() */
+static enum cpuhp_state pkg_thermal_hp_state __read_mostly;
+
 /* Debug counters to show using debugfs */
 static struct dentry *debugfs;
 static unsigned int pkg_interrupt_cnt;
@@ -386,9 +389,8 @@ static int pkg_temp_thermal_device_add(u
 		return err;
 	}
 	/* Store MSR value for package thermal interrupt, to restore at exit */
-	rdmsr_on_cpu(cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT,
-		     &pkgdev->msr_pkg_therm_low,
-		     &pkgdev->msr_pkg_therm_high);
+	rdmsr(MSR_IA32_PACKAGE_THERM_INTERRUPT, pkgdev->msr_pkg_therm_low,
+	      pkgdev->msr_pkg_therm_high);
 
 	cpumask_set_cpu(cpu, &pkgdev->cpumask);
 	spin_lock_irq(&pkg_temp_lock);
@@ -397,14 +399,14 @@ static int pkg_temp_thermal_device_add(u
 	return 0;
 }
 
-static void put_core_offline(unsigned int cpu)
+static int pkg_thermal_cpu_offline(unsigned int cpu)
 {
 	struct pkg_device *pkgdev = pkg_temp_thermal_get_dev(cpu);
 	bool lastcpu, was_target;
 	int target;
 
 	if (!pkgdev)
-		return;
+		return 0;
 
 	target = cpumask_any_but(&pkgdev->cpumask, cpu);
 	cpumask_clear_cpu(cpu, &pkgdev->cpumask);
@@ -448,16 +450,9 @@ static void put_core_offline(unsigned in
 	 */
 	if (lastcpu) {
 		packages[topology_logical_package_id(cpu)] = NULL;
-		/*
-		 * After this point nothing touches the MSR anymore. We
-		 * must drop the lock to make the cross cpu call. This goes
-		 * away once we move that code to the hotplug state machine.
-		 */
-		spin_unlock_irq(&pkg_temp_lock);
-		wrmsr_on_cpu(cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT,
-			     pkgdev->msr_pkg_therm_low,
-			     pkgdev->msr_pkg_therm_high);
-		spin_lock_irq(&pkg_temp_lock);
+		/* After this point nothing touches the MSR anymore. */
+		wrmsr(MSR_IA32_PACKAGE_THERM_INTERRUPT,
+		      pkgdev->msr_pkg_therm_low, pkgdev->msr_pkg_therm_high);
 	}
 
 	/*
@@ -487,9 +482,10 @@ static void put_core_offline(unsigned in
 	/* Final cleanup if this is the last cpu */
 	if (lastcpu)
 		kfree(pkgdev);
+	return 0;
 }
 
-static int get_core_online(unsigned int cpu)
+static int pkg_thermal_cpu_online(unsigned int cpu)
 {
 	struct pkg_device *pkgdev = pkg_temp_thermal_get_dev(cpu);
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
@@ -506,27 +502,6 @@ static int get_core_online(unsigned int
 	return pkg_temp_thermal_device_add(cpu);
 }
 
-static int pkg_temp_thermal_cpu_callback(struct notifier_block *nfb,
-				 unsigned long action, void *hcpu)
-{
-	unsigned int cpu = (unsigned long) hcpu;
-
-	switch (action & ~CPU_TASKS_FROZEN) {
-	case CPU_ONLINE:
-	case CPU_DOWN_FAILED:
-		get_core_online(cpu);
-		break;
-	case CPU_DOWN_PREPARE:
-		put_core_offline(cpu);
-		break;
-	}
-	return NOTIFY_OK;
-}
-
-static struct notifier_block pkg_temp_thermal_notifier __refdata = {
-	.notifier_call = pkg_temp_thermal_cpu_callback,
-};
-
 static const struct x86_cpu_id __initconst pkg_temp_thermal_ids[] = {
 	{ X86_VENDOR_INTEL, X86_FAMILY_ANY, X86_MODEL_ANY, X86_FEATURE_PTS },
 	{}
@@ -535,7 +510,7 @@ MODULE_DEVICE_TABLE(x86cpu, pkg_temp_the
 
 static int __init pkg_temp_thermal_init(void)
 {
-	int i;
+	int ret;
 
 	if (!x86_match_cpu(pkg_temp_thermal_ids))
 		return -ENODEV;
@@ -545,12 +520,13 @@ static int __init pkg_temp_thermal_init(
 	if (!packages)
 		return -ENOMEM;
 
-	cpu_notifier_register_begin();
-	for_each_online_cpu(i)
-		if (get_core_online(i))
-			goto err_ret;
-	__register_hotcpu_notifier(&pkg_temp_thermal_notifier);
-	cpu_notifier_register_done();
+	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "thermal/x86_pkg:online",
+				pkg_thermal_cpu_online,	pkg_thermal_cpu_offline);
+	if (ret < 0)
+		goto err;
+
+	/* Store the state for module exit */
+	pkg_thermal_hp_state = ret;
 
 	platform_thermal_package_notify = pkg_thermal_notify;
 	platform_thermal_package_rate_control = pkg_thermal_rate_control;
@@ -559,28 +535,18 @@ static int __init pkg_temp_thermal_init(
 	pkg_temp_debugfs_init();
 	return 0;
 
-err_ret:
-	for_each_online_cpu(i)
-		put_core_offline(i);
-	cpu_notifier_register_done();
+err:
 	kfree(packages);
-	return -ENODEV;
+	return ret;
 }
 module_init(pkg_temp_thermal_init)
 
 static void __exit pkg_temp_thermal_exit(void)
 {
-	int i;
-
 	platform_thermal_package_notify = NULL;
 	platform_thermal_package_rate_control = NULL;
 
-	cpu_notifier_register_begin();
-	__unregister_hotcpu_notifier(&pkg_temp_thermal_notifier);
-	for_each_online_cpu(i)
-		put_core_offline(i);
-	cpu_notifier_register_done();
-
+	cpuhp_remove_state(pkg_thermal_hp_state);
 	debugfs_remove_recursive(debugfs);
 	kfree(packages);
 }


