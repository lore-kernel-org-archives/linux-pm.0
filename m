From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch V2 07/12] thermal/x86_pkg_temp: Cleanup code some more
Date: Tue, 22 Nov 2016 17:57:09 -0000
Message-ID: <20161122175357.445177224@linutronix.de>
References: <20161122175256.922158782@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline;
 filename=thermalx86_pkg_temp_Cleanup_code_some_more.patch
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Rui Zhang <rui.zhang@intel.com>, edubezval@gmail.com, Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, linux-pm@vger.kernel.org, x86@kernel.org, rt@linutronix.de, Srinivas Pandruvada <srinivas.pandruvada@intel.com>
List-Id: linux-pm@vger.kernel.org

Coding style fixups and replacement of overly complex constructs and random
error codes instead of returning the real ones. This mess makes the eyes bleeding.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 drivers/thermal/x86_pkg_temp_thermal.c |   81 ++++++++++++---------------------
 1 file changed, 30 insertions(+), 51 deletions(-)

--- a/drivers/thermal/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/x86_pkg_temp_thermal.c
@@ -139,27 +139,17 @@ static struct pkg_device *pkg_temp_therm
 */
 static int get_tj_max(int cpu, u32 *tj_max)
 {
-	u32 eax, edx;
-	u32 val;
+	u32 eax, edx, val;
 	int err;
 
 	err = rdmsr_safe_on_cpu(cpu, MSR_IA32_TEMPERATURE_TARGET, &eax, &edx);
 	if (err)
-		goto err_ret;
-	else {
-		val = (eax >> 16) & 0xff;
-		if (val)
-			*tj_max = val * 1000;
-		else {
-			err = -EINVAL;
-			goto err_ret;
-		}
-	}
+		return err;
 
-	return 0;
-err_ret:
-	*tj_max = 0;
-	return err;
+	val = (eax >> 16) & 0xff;
+	*tj_max = val * 1000;
+
+	return val ? 0 : -EINVAL;
 }
 
 static int sys_get_curr_temp(struct thermal_zone_device *tzd, int *temp)
@@ -198,7 +188,7 @@ static int sys_get_trip_temp(struct ther
 	ret = rdmsr_on_cpu(pkgdev->cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT,
 			   &eax, &edx);
 	if (ret < 0)
-		return -EINVAL;
+		return ret;
 
 	thres_reg_value = (eax & mask) >> shift;
 	if (thres_reg_value)
@@ -223,7 +213,7 @@ sys_set_trip_temp(struct thermal_zone_de
 	ret = rdmsr_on_cpu(pkgdev->cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT,
 			   &l, &h);
 	if (ret < 0)
-		return -EINVAL;
+		return ret;
 
 	if (trip) {
 		mask = THERM_MASK_THRESHOLD1;
@@ -252,9 +242,7 @@ sys_set_trip_temp(struct thermal_zone_de
 static int sys_get_trip_type(struct thermal_zone_device *thermal, int trip,
 			     enum thermal_trip_type *type)
 {
-
 	*type = THERMAL_TRIP_PASSIVE;
-
 	return 0;
 }
 
@@ -274,8 +262,8 @@ static bool pkg_thermal_rate_control(voi
 /* Enable threshold interrupt on local package/cpu */
 static inline void enable_pkg_thres_interrupt(void)
 {
-	u32 l, h;
 	u8 thres_0, thres_1;
+	u32 l, h;
 
 	rdmsr(MSR_IA32_PACKAGE_THERM_INTERRUPT, l, h);
 	/* only enable/disable if it had valid threshold value */
@@ -292,20 +280,21 @@ static inline void enable_pkg_thres_inte
 static inline void disable_pkg_thres_interrupt(void)
 {
 	u32 l, h;
+
 	rdmsr(MSR_IA32_PACKAGE_THERM_INTERRUPT, l, h);
-	wrmsr(MSR_IA32_PACKAGE_THERM_INTERRUPT,
-			l & (~THERM_INT_THRESHOLD0_ENABLE) &
-				(~THERM_INT_THRESHOLD1_ENABLE), h);
+
+	l &= ~(THERM_INT_THRESHOLD0_ENABLE | THERM_INT_THRESHOLD1_ENABLE);
+	wrmsr(MSR_IA32_PACKAGE_THERM_INTERRUPT, l, h);
 }
 
 static void pkg_temp_thermal_threshold_work_fn(struct work_struct *work)
 {
-	__u64 msr_val;
 	int cpu = smp_processor_id();
-	int phy_id = topology_physical_package_id(cpu);
 	struct pkg_device *pkgdev = pkg_temp_thermal_get_dev(cpu);
+	int phy_id = topology_physical_package_id(cpu);
 	bool notify = false;
 	unsigned long flags;
+	u64 msr_val, wr_val;
 
 	if (!pkgdev)
 		return;
@@ -320,14 +309,9 @@ static void pkg_temp_thermal_threshold_w
 	spin_unlock_irqrestore(&pkg_work_lock, flags);
 
 	rdmsrl(MSR_IA32_PACKAGE_THERM_STATUS, msr_val);
-	if (msr_val & THERM_LOG_THRESHOLD0) {
-		wrmsrl(MSR_IA32_PACKAGE_THERM_STATUS,
-				msr_val & ~THERM_LOG_THRESHOLD0);
-		notify = true;
-	}
-	if (msr_val & THERM_LOG_THRESHOLD1) {
-		wrmsrl(MSR_IA32_PACKAGE_THERM_STATUS,
-				msr_val & ~THERM_LOG_THRESHOLD1);
+	wr_val = msr_val & ~(THERM_LOG_THRESHOLD0 | THERM_LOG_THRESHOLD1);
+	if (wr_val != msr_val) {
+		wrmsrl(MSR_IA32_PACKAGE_THERM_STATUS, wr_val);
 		notify = true;
 	}
 
@@ -340,11 +324,11 @@ static void pkg_temp_thermal_threshold_w
 	}
 }
 
-static int pkg_thermal_notify(__u64 msr_val)
+static int pkg_thermal_notify(u64 msr_val)
 {
-	unsigned long flags;
 	int cpu = smp_processor_id();
 	int phy_id = topology_physical_package_id(cpu);
+	unsigned long flags;
 
 	/*
 	* When a package is in interrupted state, all CPU's in that package
@@ -483,21 +467,17 @@ static int get_core_online(unsigned int
 	struct pkg_device *pkgdev = pkg_temp_thermal_get_dev(cpu);
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
 
-	/* Check if there is already an instance for this package */
-	if (!pkgdev) {
-		if (!cpu_has(c, X86_FEATURE_DTHERM) ||
-					!cpu_has(c, X86_FEATURE_PTS))
-			return -ENODEV;
-		if (pkg_temp_thermal_device_add(cpu))
-			return -ENODEV;
-	}
+	/* Paranoia check */
+	if (!cpu_has(c, X86_FEATURE_DTHERM) || !cpu_has(c, X86_FEATURE_PTS))
+		return -ENODEV;
 
 	INIT_DELAYED_WORK(&per_cpu(pkg_temp_thermal_threshold_work, cpu),
 			  pkg_temp_thermal_threshold_work_fn);
 
-	pr_debug("get_core_online: cpu %d successful\n", cpu);
-
-	return 0;
+	/* If the package exists, nothing to do */
+	if (pkgdev)
+		return 0;
+	return pkg_temp_thermal_device_add(cpu);
 }
 
 static void put_core_offline(unsigned int cpu)
@@ -555,8 +535,8 @@ static int __init pkg_temp_thermal_init(
 	platform_thermal_package_notify = pkg_thermal_notify;
 	platform_thermal_package_rate_control = pkg_thermal_rate_control;
 
-	pkg_temp_debugfs_init(); /* Don't care if fails */
-
+	 /* Don't care if it fails */
+	pkg_temp_debugfs_init();
 	return 0;
 
 err_ret:
@@ -566,6 +546,7 @@ static int __init pkg_temp_thermal_init(
 	kfree(pkg_work_scheduled);
 	return -ENODEV;
 }
+module_init(pkg_temp_thermal_init)
 
 static void __exit pkg_temp_thermal_exit(void)
 {
@@ -597,8 +578,6 @@ static void __exit pkg_temp_thermal_exit
 
 	debugfs_remove_recursive(debugfs);
 }
-
-module_init(pkg_temp_thermal_init)
 module_exit(pkg_temp_thermal_exit)
 
 MODULE_DESCRIPTION("X86 PKG TEMP Thermal Driver");
