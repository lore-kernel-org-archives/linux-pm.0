From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 06/12] thermal/x86_pkg_temp: Cleanup namespace
Date: Fri, 18 Nov 2016 00:03:30 -0000
Message-ID: <20161117234810.353063512@linutronix.de>
References: <20161117231435.891545908@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline;
 filename=thermal-x86_pkg_temp--Cleanup-namespace.patch
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, rt@linutronix.de, Borislav Petkov <bp@alien8.de>
List-Id: linux-pm@vger.kernel.org

Any randomly chosen struct name is more descriptive than phy_dev_entry. 

Rename the whole thing to struct pkg_device, which describes the content
reasonably well and use the same variable name throughout the code so it
gets readable. Rename the msr struct members as well.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/thermal/x86_pkg_temp_thermal.c |  166 +++++++++++++++------------------
 1 file changed, 76 insertions(+), 90 deletions(-)

--- a/drivers/thermal/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/x86_pkg_temp_thermal.c
@@ -57,14 +57,14 @@ MODULE_PARM_DESC(notify_delay_ms,
 /* Limit number of package temp zones */
 #define MAX_PKG_TEMP_ZONE_IDS	256
 
-struct phy_dev_entry {
-	struct list_head list;
-	u16 phys_proc_id;
-	u16 cpu;
-	u32 tj_max;
-	u32 start_pkg_therm_low;
-	u32 start_pkg_therm_high;
-	struct thermal_zone_device *tzone;
+struct pkg_device {
+	struct list_head		list;
+	u16				phys_proc_id;
+	u16				cpu;
+	u32				tj_max;
+	u32				msr_pkg_therm_low;
+	u32				msr_pkg_therm_high;
+	struct thermal_zone_device	*tzone;
 };
 
 static struct thermal_zone_params pkg_temp_tz_params = {
@@ -115,18 +115,17 @@ static int pkg_temp_debugfs_init(void)
 	return -ENOENT;
 }
 
-static struct phy_dev_entry
-			*pkg_temp_thermal_get_phy_entry(unsigned int cpu)
+static struct pkg_device *pkg_temp_thermal_get_dev(unsigned int cpu)
 {
 	u16 phys_proc_id = topology_physical_package_id(cpu);
-	struct phy_dev_entry *phy_ptr;
+	struct pkg_device *pkgdev;
 
 	mutex_lock(&phy_dev_list_mutex);
 
-	list_for_each_entry(phy_ptr, &phy_dev_list, list)
-		if (phy_ptr->phys_proc_id == phys_proc_id) {
+	list_for_each_entry(pkgdev, &phy_dev_list, list)
+		if (pkgdev->phys_proc_id == phys_proc_id) {
 			mutex_unlock(&phy_dev_list_mutex);
-			return phy_ptr;
+			return pkgdev;
 		}
 
 	mutex_unlock(&phy_dev_list_mutex);
@@ -165,36 +164,29 @@ static int get_tj_max(int cpu, u32 *tj_m
 
 static int sys_get_curr_temp(struct thermal_zone_device *tzd, int *temp)
 {
+	struct pkg_device *pkgdev = tzd->devdata;
 	u32 eax, edx;
-	struct phy_dev_entry *phy_dev_entry;
 
-	phy_dev_entry = tzd->devdata;
-	rdmsr_on_cpu(phy_dev_entry->cpu, MSR_IA32_PACKAGE_THERM_STATUS,
-		     &eax, &edx);
+	rdmsr_on_cpu(pkgdev->cpu, MSR_IA32_PACKAGE_THERM_STATUS, &eax, &edx);
 	if (eax & 0x80000000) {
-		*temp = phy_dev_entry->tj_max -
-				((eax >> 16) & 0x7f) * 1000;
+		*temp = pkgdev->tj_max - ((eax >> 16) & 0x7f) * 1000;
 		pr_debug("sys_get_curr_temp %d\n", *temp);
 		return 0;
 	}
-
 	return -EINVAL;
 }
 
 static int sys_get_trip_temp(struct thermal_zone_device *tzd,
-		int trip, int *temp)
+			     int trip, int *temp)
 {
-	u32 eax, edx;
-	struct phy_dev_entry *phy_dev_entry;
-	u32 mask, shift;
+	struct pkg_device *pkgdev = tzd->devdata;
 	unsigned long thres_reg_value;
+	u32 mask, shift, eax, edx;
 	int ret;
 
 	if (trip >= MAX_NUMBER_OF_TRIPS)
 		return -EINVAL;
 
-	phy_dev_entry = tzd->devdata;
-
 	if (trip) {
 		mask = THERM_MASK_THRESHOLD1;
 		shift = THERM_SHIFT_THRESHOLD1;
@@ -203,14 +195,14 @@ static int sys_get_trip_temp(struct ther
 		shift = THERM_SHIFT_THRESHOLD0;
 	}
 
-	ret = rdmsr_on_cpu(phy_dev_entry->cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT,
+	ret = rdmsr_on_cpu(pkgdev->cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT,
 			   &eax, &edx);
 	if (ret < 0)
 		return -EINVAL;
 
 	thres_reg_value = (eax & mask) >> shift;
 	if (thres_reg_value)
-		*temp = phy_dev_entry->tj_max - thres_reg_value * 1000;
+		*temp = pkgdev->tj_max - thres_reg_value * 1000;
 	else
 		*temp = 0;
 	pr_debug("sys_get_trip_temp %d\n", *temp);
@@ -218,20 +210,17 @@ static int sys_get_trip_temp(struct ther
 	return 0;
 }
 
-static int sys_set_trip_temp(struct thermal_zone_device *tzd, int trip,
-							int temp)
+static int
+sys_set_trip_temp(struct thermal_zone_device *tzd, int trip, int temp)
 {
-	u32 l, h;
-	struct phy_dev_entry *phy_dev_entry;
-	u32 mask, shift, intr;
+	struct pkg_device *pkgdev = tzd->devdata;
+	u32 l, h, mask, shift, intr;
 	int ret;
 
-	phy_dev_entry = tzd->devdata;
-
-	if (trip >= MAX_NUMBER_OF_TRIPS || temp >= phy_dev_entry->tj_max)
+	if (trip >= MAX_NUMBER_OF_TRIPS || temp >= pkgdev->tj_max)
 		return -EINVAL;
 
-	ret = rdmsr_on_cpu(phy_dev_entry->cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT,
+	ret = rdmsr_on_cpu(pkgdev->cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT,
 			   &l, &h);
 	if (ret < 0)
 		return -EINVAL;
@@ -250,19 +239,18 @@ static int sys_set_trip_temp(struct ther
 	* When users space sets a trip temperature == 0, which is indication
 	* that, it is no longer interested in receiving notifications.
 	*/
-	if (!temp)
+	if (!temp) {
 		l &= ~intr;
-	else {
-		l |= (phy_dev_entry->tj_max - temp)/1000 << shift;
+	} else {
+		l |= (pkgdev->tj_max - temp)/1000 << shift;
 		l |= intr;
 	}
 
-	return wrmsr_on_cpu(phy_dev_entry->cpu,	MSR_IA32_PACKAGE_THERM_INTERRUPT,
-			    l, h);
+	return wrmsr_on_cpu(pkgdev->cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT, l, h);
 }
 
-static int sys_get_trip_type(struct thermal_zone_device *thermal,
-		int trip, enum thermal_trip_type *type)
+static int sys_get_trip_type(struct thermal_zone_device *thermal, int trip,
+			     enum thermal_trip_type *type)
 {
 
 	*type = THERMAL_TRIP_PASSIVE;
@@ -315,11 +303,11 @@ static void pkg_temp_thermal_threshold_w
 	__u64 msr_val;
 	int cpu = smp_processor_id();
 	int phy_id = topology_physical_package_id(cpu);
-	struct phy_dev_entry *phdev = pkg_temp_thermal_get_phy_entry(cpu);
+	struct pkg_device *pkgdev = pkg_temp_thermal_get_dev(cpu);
 	bool notify = false;
 	unsigned long flags;
 
-	if (!phdev)
+	if (!pkgdev)
 		return;
 
 	spin_lock_irqsave(&pkg_work_lock, flags);
@@ -347,7 +335,7 @@ static void pkg_temp_thermal_threshold_w
 
 	if (notify) {
 		pr_debug("thermal_zone_device_update\n");
-		thermal_zone_device_update(phdev->tzone,
+		thermal_zone_device_update(pkgdev->tzone,
 					   THERMAL_EVENT_UNSPECIFIED);
 	}
 }
@@ -383,13 +371,11 @@ static int pkg_thermal_notify(__u64 msr_
 
 static int pkg_temp_thermal_device_add(unsigned int cpu)
 {
-	int err;
-	u32 tj_max;
-	struct phy_dev_entry *phy_dev_entry;
-	int thres_count;
-	u32 eax, ebx, ecx, edx;
-	u8 *temp;
+	u32 tj_max, eax, ebx, ecx, edx;
+	struct pkg_device *pkgdev;
+	int thres_count, err;
 	unsigned long flags;
+	u8 *temp;
 
 	cpuid(6, &eax, &ebx, &ecx, &edx);
 	thres_count = ebx & 0x07;
@@ -407,8 +393,8 @@ static int pkg_temp_thermal_device_add(u
 
 	mutex_lock(&phy_dev_list_mutex);
 
-	phy_dev_entry = kzalloc(sizeof(*phy_dev_entry), GFP_KERNEL);
-	if (!phy_dev_entry) {
+	pkgdev = kzalloc(sizeof(*pkgdev), GFP_KERNEL);
+	if (!pkgdev) {
 		err = -ENOMEM;
 		goto err_ret_unlock;
 	}
@@ -427,33 +413,32 @@ static int pkg_temp_thermal_device_add(u
 	pkg_work_scheduled[topology_physical_package_id(cpu)] = 0;
 	spin_unlock_irqrestore(&pkg_work_lock, flags);
 
-	phy_dev_entry->phys_proc_id = topology_physical_package_id(cpu);
-	phy_dev_entry->cpu = cpu;
-	phy_dev_entry->tj_max = tj_max;
-	phy_dev_entry->tzone = thermal_zone_device_register("x86_pkg_temp",
+	pkgdev->phys_proc_id = topology_physical_package_id(cpu);
+	pkgdev->cpu = cpu;
+	pkgdev->tj_max = tj_max;
+	pkgdev->tzone = thermal_zone_device_register("x86_pkg_temp",
 			thres_count,
-			(thres_count == MAX_NUMBER_OF_TRIPS) ?
-				0x03 : 0x01,
-			phy_dev_entry, &tzone_ops, &pkg_temp_tz_params, 0, 0);
-	if (IS_ERR(phy_dev_entry->tzone)) {
-		err = PTR_ERR(phy_dev_entry->tzone);
+			(thres_count == MAX_NUMBER_OF_TRIPS) ? 0x03 : 0x01,
+			pkgdev, &tzone_ops, &pkg_temp_tz_params, 0, 0);
+	if (IS_ERR(pkgdev->tzone)) {
+		err = PTR_ERR(pkgdev->tzone);
 		goto err_ret_free;
 	}
 	/* Store MSR value for package thermal interrupt, to restore at exit */
 	rdmsr_on_cpu(cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT,
-				&phy_dev_entry->start_pkg_therm_low,
-				&phy_dev_entry->start_pkg_therm_high);
+		     &pkgdev->msr_pkg_therm_low,
+		     &pkgdev->msr_pkg_therm_high);
 
-	list_add_tail(&phy_dev_entry->list, &phy_dev_list);
+	list_add_tail(&pkgdev->list, &phy_dev_list);
 	pr_debug("pkg_temp_thermal_device_add :phy_id %d cpu %d\n",
-			phy_dev_entry->phys_proc_id, cpu);
+		 pkgdev->phys_proc_id, cpu);
 
 	mutex_unlock(&phy_dev_list_mutex);
 
 	return 0;
 
 err_ret_free:
-	kfree(phy_dev_entry);
+	kfree(pkgdev);
 err_ret_unlock:
 	mutex_unlock(&phy_dev_list_mutex);
 
@@ -463,10 +448,10 @@ static int pkg_temp_thermal_device_add(u
 
 static int pkg_temp_thermal_device_remove(unsigned int cpu)
 {
-	struct phy_dev_entry *phdev = pkg_temp_thermal_get_phy_entry(cpu);
+	struct pkg_device *pkgdev = pkg_temp_thermal_get_dev(cpu);
 	int target;
 
-	if (!phdev)
+	if (!pkgdev)
 		return -ENODEV;
 
 	mutex_lock(&phy_dev_list_mutex);
@@ -474,18 +459,18 @@ static int pkg_temp_thermal_device_remov
 	target = cpumask_any_but(topology_core_cpumask(cpu), cpu);
 	/* This might be the last cpu in this package */
 	if (target >= nr_cpu_ids) {
-		thermal_zone_device_unregister(phdev->tzone);
+		thermal_zone_device_unregister(pkgdev->tzone);
 		/*
 		 * Restore original MSR value for package thermal
 		 * interrupt.
 		 */
 		wrmsr_on_cpu(cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT,
-			     phdev->start_pkg_therm_low,
-			     phdev->start_pkg_therm_high);
-		list_del(&phdev->list);
-		kfree(phdev);
-	} else if (phdev->cpu == cpu) {
-		phdev->cpu = target;
+			     pkgdev->msr_pkg_therm_low,
+			     pkgdev->msr_pkg_therm_high);
+		list_del(&pkgdev->list);
+		kfree(pkgdev);
+	} else if (pkgdev->cpu == cpu) {
+		pkgdev->cpu = target;
 	}
 
 	mutex_unlock(&phy_dev_list_mutex);
@@ -495,19 +480,20 @@ static int pkg_temp_thermal_device_remov
 
 static int get_core_online(unsigned int cpu)
 {
+	struct pkg_device *pkgdev = pkg_temp_thermal_get_dev(cpu);
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
-	struct phy_dev_entry *phdev = pkg_temp_thermal_get_phy_entry(cpu);
 
 	/* Check if there is already an instance for this package */
-	if (!phdev) {
+	if (!pkgdev) {
 		if (!cpu_has(c, X86_FEATURE_DTHERM) ||
 					!cpu_has(c, X86_FEATURE_PTS))
 			return -ENODEV;
 		if (pkg_temp_thermal_device_add(cpu))
 			return -ENODEV;
 	}
+
 	INIT_DELAYED_WORK(&per_cpu(pkg_temp_thermal_threshold_work, cpu),
-			pkg_temp_thermal_threshold_work_fn);
+			  pkg_temp_thermal_threshold_work_fn);
 
 	pr_debug("get_core_online: cpu %d successful\n", cpu);
 
@@ -583,7 +569,7 @@ static int __init pkg_temp_thermal_init(
 
 static void __exit pkg_temp_thermal_exit(void)
 {
-	struct phy_dev_entry *phdev, *n;
+	struct pkg_device *pkgdev, *n;
 	int i;
 
 	platform_thermal_package_notify = NULL;
@@ -592,14 +578,14 @@ static void __exit pkg_temp_thermal_exit
 	cpu_notifier_register_begin();
 	__unregister_hotcpu_notifier(&pkg_temp_thermal_notifier);
 	mutex_lock(&phy_dev_list_mutex);
-	list_for_each_entry_safe(phdev, n, &phy_dev_list, list) {
+	list_for_each_entry_safe(pkgdev, n, &phy_dev_list, list) {
 		/* Retore old MSR value for package thermal interrupt */
-		wrmsr_on_cpu(phdev->cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT,
-			     phdev->start_pkg_therm_low,
-			     phdev->start_pkg_therm_high);
-		thermal_zone_device_unregister(phdev->tzone);
-		list_del(&phdev->list);
-		kfree(phdev);
+		wrmsr_on_cpu(pkgdev->cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT,
+			     pkgdev->msr_pkg_therm_low,
+			     pkgdev->msr_pkg_therm_high);
+		thermal_zone_device_unregister(pkgdev->tzone);
+		list_del(&pkgdev->list);
+		kfree(pkgdev);
 	}
 	mutex_unlock(&phy_dev_list_mutex);
 	for_each_online_cpu(i)
