From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 09/12] thermal/x86_pkg_temp: Move work scheduled flag into
 package struct
Date: Fri, 18 Nov 2016 00:03:38 -0000
Message-ID: <20161117234810.589392201@linutronix.de>
References: <20161117231435.891545908@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:50374 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752870AbcKRAGT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Nov 2016 19:06:19 -0500
Content-Disposition: inline;
 filename=thermal-x86_pkg_temp--Move-work-scheduled-flag-into-package-struct.patch
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, rt@linutronix.de, Borislav Petkov <bp@alien8.de>

Storage for a boolean information whether work is scheduled for a package
is kept in separate allocated storage, which is resized when the number of
detected packages grows.

With the proper locking in place this is a completely pointless exercise
because we can simply stick it into the per package struct.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/thermal/x86_pkg_temp_thermal.c |   35 ++++-----------------------------
 1 file changed, 5 insertions(+), 30 deletions(-)

--- a/drivers/thermal/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/x86_pkg_temp_thermal.c
@@ -61,6 +61,7 @@ struct pkg_device {
 	struct list_head		list;
 	u16				phys_proc_id;
 	u16				cpu;
+	bool				work_scheduled;
 	u32				tj_max;
 	u32				msr_pkg_therm_low;
 	u32				msr_pkg_therm_high;
@@ -81,11 +82,6 @@ static DEFINE_MUTEX(thermal_zone_mutex);
 /* Interrupt to work function schedule queue */
 static DEFINE_PER_CPU(struct delayed_work, pkg_temp_thermal_threshold_work);
 
-/* To track if the work is already scheduled on a package */
-static u8 *pkg_work_scheduled;
-
-static u16 max_phy_id;
-
 /* Debug counters to show using debugfs */
 static struct dentry *debugfs;
 static unsigned int pkg_interrupt_cnt;
@@ -293,7 +289,7 @@ static inline void disable_pkg_thres_int
 static void pkg_temp_thermal_threshold_work_fn(struct work_struct *work)
 {
 	struct thermal_zone_device *tzone = NULL;
-	int phy_id, cpu = smp_processor_id();
+	int cpu = smp_processor_id();
 	struct pkg_device *pkgdev;
 	u64 msr_val, wr_val;
 
@@ -307,8 +303,7 @@ static void pkg_temp_thermal_threshold_w
 		mutex_unlock(&thermal_zone_mutex);
 		return;
 	}
-
-	pkg_work_scheduled[phy_id] = 0;
+	pkgdev->work_scheduled = false;
 
 	rdmsrl(MSR_IA32_PACKAGE_THERM_STATUS, msr_val);
 	wr_val = msr_val & ~(THERM_LOG_THRESHOLD0 | THERM_LOG_THRESHOLD1);
@@ -333,7 +328,6 @@ static void pkg_temp_thermal_threshold_w
 static int pkg_thermal_notify(u64 msr_val)
 {
 	int cpu = smp_processor_id();
-	int phy_id = topology_physical_package_id(cpu);
 	struct pkg_device *pkgdev;
 	unsigned long flags;
 
@@ -344,8 +338,8 @@ static int pkg_thermal_notify(u64 msr_va
 
 	/* Work is per package, so scheduling it once is enough. */
 	pkgdev = pkg_temp_thermal_get_dev(cpu);
-	if (pkgdev && pkg_work_scheduled && !pkg_work_scheduled[phy_id]) {
-		pkg_work_scheduled[phy_id] = 1;
+	if (pkgdev && !pkgdev->work_scheduled) {
+		pkgdev->work_scheduled = true;
 		schedule_delayed_work_on(cpu,
 				&per_cpu(pkg_temp_thermal_threshold_work, cpu),
 				msecs_to_jiffies(notify_delay_ms));
@@ -360,8 +354,6 @@ static int pkg_temp_thermal_device_add(u
 	u32 tj_max, eax, ebx, ecx, edx;
 	struct pkg_device *pkgdev;
 	int thres_count, err;
-	unsigned long flags;
-	u8 *temp;
 
 	cpuid(6, &eax, &ebx, &ecx, &edx);
 	thres_count = ebx & 0x07;
@@ -381,20 +373,6 @@ static int pkg_temp_thermal_device_add(u
 	if (!pkgdev)
 		return -ENOMEM;
 
-	spin_lock_irqsave(&pkg_temp_lock, flags);
-	if (topology_physical_package_id(cpu) > max_phy_id)
-		max_phy_id = topology_physical_package_id(cpu);
-	temp = krealloc(pkg_work_scheduled,
-			(max_phy_id+1) * sizeof(u8), GFP_ATOMIC);
-	if (!temp) {
-		spin_unlock_irqrestore(&pkg_temp_lock, flags);
-		kfree(pkgdev);
-		return -ENOMEM;
-	}
-	pkg_work_scheduled = temp;
-	pkg_work_scheduled[topology_physical_package_id(cpu)] = 0;
-	spin_unlock_irqrestore(&pkg_temp_lock, flags);
-
 	pkgdev->phys_proc_id = topology_physical_package_id(cpu);
 	pkgdev->cpu = cpu;
 	pkgdev->tj_max = tj_max;
@@ -548,7 +526,6 @@ static int __init pkg_temp_thermal_init(
 	for_each_online_cpu(i)
 		put_core_offline(i);
 	cpu_notifier_register_done();
-	kfree(pkg_work_scheduled);
 	return -ENODEV;
 }
 module_init(pkg_temp_thermal_init)
@@ -566,8 +543,6 @@ static void __exit pkg_temp_thermal_exit
 		put_core_offline(i);
 	cpu_notifier_register_done();
 
-	kfree(pkg_work_scheduled);
-
 	debugfs_remove_recursive(debugfs);
 }
 module_exit(pkg_temp_thermal_exit)


