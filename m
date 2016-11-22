From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch V2 08/12] thermal/x86_pkg_temp: Sanitize locking
Date: Tue, 22 Nov 2016 17:57:10 -0000
Message-ID: <20161122175357.525687179@linutronix.de>
References: <20161122175256.922158782@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline;
 filename=thermalx86_pkg_temp_Sanitize_locking.patch
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Rui Zhang <rui.zhang@intel.com>, edubezval@gmail.com, Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, linux-pm@vger.kernel.org, x86@kernel.org, rt@linutronix.de, Srinivas Pandruvada <srinivas.pandruvada@intel.com>
List-Id: linux-pm@vger.kernel.org

The work cancellation code, the thermal zone unregistering, the work code
and the interrupt notification function are racy against each other and
against cpu hotplug and module exit. The random locking sprinkeled all
over the place does not help anything and probably exists to make people
feel good. The resulting issues (mainly use after free) are probably
hard to trigger, but they clearly exist

Protect the package list with a spinlock so it can be accessed from the
interrupt notifier and also from the work function. The add/removal code in
the hotplug callbacks take the lock for list manipulation. That makes sure
that on removal neither the interrupt notifier nor the work function can
access the about to be freed package structure anymore.

The thermal zone unregistering is another trainwreck. It's not serialized
against the work function. So unregistering the zone device can race with
the work function and cause havoc.

Protect the thermal zone with a mutex, which is held in the work
function to make sure that the zone device is not being unregistered
concurrently.

To solve the module exit issues, we simply invoke the cpu offline callback
and let it work its magic. For that it's required to keep track of the
participating cpus in a package, because topology_core_mask is not affected
by calling the offline callback for teardown of the driver, so it would
never free the package as there is always a valid target in
topology_core_mask.

Use proper names for the locks so it's clear what they are for and add a
pile of comments to explain the protection rules.

It's amazing that fixing the locking and adding 30 lines of comments
explaining it still removes more lines than it adds.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 drivers/thermal/x86_pkg_temp_thermal.c |  222 ++++++++++++++++-----------------
 1 file changed, 110 insertions(+), 112 deletions(-)

--- a/drivers/thermal/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/x86_pkg_temp_thermal.c
@@ -65,6 +65,7 @@ struct pkg_device {
 	u32				msr_pkg_therm_low;
 	u32				msr_pkg_therm_high;
 	struct thermal_zone_device	*tzone;
+	struct cpumask			cpumask;
 };
 
 static struct thermal_zone_params pkg_temp_tz_params = {
@@ -73,7 +74,10 @@ static struct thermal_zone_params pkg_te
 
 /* List maintaining number of package instances */
 static LIST_HEAD(phy_dev_list);
-static DEFINE_MUTEX(phy_dev_list_mutex);
+/* Serializes interrupt notification, work and hotplug */
+static DEFINE_SPINLOCK(pkg_temp_lock);
+/* Protects zone operation in the work function against hotplug removal */
+static DEFINE_MUTEX(thermal_zone_mutex);
 
 /* Interrupt to work function schedule queue */
 static DEFINE_PER_CPU(struct delayed_work, pkg_temp_thermal_threshold_work);
@@ -81,8 +85,6 @@ static DEFINE_PER_CPU(struct delayed_wor
 /* To track if the work is already scheduled on a package */
 static u8 *pkg_work_scheduled;
 
-/* Spin lock to prevent races with pkg_work_scheduled */
-static spinlock_t pkg_work_lock;
 static u16 max_phy_id;
 
 /* Debug counters to show using debugfs */
@@ -115,21 +117,23 @@ static int pkg_temp_debugfs_init(void)
 	return -ENOENT;
 }
 
+/*
+ * Protection:
+ *
+ * - cpu hotplug: Read serialized by cpu hotplug lock
+ *		  Write must hold pkg_temp_lock
+ *
+ * - Other callsites: Must hold pkg_temp_lock
+ */
 static struct pkg_device *pkg_temp_thermal_get_dev(unsigned int cpu)
 {
 	u16 phys_proc_id = topology_physical_package_id(cpu);
 	struct pkg_device *pkgdev;
 
-	mutex_lock(&phy_dev_list_mutex);
-
-	list_for_each_entry(pkgdev, &phy_dev_list, list)
-		if (pkgdev->phys_proc_id == phys_proc_id) {
-			mutex_unlock(&phy_dev_list_mutex);
+	list_for_each_entry(pkgdev, &phy_dev_list, list) {
+		if (pkgdev->phys_proc_id == phys_proc_id)
 			return pkgdev;
-		}
-
-	mutex_unlock(&phy_dev_list_mutex);
-
+	}
 	return NULL;
 }
 
@@ -289,67 +293,66 @@ static inline void disable_pkg_thres_int
 
 static void pkg_temp_thermal_threshold_work_fn(struct work_struct *work)
 {
-	int cpu = smp_processor_id();
-	struct pkg_device *pkgdev = pkg_temp_thermal_get_dev(cpu);
-	int phy_id = topology_physical_package_id(cpu);
-	bool notify = false;
-	unsigned long flags;
+	struct thermal_zone_device *tzone = NULL;
+	int phy_id, cpu = smp_processor_id();
+	struct pkg_device *pkgdev;
 	u64 msr_val, wr_val;
 
-	if (!pkgdev)
-		return;
-
-	spin_lock_irqsave(&pkg_work_lock, flags);
+	mutex_lock(&thermal_zone_mutex);
+	spin_lock_irq(&pkg_temp_lock);
 	++pkg_work_cnt;
-	if (unlikely(phy_id > max_phy_id)) {
-		spin_unlock_irqrestore(&pkg_work_lock, flags);
+
+	pkgdev = pkg_temp_thermal_get_dev(cpu);
+	if (!pkgdev) {
+		spin_unlock_irq(&pkg_temp_lock);
+		mutex_unlock(&thermal_zone_mutex);
 		return;
 	}
+
 	pkg_work_scheduled[phy_id] = 0;
-	spin_unlock_irqrestore(&pkg_work_lock, flags);
 
 	rdmsrl(MSR_IA32_PACKAGE_THERM_STATUS, msr_val);
 	wr_val = msr_val & ~(THERM_LOG_THRESHOLD0 | THERM_LOG_THRESHOLD1);
 	if (wr_val != msr_val) {
 		wrmsrl(MSR_IA32_PACKAGE_THERM_STATUS, wr_val);
-		notify = true;
+		tzone = pkgdev->tzone;
 	}
 
 	enable_pkg_thres_interrupt();
+	spin_unlock_irq(&pkg_temp_lock);
 
-	if (notify) {
-		pr_debug("thermal_zone_device_update\n");
-		thermal_zone_device_update(pkgdev->tzone,
-					   THERMAL_EVENT_UNSPECIFIED);
-	}
+	/*
+	 * If tzone is not NULL, then thermal_zone_mutex will prevent the
+	 * concurrent removal in the cpu offline callback.
+	 */
+	if (tzone)
+		thermal_zone_device_update(tzone, THERMAL_EVENT_UNSPECIFIED);
+
+	mutex_unlock(&thermal_zone_mutex);
 }
 
 static int pkg_thermal_notify(u64 msr_val)
 {
 	int cpu = smp_processor_id();
 	int phy_id = topology_physical_package_id(cpu);
+	struct pkg_device *pkgdev;
 	unsigned long flags;
 
-	/*
-	* When a package is in interrupted state, all CPU's in that package
-	* are in the same interrupt state. So scheduling on any one CPU in
-	* the package is enough and simply return for others.
-	*/
-	spin_lock_irqsave(&pkg_work_lock, flags);
+	spin_lock_irqsave(&pkg_temp_lock, flags);
 	++pkg_interrupt_cnt;
-	if (unlikely(phy_id > max_phy_id) || unlikely(!pkg_work_scheduled) ||
-			pkg_work_scheduled[phy_id]) {
-		disable_pkg_thres_interrupt();
-		spin_unlock_irqrestore(&pkg_work_lock, flags);
-		return -EINVAL;
-	}
-	pkg_work_scheduled[phy_id] = 1;
-	spin_unlock_irqrestore(&pkg_work_lock, flags);
 
 	disable_pkg_thres_interrupt();
-	schedule_delayed_work_on(cpu,
+
+	/* Work is per package, so scheduling it once is enough. */
+	pkgdev = pkg_temp_thermal_get_dev(cpu);
+	if (pkgdev && pkg_work_scheduled && !pkg_work_scheduled[phy_id]) {
+		pkg_work_scheduled[phy_id] = 1;
+		schedule_delayed_work_on(cpu,
 				&per_cpu(pkg_temp_thermal_threshold_work, cpu),
 				msecs_to_jiffies(notify_delay_ms));
+	}
+
+	spin_unlock_irqrestore(&pkg_temp_lock, flags);
 	return 0;
 }
 
@@ -373,29 +376,25 @@ static int pkg_temp_thermal_device_add(u
 
 	err = get_tj_max(cpu, &tj_max);
 	if (err)
-		goto err_ret;
-
-	mutex_lock(&phy_dev_list_mutex);
+		return err;
 
 	pkgdev = kzalloc(sizeof(*pkgdev), GFP_KERNEL);
-	if (!pkgdev) {
-		err = -ENOMEM;
-		goto err_ret_unlock;
-	}
+	if (!pkgdev)
+		return -ENOMEM;
 
-	spin_lock_irqsave(&pkg_work_lock, flags);
+	spin_lock_irqsave(&pkg_temp_lock, flags);
 	if (topology_physical_package_id(cpu) > max_phy_id)
 		max_phy_id = topology_physical_package_id(cpu);
 	temp = krealloc(pkg_work_scheduled,
 			(max_phy_id+1) * sizeof(u8), GFP_ATOMIC);
 	if (!temp) {
-		spin_unlock_irqrestore(&pkg_work_lock, flags);
-		err = -ENOMEM;
-		goto err_ret_free;
+		spin_unlock_irqrestore(&pkg_temp_lock, flags);
+		kfree(pkgdev);
+		return -ENOMEM;
 	}
 	pkg_work_scheduled = temp;
 	pkg_work_scheduled[topology_physical_package_id(cpu)] = 0;
-	spin_unlock_irqrestore(&pkg_work_lock, flags);
+	spin_unlock_irqrestore(&pkg_temp_lock, flags);
 
 	pkgdev->phys_proc_id = topology_physical_package_id(cpu);
 	pkgdev->cpu = cpu;
@@ -406,60 +405,81 @@ static int pkg_temp_thermal_device_add(u
 			pkgdev, &tzone_ops, &pkg_temp_tz_params, 0, 0);
 	if (IS_ERR(pkgdev->tzone)) {
 		err = PTR_ERR(pkgdev->tzone);
-		goto err_ret_free;
+		kfree(pkgdev);
+		return err;
 	}
 	/* Store MSR value for package thermal interrupt, to restore at exit */
 	rdmsr_on_cpu(cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT,
 		     &pkgdev->msr_pkg_therm_low,
 		     &pkgdev->msr_pkg_therm_high);
 
+	cpumask_set_cpu(cpu, &pkgdev->cpumask);
+	spin_lock_irq(&pkg_temp_lock);
 	list_add_tail(&pkgdev->list, &phy_dev_list);
-	pr_debug("pkg_temp_thermal_device_add :phy_id %d cpu %d\n",
-		 pkgdev->phys_proc_id, cpu);
-
-	mutex_unlock(&phy_dev_list_mutex);
-
+	spin_unlock_irq(&pkg_temp_lock);
 	return 0;
-
-err_ret_free:
-	kfree(pkgdev);
-err_ret_unlock:
-	mutex_unlock(&phy_dev_list_mutex);
-
-err_ret:
-	return err;
 }
 
-static int pkg_temp_thermal_device_remove(unsigned int cpu)
+static void put_core_offline(unsigned int cpu)
 {
 	struct pkg_device *pkgdev = pkg_temp_thermal_get_dev(cpu);
+	bool lastcpu;
 	int target;
 
 	if (!pkgdev)
-		return -ENODEV;
+		return;
 
-	mutex_lock(&phy_dev_list_mutex);
+	target = cpumask_any_but(&pkgdev->cpumask, cpu);
+	cpumask_clear_cpu(cpu, &pkgdev->cpumask);
+	lastcpu = target >= nr_cpu_ids;
+	/*
+	 * Remove the sysfs files, if this is the last cpu in the package
+	 * before doing further cleanups.
+	 */
+	if (lastcpu) {
+		struct thermal_zone_device *tzone = pkgdev->tzone;
+
+		/*
+		 * We must protect against a work function calling
+		 * thermal_zone_update, after/while unregister. We null out
+		 * the pointer under the zone mutex, so the worker function
+		 * won't try to call.
+		 */
+		mutex_lock(&thermal_zone_mutex);
+		pkgdev->tzone = NULL;
+		mutex_unlock(&thermal_zone_mutex);
 
-	target = cpumask_any_but(topology_core_cpumask(cpu), cpu);
-	/* This might be the last cpu in this package */
-	if (target >= nr_cpu_ids) {
-		thermal_zone_device_unregister(pkgdev->tzone);
+		thermal_zone_device_unregister(tzone);
+	}
+
+	/*
+	 * If this is the last CPU in the package, restore the interrupt
+	 * MSR and remove the package reference from the array.
+	 */
+	if (lastcpu) {
+		/* Protect against work and interrupts */
+		spin_lock_irq(&pkg_temp_lock);
+		list_del(&pkgdev->list);
 		/*
-		 * Restore original MSR value for package thermal
-		 * interrupt.
+		 * After this point nothing touches the MSR anymore. We
+		 * must drop the lock to make the cross cpu call. This goes
+		 * away once we move that code to the hotplug state machine.
 		 */
+		spin_unlock_irq(&pkg_temp_lock);
 		wrmsr_on_cpu(cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT,
 			     pkgdev->msr_pkg_therm_low,
 			     pkgdev->msr_pkg_therm_high);
-		list_del(&pkgdev->list);
 		kfree(pkgdev);
-	} else if (pkgdev->cpu == cpu) {
-		pkgdev->cpu = target;
 	}
 
-	mutex_unlock(&phy_dev_list_mutex);
-
-	return 0;
+	/*
+	 * Note, this is broken when work was really scheduled on the
+	 * outgoing cpu because this will leave the work_scheduled flag set
+	 * and the thermal interrupts disabled. Will be fixed in the next
+	 * step as there is no way to fix it in a sane way with the per cpu
+	 * work nonsense.
+	 */
+	cancel_delayed_work_sync(&per_cpu(pkg_temp_thermal_threshold_work, cpu));
 }
 
 static int get_core_online(unsigned int cpu)
@@ -475,20 +495,13 @@ static int get_core_online(unsigned int
 			  pkg_temp_thermal_threshold_work_fn);
 
 	/* If the package exists, nothing to do */
-	if (pkgdev)
+	if (pkgdev) {
+		cpumask_set_cpu(cpu, &pkgdev->cpumask);
 		return 0;
+	}
 	return pkg_temp_thermal_device_add(cpu);
 }
 
-static void put_core_offline(unsigned int cpu)
-{
-	if (!pkg_temp_thermal_device_remove(cpu))
-		cancel_delayed_work_sync(
-			&per_cpu(pkg_temp_thermal_threshold_work, cpu));
-
-	pr_debug("put_core_offline: cpu %d\n", cpu);
-}
-
 static int pkg_temp_thermal_cpu_callback(struct notifier_block *nfb,
 				 unsigned long action, void *hcpu)
 {
@@ -523,8 +536,6 @@ static int __init pkg_temp_thermal_init(
 	if (!x86_match_cpu(pkg_temp_thermal_ids))
 		return -ENODEV;
 
-	spin_lock_init(&pkg_work_lock);
-
 	cpu_notifier_register_begin();
 	for_each_online_cpu(i)
 		if (get_core_online(i))
@@ -550,7 +561,6 @@ module_init(pkg_temp_thermal_init)
 
 static void __exit pkg_temp_thermal_exit(void)
 {
-	struct pkg_device *pkgdev, *n;
 	int i;
 
 	platform_thermal_package_notify = NULL;
@@ -558,20 +568,8 @@ static void __exit pkg_temp_thermal_exit
 
 	cpu_notifier_register_begin();
 	__unregister_hotcpu_notifier(&pkg_temp_thermal_notifier);
-	mutex_lock(&phy_dev_list_mutex);
-	list_for_each_entry_safe(pkgdev, n, &phy_dev_list, list) {
-		/* Retore old MSR value for package thermal interrupt */
-		wrmsr_on_cpu(pkgdev->cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT,
-			     pkgdev->msr_pkg_therm_low,
-			     pkgdev->msr_pkg_therm_high);
-		thermal_zone_device_unregister(pkgdev->tzone);
-		list_del(&pkgdev->list);
-		kfree(pkgdev);
-	}
-	mutex_unlock(&phy_dev_list_mutex);
 	for_each_online_cpu(i)
-		cancel_delayed_work_sync(
-			&per_cpu(pkg_temp_thermal_threshold_work, i));
+		put_core_offline(i);
 	cpu_notifier_register_done();
 
 	kfree(pkg_work_scheduled);
