From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v5 2/2] powercap/rapl: reduce ipi calls
Date: Tue, 23 Feb 2016 12:59:12 -0800
Message-ID: <1456261152-21907-3-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1456261152-21907-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456261152-21907-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Rafael Wysocki <rafael.j.wysocki@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "David S. Miller" <davem@davemloft.net>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Rusty Russell <rusty@rustcorp.com.au>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Reduce remote CPU calls for MSR access by combining read
modify write into one function. Also optimize calling active CPU on
package by tracking a lead cpu for each package.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/powercap/intel_rapl.c | 220 ++++++++++++++++++++++--------------------
 1 file changed, 114 insertions(+), 106 deletions(-)

diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
index 6c592dc..cdfd01f0 100644
--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -133,6 +133,12 @@ struct rapl_domain_data {
 	unsigned long timestamp;
 };
 
+struct msrl_action {
+	u32 msr_no;
+	u64 clear_mask;
+	u64 set_mask;
+	int err;
+};
 
 #define	DOMAIN_STATE_INACTIVE           BIT(0)
 #define	DOMAIN_STATE_POWER_LIMIT_SET    BIT(1)
@@ -149,6 +155,7 @@ struct rapl_power_limit {
 static const char pl1_name[] = "long_term";
 static const char pl2_name[] = "short_term";
 
+struct rapl_package;
 struct rapl_domain {
 	const char *name;
 	enum rapl_domain_type id;
@@ -159,7 +166,7 @@ struct rapl_domain {
 	u64 attr_map; /* track capabilities */
 	unsigned int state;
 	unsigned int domain_energy_unit;
-	int package_id;
+	struct rapl_package *rp;
 };
 #define power_zone_to_rapl_domain(_zone) \
 	container_of(_zone, struct rapl_domain, power_zone)
@@ -184,6 +191,7 @@ struct rapl_package {
 					* notify interrupt enable status.
 					*/
 	struct list_head plist;
+	int lead_cpu; /* one active cpu per package for access */
 };
 
 struct rapl_defaults {
@@ -231,10 +239,10 @@ static int rapl_read_data_raw(struct rapl_domain *rd,
 static int rapl_write_data_raw(struct rapl_domain *rd,
 			enum rapl_primitives prim,
 			unsigned long long value);
-static u64 rapl_unit_xlate(struct rapl_domain *rd, int package,
+static u64 rapl_unit_xlate(struct rapl_domain *rd,
 			enum unit_type type, u64 value,
 			int to_raw);
-static void package_power_limit_irq_save(int package_id);
+static void package_power_limit_irq_save(struct rapl_package *rp);
 
 static LIST_HEAD(rapl_packages); /* guarded by CPU hotplug lock */
 
@@ -260,20 +268,6 @@ static struct rapl_package *find_package_by_id(int id)
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
@@ -312,25 +306,19 @@ static int get_max_energy_counter(struct powercap_zone *pcd_dev, u64 *energy)
 {
 	struct rapl_domain *rd = power_zone_to_rapl_domain(pcd_dev);
 
-	*energy = rapl_unit_xlate(rd, 0, ENERGY_UNIT, ENERGY_STATUS_MASK, 0);
+	*energy = rapl_unit_xlate(rd, ENERGY_UNIT, ENERGY_STATUS_MASK, 0);
 	return 0;
 }
 
 static int release_zone(struct powercap_zone *power_zone)
 {
 	struct rapl_domain *rd = power_zone_to_rapl_domain(power_zone);
-	struct rapl_package *rp;
+	struct rapl_package *rp = rd->rp;
 
 	/* package zone is the last zone of a package, we can free
 	 * memory here since all children has been unregistered.
 	 */
 	if (rd->id == RAPL_DOMAIN_PACKAGE) {
-		rp = find_package_by_id(rd->package_id);
-		if (!rp) {
-			dev_warn(&power_zone->dev, "no package id %s\n",
-				rd->name);
-			return -ENODEV;
-		}
 		kfree(rd);
 		rp->domains = NULL;
 	}
@@ -432,11 +420,7 @@ static int set_power_limit(struct powercap_zone *power_zone, int id,
 
 	get_online_cpus();
 	rd = power_zone_to_rapl_domain(power_zone);
-	rp = find_package_by_id(rd->package_id);
-	if (!rp) {
-		ret = -ENODEV;
-		goto set_exit;
-	}
+	rp = rd->rp;
 
 	if (rd->state & DOMAIN_STATE_BIOS_LOCKED) {
 		dev_warn(&power_zone->dev, "%s locked by BIOS, monitoring only\n",
@@ -456,7 +440,7 @@ static int set_power_limit(struct powercap_zone *power_zone, int id,
 		ret = -EINVAL;
 	}
 	if (!ret)
-		package_power_limit_irq_save(rd->package_id);
+		package_power_limit_irq_save(rp);
 set_exit:
 	put_online_cpus();
 	return ret;
@@ -655,24 +639,19 @@ static void rapl_init_domains(struct rapl_package *rp)
 			break;
 		}
 		if (mask) {
-			rd->package_id = rp->id;
+			rd->rp = rp;
 			rd++;
 		}
 	}
 }
 
-static u64 rapl_unit_xlate(struct rapl_domain *rd, int package,
-			enum unit_type type, u64 value,
-			int to_raw)
+static u64 rapl_unit_xlate(struct rapl_domain *rd, enum unit_type type,
+			u64 value, int to_raw)
 {
 	u64 units = 1;
-	struct rapl_package *rp;
+	struct rapl_package *rp = rd->rp;
 	u64 scale = 1;
 
-	rp = find_package_by_id(package);
-	if (!rp)
-		return value;
-
 	switch (type) {
 	case POWER_UNIT:
 		units = rp->power_unit;
@@ -769,10 +748,8 @@ static int rapl_read_data_raw(struct rapl_domain *rd,
 	msr = rd->msrs[rp->id];
 	if (!msr)
 		return -EINVAL;
-	/* use physical package id to look up active cpus */
-	cpu = find_active_cpu_on_package(rd->package_id);
-	if (cpu < 0)
-		return cpu;
+
+	cpu = rd->rp->lead_cpu;
 
 	/* special-case package domain, which uses a different bit*/
 	if (prim == FW_LOCK && rd->id == RAPL_DOMAIN_PACKAGE) {
@@ -793,42 +770,66 @@ static int rapl_read_data_raw(struct rapl_domain *rd,
 	final = value & rp->mask;
 	final = final >> rp->shift;
 	if (xlate)
-		*data = rapl_unit_xlate(rd, rd->package_id, rp->unit, final, 0);
+		*data = rapl_unit_xlate(rd, rp->unit, final, 0);
 	else
 		*data = final;
 
 	return 0;
 }
 
+
+static int msrl_update_safe(u32 msr_no, u64 clear_mask, u64 set_mask)
+{
+	int err;
+	u64 val;
+
+	err = rdmsrl_safe(msr_no, &val);
+	if (err)
+		goto out;
+
+	val &= ~clear_mask;
+	val |= set_mask;
+
+	err = wrmsrl_safe(msr_no, val);
+
+out:
+	return err;
+}
+
+static void msrl_update_func(void *info)
+{
+	struct msrl_action *ma = info;
+
+	ma->err = msrl_update_safe(ma->msr_no, ma->clear_mask, ma->set_mask);
+}
+
 /* Similar use of primitive info in the read counterpart */
 static int rapl_write_data_raw(struct rapl_domain *rd,
 			enum rapl_primitives prim,
 			unsigned long long value)
 {
-	u64 msr_val;
-	u32 msr;
 	struct rapl_primitive_info *rp = &rpi[prim];
 	int cpu;
+	u64 bits;
+	struct msrl_action ma;
+	int ret;
 
-	cpu = find_active_cpu_on_package(rd->package_id);
-	if (cpu < 0)
-		return cpu;
-	msr = rd->msrs[rp->id];
-	if (rdmsrl_safe_on_cpu(cpu, msr, &msr_val)) {
-		dev_dbg(&rd->power_zone.dev,
-			"failed to read msr 0x%x on cpu %d\n", msr, cpu);
-		return -EIO;
-	}
-	value = rapl_unit_xlate(rd, rd->package_id, rp->unit, value, 1);
-	msr_val &= ~rp->mask;
-	msr_val |= value << rp->shift;
-	if (wrmsrl_safe_on_cpu(cpu, msr, msr_val)) {
-		dev_dbg(&rd->power_zone.dev,
-			"failed to write msr 0x%x on cpu %d\n", msr, cpu);
-		return -EIO;
-	}
+	cpu = rd->rp->lead_cpu;
+	bits = rapl_unit_xlate(rd, rp->unit, value, 1);
+	bits |= bits << rp->shift;
+	memset(&ma, 0, sizeof(ma));
 
-	return 0;
+	ma.msr_no = rd->msrs[rp->id];
+	ma.clear_mask = rp->mask;
+	ma.set_mask = bits;
+
+	ret = smp_call_function_single(cpu, msrl_update_func, &ma, 1);
+	if (ret)
+		WARN_ON_ONCE(ret);
+	else
+		ret = ma.err;
+
+	return ret;
 }
 
 /*
@@ -893,6 +894,21 @@ static int rapl_check_unit_atom(struct rapl_package *rp, int cpu)
 	return 0;
 }
 
+static void power_limit_irq_save_cpu(void *info)
+{
+	u32 l, h = 0;
+	struct rapl_package *rp = (struct rapl_package *)info;
+
+	/* save the state of PLN irq mask bit before disabling it */
+	rdmsr_safe(MSR_IA32_PACKAGE_THERM_INTERRUPT, &l, &h);
+	if (!(rp->power_limit_irq & PACKAGE_PLN_INT_SAVED)) {
+		rp->power_limit_irq = l & PACKAGE_THERM_INT_PLN_ENABLE;
+		rp->power_limit_irq |= PACKAGE_PLN_INT_SAVED;
+	}
+	l &= ~PACKAGE_THERM_INT_PLN_ENABLE;
+	wrmsr_safe(MSR_IA32_PACKAGE_THERM_INTERRUPT, l, h);
+}
+
 
 /* REVISIT:
  * When package power limit is set artificially low by RAPL, LVT
@@ -904,61 +920,40 @@ static int rapl_check_unit_atom(struct rapl_package *rp, int cpu)
  * to do by adding an atomic notifier.
  */
 
-static void package_power_limit_irq_save(int package_id)
+static void package_power_limit_irq_save(struct rapl_package *rp)
 {
-	u32 l, h = 0;
-	int cpu;
-	struct rapl_package *rp;
-
-	rp = find_package_by_id(package_id);
-	if (!rp)
-		return;
-
 	if (!boot_cpu_has(X86_FEATURE_PTS) || !boot_cpu_has(X86_FEATURE_PLN))
 		return;
 
-	cpu = find_active_cpu_on_package(package_id);
-	if (cpu < 0)
-		return;
-	/* save the state of PLN irq mask bit before disabling it */
-	rdmsr_safe_on_cpu(cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT, &l, &h);
-	if (!(rp->power_limit_irq & PACKAGE_PLN_INT_SAVED)) {
-		rp->power_limit_irq = l & PACKAGE_THERM_INT_PLN_ENABLE;
-		rp->power_limit_irq |= PACKAGE_PLN_INT_SAVED;
-	}
-	l &= ~PACKAGE_THERM_INT_PLN_ENABLE;
-	wrmsr_on_cpu(cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT, l, h);
+	smp_call_function_single(rp->lead_cpu, power_limit_irq_save_cpu, rp, 1);
 }
 
-/* restore per package power limit interrupt enable state */
-static void package_power_limit_irq_restore(int package_id)
+static void power_limit_irq_restore_cpu(void *info)
 {
-	u32 l, h;
-	int cpu;
-	struct rapl_package *rp;
+	u32 l, h = 0;
+	struct rapl_package *rp = (struct rapl_package *)info;
 
-	rp = find_package_by_id(package_id);
-	if (!rp)
-		return;
+	rdmsr_safe(MSR_IA32_PACKAGE_THERM_INTERRUPT, &l, &h);
 
-	if (!boot_cpu_has(X86_FEATURE_PTS) || !boot_cpu_has(X86_FEATURE_PLN))
-		return;
+	if (rp->power_limit_irq & PACKAGE_THERM_INT_PLN_ENABLE)
+		l |= PACKAGE_THERM_INT_PLN_ENABLE;
+	else
+		l &= ~PACKAGE_THERM_INT_PLN_ENABLE;
+
+	wrmsr_safe(MSR_IA32_PACKAGE_THERM_INTERRUPT, l, h);
+}
 
-	cpu = find_active_cpu_on_package(package_id);
-	if (cpu < 0)
+/* restore per package power limit interrupt enable state */
+static void package_power_limit_irq_restore(struct rapl_package *rp)
+{
+	if (!boot_cpu_has(X86_FEATURE_PTS) || !boot_cpu_has(X86_FEATURE_PLN))
 		return;
 
 	/* irq enable state not saved, nothing to restore */
 	if (!(rp->power_limit_irq & PACKAGE_PLN_INT_SAVED))
 		return;
-	rdmsr_safe_on_cpu(cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT, &l, &h);
-
-	if (rp->power_limit_irq & PACKAGE_THERM_INT_PLN_ENABLE)
-		l |= PACKAGE_THERM_INT_PLN_ENABLE;
-	else
-		l &= ~PACKAGE_THERM_INT_PLN_ENABLE;
 
-	wrmsr_on_cpu(cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT, l, h);
+	smp_call_function_single(rp->lead_cpu, power_limit_irq_restore_cpu, rp, 1);
 }
 
 static void set_floor_freq_default(struct rapl_domain *rd, bool mode)
@@ -1141,7 +1136,7 @@ static int rapl_unregister_powercap(void)
 	 * hotplug lock held
 	 */
 	list_for_each_entry(rp, &rapl_packages, plist) {
-		package_power_limit_irq_restore(rp->id);
+		package_power_limit_irq_restore(rp);
 
 		for (rd = rp->domains; rd < rp->domains + rp->nr_domains;
 		     rd++) {
@@ -1392,7 +1387,8 @@ static int rapl_detect_topology(void)
 			/* add the new package to the list */
 			new_package->id = phy_package_id;
 			new_package->nr_cpus = 1;
-
+			/* use the first active cpu of the package to access */
+			new_package->lead_cpu = i;
 			/* check if the package contains valid domains */
 			if (rapl_detect_domains(new_package, i) ||
 				rapl_defaults->check_unit(new_package, i)) {
@@ -1448,6 +1444,8 @@ static int rapl_add_package(int cpu)
 	/* add the new package to the list */
 	rp->id = phy_package_id;
 	rp->nr_cpus = 1;
+	rp->lead_cpu = cpu;
+
 	/* check if the package contains valid domains */
 	if (rapl_detect_domains(rp, cpu) ||
 		rapl_defaults->check_unit(rp, cpu)) {
@@ -1480,6 +1478,7 @@ static int rapl_cpu_callback(struct notifier_block *nfb,
 	unsigned long cpu = (unsigned long)hcpu;
 	int phy_package_id;
 	struct rapl_package *rp;
+	int lead_cpu;
 
 	phy_package_id = topology_physical_package_id(cpu);
 	switch (action) {
@@ -1500,6 +1499,15 @@ static int rapl_cpu_callback(struct notifier_block *nfb,
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
