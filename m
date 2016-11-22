From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch V2 11/12] thermal/x86_pkg_temp: Sanitize package management
Date: Tue, 22 Nov 2016 17:57:14 -0000
Message-ID: <20161122175357.792878877@linutronix.de>
References: <20161122175256.922158782@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline;
 filename=thermalx86_pkg_temp_Sanitize_package_management.patch
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Rui Zhang <rui.zhang@intel.com>, edubezval@gmail.com, Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, linux-pm@vger.kernel.org, x86@kernel.org, rt@linutronix.de, Srinivas Pandruvada <srinivas.pandruvada@intel.com>
List-Id: linux-pm@vger.kernel.org

Packages are kept in a list, which must be searched over and over.

We can be smarter than that and just store the package pointers in an array
which is allocated at init time. Sizing of the array is determined from the
topology information. That makes the package search a simple array lookup.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 drivers/thermal/x86_pkg_temp_thermal.c |   42 +++++++++++++++++----------------
 1 file changed, 22 insertions(+), 20 deletions(-)

--- a/drivers/thermal/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/x86_pkg_temp_thermal.c
@@ -54,13 +54,9 @@ MODULE_PARM_DESC(notify_delay_ms,
 * is some wrong values returned by cpuid for number of thresholds.
 */
 #define MAX_NUMBER_OF_TRIPS	2
-/* Limit number of package temp zones */
-#define MAX_PKG_TEMP_ZONE_IDS	256
 
 struct pkg_device {
-	struct list_head		list;
-	u16				phys_proc_id;
-	u16				cpu;
+	int				cpu;
 	bool				work_scheduled;
 	u32				tj_max;
 	u32				msr_pkg_therm_low;
@@ -74,8 +70,10 @@ static struct thermal_zone_params pkg_te
 	.no_hwmon	= true,
 };
 
-/* List maintaining number of package instances */
-static LIST_HEAD(phy_dev_list);
+/* Keep track of how many package pointers we allocated in init() */
+static int max_packages __read_mostly;
+/* Array of package pointers */
+static struct pkg_device **packages;
 /* Serializes interrupt notification, work and hotplug */
 static DEFINE_SPINLOCK(pkg_temp_lock);
 /* Protects zone operation in the work function against hotplug removal */
@@ -121,13 +119,10 @@ static int pkg_temp_debugfs_init(void)
  */
 static struct pkg_device *pkg_temp_thermal_get_dev(unsigned int cpu)
 {
-	u16 phys_proc_id = topology_physical_package_id(cpu);
-	struct pkg_device *pkgdev;
+	int pkgid = topology_logical_package_id(cpu);
 
-	list_for_each_entry(pkgdev, &phy_dev_list, list) {
-		if (pkgdev->phys_proc_id == phys_proc_id)
-			return pkgdev;
-	}
+	if (pkgid >= 0 && pkgid < max_packages)
+		return packages[pkgid];
 	return NULL;
 }
 
@@ -355,18 +350,19 @@ static int pkg_thermal_notify(u64 msr_va
 
 static int pkg_temp_thermal_device_add(unsigned int cpu)
 {
+	int pkgid = topology_logical_package_id(cpu);
 	u32 tj_max, eax, ebx, ecx, edx;
 	struct pkg_device *pkgdev;
 	int thres_count, err;
 
+	if (pkgid >= max_packages)
+		return -ENOMEM;
+
 	cpuid(6, &eax, &ebx, &ecx, &edx);
 	thres_count = ebx & 0x07;
 	if (!thres_count)
 		return -ENODEV;
 
-	if (topology_physical_package_id(cpu) > MAX_PKG_TEMP_ZONE_IDS)
-		return -ENODEV;
-
 	thres_count = clamp_val(thres_count, 0, MAX_NUMBER_OF_TRIPS);
 
 	err = get_tj_max(cpu, &tj_max);
@@ -378,7 +374,6 @@ static int pkg_temp_thermal_device_add(u
 		return -ENOMEM;
 
 	INIT_DELAYED_WORK(&pkgdev->work, pkg_temp_thermal_threshold_work_fn);
-	pkgdev->phys_proc_id = topology_physical_package_id(cpu);
 	pkgdev->cpu = cpu;
 	pkgdev->tj_max = tj_max;
 	pkgdev->tzone = thermal_zone_device_register("x86_pkg_temp",
@@ -397,7 +392,7 @@ static int pkg_temp_thermal_device_add(u
 
 	cpumask_set_cpu(cpu, &pkgdev->cpumask);
 	spin_lock_irq(&pkg_temp_lock);
-	list_add_tail(&pkgdev->list, &phy_dev_list);
+	packages[pkgid] = pkgdev;
 	spin_unlock_irq(&pkg_temp_lock);
 	return 0;
 }
@@ -447,12 +442,12 @@ static void put_core_offline(unsigned in
 
 	/*
 	 * If this is the last CPU in the package remove the package
-	 * reference from the list and restore the interrupt MSR. When we
+	 * reference from the array and restore the interrupt MSR. When we
 	 * drop the lock neither the interrupt notify function nor the
 	 * worker will see the package anymore.
 	 */
 	if (lastcpu) {
-		list_del(&pkgdev->list);
+		packages[topology_logical_package_id(cpu)] = NULL;
 		/*
 		 * After this point nothing touches the MSR anymore. We
 		 * must drop the lock to make the cross cpu call. This goes
@@ -545,6 +540,11 @@ static int __init pkg_temp_thermal_init(
 	if (!x86_match_cpu(pkg_temp_thermal_ids))
 		return -ENODEV;
 
+	max_packages = topology_max_packages();
+	packages = kzalloc(max_packages * sizeof(struct pkg_device *), GFP_KERNEL);
+	if (!packages)
+		return -ENOMEM;
+
 	cpu_notifier_register_begin();
 	for_each_online_cpu(i)
 		if (get_core_online(i))
@@ -563,6 +563,7 @@ static int __init pkg_temp_thermal_init(
 	for_each_online_cpu(i)
 		put_core_offline(i);
 	cpu_notifier_register_done();
+	kfree(packages);
 	return -ENODEV;
 }
 module_init(pkg_temp_thermal_init)
@@ -581,6 +582,7 @@ static void __exit pkg_temp_thermal_exit
 	cpu_notifier_register_done();
 
 	debugfs_remove_recursive(debugfs);
+	kfree(packages);
 }
 module_exit(pkg_temp_thermal_exit)
 
