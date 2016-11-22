From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch V2 10/12] thermal/x86_pkg_temp: Move work into package struct
Date: Tue, 22 Nov 2016 17:57:13 -0000
Message-ID: <20161122175357.699222194@linutronix.de>
References: <20161122175256.922158782@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline;
 filename=thermalx86_pkg_temp_Move_work_into_package_struct.patch
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Rui Zhang <rui.zhang@intel.com>, edubezval@gmail.com, Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, linux-pm@vger.kernel.org, x86@kernel.org, rt@linutronix.de, Srinivas Pandruvada <srinivas.pandruvada@intel.com>
List-Id: linux-pm@vger.kernel.org

Delayed work structs are held in a static percpu storage, which makes no
sense at all because work is strictly per package and we never schedule
more than one work per package.

Aside of that the work cancelation in the hotplug is broken when the work
is queued on the outgoing cpu and canceled. Nothing reschedules the work on
another online cpu in the package, so the interrupts stay disabled and the
work_scheduled flag stays active.

Move the delayed work struct into the package struct, which is the only
sensible place to have it.

To simplify the cancelation logic schedule the work always on the cpu which
is the target for the sysfs files. This is required so the cancelation
logic in the cpu offline path cancels only when the outgoing cpu is the
current target and reschedule the work when there is still a online
CPU in the package.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 drivers/thermal/x86_pkg_temp_thermal.c |   73 +++++++++++++++++++++++----------
 1 file changed, 52 insertions(+), 21 deletions(-)

--- a/drivers/thermal/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/x86_pkg_temp_thermal.c
@@ -65,6 +65,7 @@ struct pkg_device {
 	u32				tj_max;
 	u32				msr_pkg_therm_low;
 	u32				msr_pkg_therm_high;
+	struct delayed_work		work;
 	struct thermal_zone_device	*tzone;
 	struct cpumask			cpumask;
 };
@@ -80,9 +81,6 @@ static DEFINE_SPINLOCK(pkg_temp_lock);
 /* Protects zone operation in the work function against hotplug removal */
 static DEFINE_MUTEX(thermal_zone_mutex);
 
-/* Interrupt to work function schedule queue */
-static DEFINE_PER_CPU(struct delayed_work, pkg_temp_thermal_threshold_work);
-
 /* Debug counters to show using debugfs */
 static struct dentry *debugfs;
 static unsigned int pkg_interrupt_cnt;
@@ -326,6 +324,13 @@ static void pkg_temp_thermal_threshold_w
 	mutex_unlock(&thermal_zone_mutex);
 }
 
+static void pkg_thermal_schedule_work(int cpu, struct delayed_work *work)
+{
+	unsigned long ms = msecs_to_jiffies(notify_delay_ms);
+
+	schedule_delayed_work_on(cpu, work, ms);
+}
+
 static int pkg_thermal_notify(u64 msr_val)
 {
 	int cpu = smp_processor_id();
@@ -341,9 +346,7 @@ static int pkg_thermal_notify(u64 msr_va
 	pkgdev = pkg_temp_thermal_get_dev(cpu);
 	if (pkgdev && !pkgdev->work_scheduled) {
 		pkgdev->work_scheduled = true;
-		schedule_delayed_work_on(cpu,
-				&per_cpu(pkg_temp_thermal_threshold_work, cpu),
-				msecs_to_jiffies(notify_delay_ms));
+		pkg_thermal_schedule_work(pkgdev->cpu, &pkgdev->work);
 	}
 
 	spin_unlock_irqrestore(&pkg_temp_lock, flags);
@@ -374,6 +377,7 @@ static int pkg_temp_thermal_device_add(u
 	if (!pkgdev)
 		return -ENOMEM;
 
+	INIT_DELAYED_WORK(&pkgdev->work, pkg_temp_thermal_threshold_work_fn);
 	pkgdev->phys_proc_id = topology_physical_package_id(cpu);
 	pkgdev->cpu = cpu;
 	pkgdev->tj_max = tj_max;
@@ -401,7 +405,7 @@ static int pkg_temp_thermal_device_add(u
 static void put_core_offline(unsigned int cpu)
 {
 	struct pkg_device *pkgdev = pkg_temp_thermal_get_dev(cpu);
-	bool lastcpu;
+	bool lastcpu, was_target;
 	int target;
 
 	if (!pkgdev)
@@ -430,13 +434,24 @@ static void put_core_offline(unsigned in
 		thermal_zone_device_unregister(tzone);
 	}
 
+	/* Protect against work and interrupts */
+	spin_lock_irq(&pkg_temp_lock);
+
 	/*
-	 * If this is the last CPU in the package, restore the interrupt
-	 * MSR and remove the package reference from the array.
+	 * Check whether this cpu was the current target and store the new
+	 * one. When we drop the lock, then the interrupt notify function
+	 * will see the new target.
+	 */
+	was_target = pkgdev->cpu == cpu;
+	pkgdev->cpu = target;
+
+	/*
+	 * If this is the last CPU in the package remove the package
+	 * reference from the list and restore the interrupt MSR. When we
+	 * drop the lock neither the interrupt notify function nor the
+	 * worker will see the package anymore.
 	 */
 	if (lastcpu) {
-		/* Protect against work and interrupts */
-		spin_lock_irq(&pkg_temp_lock);
 		list_del(&pkgdev->list);
 		/*
 		 * After this point nothing touches the MSR anymore. We
@@ -447,17 +462,36 @@ static void put_core_offline(unsigned in
 		wrmsr_on_cpu(cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT,
 			     pkgdev->msr_pkg_therm_low,
 			     pkgdev->msr_pkg_therm_high);
-		kfree(pkgdev);
+		spin_lock_irq(&pkg_temp_lock);
 	}
 
 	/*
-	 * Note, this is broken when work was really scheduled on the
-	 * outgoing cpu because this will leave the work_scheduled flag set
-	 * and the thermal interrupts disabled. Will be fixed in the next
-	 * step as there is no way to fix it in a sane way with the per cpu
-	 * work nonsense.
+	 * Check whether there is work scheduled and whether the work is
+	 * targeted at the outgoing CPU.
 	 */
-	cancel_delayed_work_sync(&per_cpu(pkg_temp_thermal_threshold_work, cpu));
+	if (pkgdev->work_scheduled && was_target) {
+		/*
+		 * To cancel the work we need to drop the lock, otherwise
+		 * we might deadlock if the work needs to be flushed.
+		 */
+		spin_unlock_irq(&pkg_temp_lock);
+		cancel_delayed_work_sync(&pkgdev->work);
+		spin_lock_irq(&pkg_temp_lock);
+		/*
+		 * If this is not the last cpu in the package and the work
+		 * did not run after we dropped the lock above, then we
+		 * need to reschedule the work, otherwise the interrupt
+		 * stays disabled forever.
+		 */
+		if (!lastcpu && pkgdev->work_scheduled)
+			pkg_thermal_schedule_work(target, &pkgdev->work);
+	}
+
+	spin_unlock_irq(&pkg_temp_lock);
+
+	/* Final cleanup if this is the last cpu */
+	if (lastcpu)
+		kfree(pkgdev);
 }
 
 static int get_core_online(unsigned int cpu)
@@ -469,9 +503,6 @@ static int get_core_online(unsigned int
 	if (!cpu_has(c, X86_FEATURE_DTHERM) || !cpu_has(c, X86_FEATURE_PTS))
 		return -ENODEV;
 
-	INIT_DELAYED_WORK(&per_cpu(pkg_temp_thermal_threshold_work, cpu),
-			  pkg_temp_thermal_threshold_work_fn);
-
 	/* If the package exists, nothing to do */
 	if (pkgdev) {
 		cpumask_set_cpu(cpu, &pkgdev->cpumask);
