From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 05/12] thermal/x86_pkg_temp: Get rid of ref counting
Date: Fri, 18 Nov 2016 00:03:28 -0000
Message-ID: <20161117234810.273411135@linutronix.de>
References: <20161117231435.891545908@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline;
 filename=thermal-x86_pkg_temp--Get-rid-of-ref-counting.patch
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, rt@linutronix.de, Borislav Petkov <bp@alien8.de>
List-Id: linux-pm@vger.kernel.org

There is no point in the whole package data refcounting dance because
topology_core_cpumask tells us whether this is the last cpu in the
package. If yes, then the package can go, if not it stays. It's already
serialized via the hotplug code.

While at it rename the first_cpu member of the package structure to
cpu. The first has absolutely no meaning.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/thermal/x86_pkg_temp_thermal.c |   62 ++++++++++-----------------------
 1 file changed, 20 insertions(+), 42 deletions(-)

--- a/drivers/thermal/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/x86_pkg_temp_thermal.c
@@ -60,9 +60,8 @@ MODULE_PARM_DESC(notify_delay_ms,
 struct phy_dev_entry {
 	struct list_head list;
 	u16 phys_proc_id;
-	u16 first_cpu;
+	u16 cpu;
 	u32 tj_max;
-	int ref_cnt;
 	u32 start_pkg_therm_low;
 	u32 start_pkg_therm_high;
 	struct thermal_zone_device *tzone;
@@ -170,8 +169,8 @@ static int sys_get_curr_temp(struct ther
 	struct phy_dev_entry *phy_dev_entry;
 
 	phy_dev_entry = tzd->devdata;
-	rdmsr_on_cpu(phy_dev_entry->first_cpu, MSR_IA32_PACKAGE_THERM_STATUS,
-			&eax, &edx);
+	rdmsr_on_cpu(phy_dev_entry->cpu, MSR_IA32_PACKAGE_THERM_STATUS,
+		     &eax, &edx);
 	if (eax & 0x80000000) {
 		*temp = phy_dev_entry->tj_max -
 				((eax >> 16) & 0x7f) * 1000;
@@ -204,8 +203,8 @@ static int sys_get_trip_temp(struct ther
 		shift = THERM_SHIFT_THRESHOLD0;
 	}
 
-	ret = rdmsr_on_cpu(phy_dev_entry->first_cpu,
-				MSR_IA32_PACKAGE_THERM_INTERRUPT, &eax, &edx);
+	ret = rdmsr_on_cpu(phy_dev_entry->cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT,
+			   &eax, &edx);
 	if (ret < 0)
 		return -EINVAL;
 
@@ -232,9 +231,8 @@ static int sys_set_trip_temp(struct ther
 	if (trip >= MAX_NUMBER_OF_TRIPS || temp >= phy_dev_entry->tj_max)
 		return -EINVAL;
 
-	ret = rdmsr_on_cpu(phy_dev_entry->first_cpu,
-					MSR_IA32_PACKAGE_THERM_INTERRUPT,
-					&l, &h);
+	ret = rdmsr_on_cpu(phy_dev_entry->cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT,
+			   &l, &h);
 	if (ret < 0)
 		return -EINVAL;
 
@@ -259,9 +257,8 @@ static int sys_set_trip_temp(struct ther
 		l |= intr;
 	}
 
-	return wrmsr_on_cpu(phy_dev_entry->first_cpu,
-					MSR_IA32_PACKAGE_THERM_INTERRUPT,
-					l, h);
+	return wrmsr_on_cpu(phy_dev_entry->cpu,	MSR_IA32_PACKAGE_THERM_INTERRUPT,
+			    l, h);
 }
 
 static int sys_get_trip_type(struct thermal_zone_device *thermal,
@@ -431,9 +428,8 @@ static int pkg_temp_thermal_device_add(u
 	spin_unlock_irqrestore(&pkg_work_lock, flags);
 
 	phy_dev_entry->phys_proc_id = topology_physical_package_id(cpu);
-	phy_dev_entry->first_cpu = cpu;
+	phy_dev_entry->cpu = cpu;
 	phy_dev_entry->tj_max = tj_max;
-	phy_dev_entry->ref_cnt = 1;
 	phy_dev_entry->tzone = thermal_zone_device_register("x86_pkg_temp",
 			thres_count,
 			(thres_count == MAX_NUMBER_OF_TRIPS) ?
@@ -468,30 +464,16 @@ static int pkg_temp_thermal_device_add(u
 static int pkg_temp_thermal_device_remove(unsigned int cpu)
 {
 	struct phy_dev_entry *phdev = pkg_temp_thermal_get_phy_entry(cpu);
-	u16 phys_proc_id = topology_physical_package_id(cpu);
+	int target;
 
 	if (!phdev)
 		return -ENODEV;
 
 	mutex_lock(&phy_dev_list_mutex);
-	/* If we are loosing the first cpu for this package, we need change */
-	if (phdev->first_cpu == cpu) {
-		int target = cpumask_any_but(topology_core_cpumask(cpu), cpu);
-
-		phdev->first_cpu = target;
-		pr_debug("CPU %d down. New first_cpu%d\n", cpu, target);
-	}
-	/*
-	* It is possible that no siblings left as this was the last cpu
-	* going offline. We don't need to worry about this assignment
-	* as the phydev entry will be removed in this case and
-	* thermal zone is removed.
-	*/
-	--phdev->ref_cnt;
-	pr_debug("thermal_device_remove: pkg: %d cpu %d ref_cnt %d\n",
-					phys_proc_id, cpu, phdev->ref_cnt);
 
-	if (!phdev->ref_cnt) {
+	target = cpumask_any_but(topology_core_cpumask(cpu), cpu);
+	/* This might be the last cpu in this package */
+	if (target >= nr_cpu_ids) {
 		thermal_zone_device_unregister(phdev->tzone);
 		/*
 		 * Restore original MSR value for package thermal
@@ -502,7 +484,10 @@ static int pkg_temp_thermal_device_remov
 			     phdev->start_pkg_therm_high);
 		list_del(&phdev->list);
 		kfree(phdev);
+	} else if (phdev->cpu == cpu) {
+		phdev->cpu = target;
 	}
+
 	mutex_unlock(&phy_dev_list_mutex);
 
 	return 0;
@@ -520,12 +505,6 @@ static int get_core_online(unsigned int
 			return -ENODEV;
 		if (pkg_temp_thermal_device_add(cpu))
 			return -ENODEV;
-	} else {
-		mutex_lock(&phy_dev_list_mutex);
-		++phdev->ref_cnt;
-		pr_debug("get_core_online: cpu %d ref_cnt %d\n",
-						cpu, phdev->ref_cnt);
-		mutex_unlock(&phy_dev_list_mutex);
 	}
 	INIT_DELAYED_WORK(&per_cpu(pkg_temp_thermal_threshold_work, cpu),
 			pkg_temp_thermal_threshold_work_fn);
@@ -615,10 +594,9 @@ static void __exit pkg_temp_thermal_exit
 	mutex_lock(&phy_dev_list_mutex);
 	list_for_each_entry_safe(phdev, n, &phy_dev_list, list) {
 		/* Retore old MSR value for package thermal interrupt */
-		wrmsr_on_cpu(phdev->first_cpu,
-			MSR_IA32_PACKAGE_THERM_INTERRUPT,
-			phdev->start_pkg_therm_low,
-			phdev->start_pkg_therm_high);
+		wrmsr_on_cpu(phdev->cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT,
+			     phdev->start_pkg_therm_low,
+			     phdev->start_pkg_therm_high);
 		thermal_zone_device_unregister(phdev->tzone);
 		list_del(&phdev->list);
 		kfree(phdev);
