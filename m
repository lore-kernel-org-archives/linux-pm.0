From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v6 4/4] powercap/rapl: track lead cpu per package
Date: Wed, 24 Feb 2016 13:31:38 -0800
Message-ID: <1456349498-1527-5-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1456349498-1527-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456349498-1527-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Rusty Russell <rusty@rustcorp.com.au>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

RAPL driver operates on MSRs that are under package/socket
scope instead of core scope. However, the current code does not
keep track of which CPUs are available on each package for MSR
access. Therefore it has to search for an active CPU on a given
package each time.

This patch optimizes the package level operations by tracking a
per package lead CPU during initialization and CPU hotplug. The
runtime search for active CPU is avoided.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/powercap/intel_rapl.c | 59 +++++++++++++++----------------------------
 1 file changed, 20 insertions(+), 39 deletions(-)

diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
index 3413692..cdfd01f0 100644
--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -191,6 +191,7 @@ struct rapl_package {
 					* notify interrupt enable status.
 					*/
 	struct list_head plist;
+	int lead_cpu; /* one active cpu per package for access */
 };
 
 struct rapl_defaults {
@@ -267,20 +268,6 @@ static struct rapl_package *find_package_by_id(int id)
 	return NULL;
 }
 
-/* caller to ensure CPU hotplug lock is held */
-static int find_active_cpu_on_package(int package_id)
-{
-	int i;
-
-	for_each_online_cpu(i) {
-		if (topology_physical_package_id(i) == package_id)
-			return i;
-	}
-	/* all CPUs on this package are offline */
-
-	return -ENODEV;
-}
-
 /* caller must hold cpu hotplug lock */
 static void rapl_cleanup_data(void)
 {
@@ -761,10 +748,8 @@ static int rapl_read_data_raw(struct rapl_domain *rd,
 	msr = rd->msrs[rp->id];
 	if (!msr)
 		return -EINVAL;
-	/* use physical package id to look up active cpus */
-	cpu = find_active_cpu_on_package(rd->rp->id);
-	if (cpu < 0)
-		return cpu;
+
+	cpu = rd->rp->lead_cpu;
 
 	/* special-case package domain, which uses a different bit*/
 	if (prim == FW_LOCK && rd->id == RAPL_DOMAIN_PACKAGE) {
@@ -829,10 +814,7 @@ static int rapl_write_data_raw(struct rapl_domain *rd,
 	struct msrl_action ma;
 	int ret;
 
-	cpu = find_active_cpu_on_package(rd->rp->id);
-	if (cpu < 0)
-		return cpu;
-
+	cpu = rd->rp->lead_cpu;
 	bits = rapl_unit_xlate(rd, rp->unit, value, 1);
 	bits |= bits << rp->shift;
 	memset(&ma, 0, sizeof(ma));
@@ -940,18 +922,10 @@ static void power_limit_irq_save_cpu(void *info)
 
 static void package_power_limit_irq_save(struct rapl_package *rp)
 {
-	int cpu;
-
-	if (!boot_cpu_has(X86_FEATURE_PTS) || !boot_cpu_has(X86_FEATURE_PLN))
-		return;
-
-	cpu = find_active_cpu_on_package(rp->id);
-	if (cpu < 0)
-		return;
 	if (!boot_cpu_has(X86_FEATURE_PTS) || !boot_cpu_has(X86_FEATURE_PLN))
 		return;
 
-	smp_call_function_single(cpu, power_limit_irq_save_cpu, rp, 1);
+	smp_call_function_single(rp->lead_cpu, power_limit_irq_save_cpu, rp, 1);
 }
 
 static void power_limit_irq_restore_cpu(void *info)
@@ -972,20 +946,14 @@ static void power_limit_irq_restore_cpu(void *info)
 /* restore per package power limit interrupt enable state */
 static void package_power_limit_irq_restore(struct rapl_package *rp)
 {
-	int cpu;
-
 	if (!boot_cpu_has(X86_FEATURE_PTS) || !boot_cpu_has(X86_FEATURE_PLN))
 		return;
 
-	cpu = find_active_cpu_on_package(rp->id);
-	if (cpu < 0)
-		return;
-
 	/* irq enable state not saved, nothing to restore */
 	if (!(rp->power_limit_irq & PACKAGE_PLN_INT_SAVED))
 		return;
 
-	smp_call_function_single(cpu, power_limit_irq_restore_cpu, rp, 1);
+	smp_call_function_single(rp->lead_cpu, power_limit_irq_restore_cpu, rp, 1);
 }
 
 static void set_floor_freq_default(struct rapl_domain *rd, bool mode)
@@ -1419,7 +1387,8 @@ static int rapl_detect_topology(void)
 			/* add the new package to the list */
 			new_package->id = phy_package_id;
 			new_package->nr_cpus = 1;
-
+			/* use the first active cpu of the package to access */
+			new_package->lead_cpu = i;
 			/* check if the package contains valid domains */
 			if (rapl_detect_domains(new_package, i) ||
 				rapl_defaults->check_unit(new_package, i)) {
@@ -1475,6 +1444,8 @@ static int rapl_add_package(int cpu)
 	/* add the new package to the list */
 	rp->id = phy_package_id;
 	rp->nr_cpus = 1;
+	rp->lead_cpu = cpu;
+
 	/* check if the package contains valid domains */
 	if (rapl_detect_domains(rp, cpu) ||
 		rapl_defaults->check_unit(rp, cpu)) {
@@ -1507,6 +1478,7 @@ static int rapl_cpu_callback(struct notifier_block *nfb,
 	unsigned long cpu = (unsigned long)hcpu;
 	int phy_package_id;
 	struct rapl_package *rp;
+	int lead_cpu;
 
 	phy_package_id = topology_physical_package_id(cpu);
 	switch (action) {
@@ -1527,6 +1499,15 @@ static int rapl_cpu_callback(struct notifier_block *nfb,
 			break;
 		if (--rp->nr_cpus == 0)
 			rapl_remove_package(rp);
+		else if (cpu == rp->lead_cpu) {
+			/* choose another active cpu in the package */
+			lead_cpu = cpumask_any_but(topology_core_cpumask(cpu), cpu);
+			if (lead_cpu < nr_cpu_ids)
+				rp->lead_cpu = lead_cpu;
+			else /* should never go here */
+				pr_err("no active cpu available for package %d\n",
+					phy_package_id);
+		}
 	}
 
 	return NOTIFY_OK;
-- 
1.9.1
