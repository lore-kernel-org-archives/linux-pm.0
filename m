From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v6 3/4] powercap/rapl: add package reference per domain
Date: Wed, 24 Feb 2016 13:31:37 -0800
Message-ID: <1456349498-1527-4-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1456349498-1527-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456349498-1527-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Rusty Russell <rusty@rustcorp.com.au>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

This patch adds to each rapl domain a reference of the package
it belongs to. At runtime, we can then avoid searching the package
data for each access. It simplifies the domain level operations
which depend on package level information.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/powercap/intel_rapl.c | 66 ++++++++++++++-----------------------------
 1 file changed, 21 insertions(+), 45 deletions(-)

diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
index a50e644..3413692 100644
--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -155,6 +155,7 @@ struct rapl_power_limit {
 static const char pl1_name[] = "long_term";
 static const char pl2_name[] = "short_term";
 
+struct rapl_package;
 struct rapl_domain {
 	const char *name;
 	enum rapl_domain_type id;
@@ -165,7 +166,7 @@ struct rapl_domain {
 	u64 attr_map; /* track capabilities */
 	unsigned int state;
 	unsigned int domain_energy_unit;
-	int package_id;
+	struct rapl_package *rp;
 };
 #define power_zone_to_rapl_domain(_zone) \
 	container_of(_zone, struct rapl_domain, power_zone)
@@ -237,10 +238,10 @@ static int rapl_read_data_raw(struct rapl_domain *rd,
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
 
@@ -318,25 +319,19 @@ static int get_max_energy_counter(struct powercap_zone *pcd_dev, u64 *energy)
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
@@ -438,11 +433,7 @@ static int set_power_limit(struct powercap_zone *power_zone, int id,
 
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
@@ -462,7 +453,7 @@ static int set_power_limit(struct powercap_zone *power_zone, int id,
 		ret = -EINVAL;
 	}
 	if (!ret)
-		package_power_limit_irq_save(rd->package_id);
+		package_power_limit_irq_save(rp);
 set_exit:
 	put_online_cpus();
 	return ret;
@@ -661,24 +652,19 @@ static void rapl_init_domains(struct rapl_package *rp)
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
@@ -776,7 +762,7 @@ static int rapl_read_data_raw(struct rapl_domain *rd,
 	if (!msr)
 		return -EINVAL;
 	/* use physical package id to look up active cpus */
-	cpu = find_active_cpu_on_package(rd->package_id);
+	cpu = find_active_cpu_on_package(rd->rp->id);
 	if (cpu < 0)
 		return cpu;
 
@@ -799,7 +785,7 @@ static int rapl_read_data_raw(struct rapl_domain *rd,
 	final = value & rp->mask;
 	final = final >> rp->shift;
 	if (xlate)
-		*data = rapl_unit_xlate(rd, rd->package_id, rp->unit, final, 0);
+		*data = rapl_unit_xlate(rd, rp->unit, final, 0);
 	else
 		*data = final;
 
@@ -843,11 +829,11 @@ static int rapl_write_data_raw(struct rapl_domain *rd,
 	struct msrl_action ma;
 	int ret;
 
-	cpu = find_active_cpu_on_package(rd->package_id);
+	cpu = find_active_cpu_on_package(rd->rp->id);
 	if (cpu < 0)
 		return cpu;
 
-	bits = rapl_unit_xlate(rd, rd->package_id, rp->unit, value, 1);
+	bits = rapl_unit_xlate(rd, rp->unit, value, 1);
 	bits |= bits << rp->shift;
 	memset(&ma, 0, sizeof(ma));
 
@@ -952,19 +938,14 @@ static void power_limit_irq_save_cpu(void *info)
  * to do by adding an atomic notifier.
  */
 
-static void package_power_limit_irq_save(int package_id)
+static void package_power_limit_irq_save(struct rapl_package *rp)
 {
 	int cpu;
-	struct rapl_package *rp;
-
-	rp = find_package_by_id(package_id);
-	if (!rp)
-		return;
 
 	if (!boot_cpu_has(X86_FEATURE_PTS) || !boot_cpu_has(X86_FEATURE_PLN))
 		return;
 
-	cpu = find_active_cpu_on_package(package_id);
+	cpu = find_active_cpu_on_package(rp->id);
 	if (cpu < 0)
 		return;
 	if (!boot_cpu_has(X86_FEATURE_PTS) || !boot_cpu_has(X86_FEATURE_PLN))
@@ -989,19 +970,14 @@ static void power_limit_irq_restore_cpu(void *info)
 }
 
 /* restore per package power limit interrupt enable state */
-static void package_power_limit_irq_restore(int package_id)
+static void package_power_limit_irq_restore(struct rapl_package *rp)
 {
 	int cpu;
-	struct rapl_package *rp;
-
-	rp = find_package_by_id(package_id);
-	if (!rp)
-		return;
 
 	if (!boot_cpu_has(X86_FEATURE_PTS) || !boot_cpu_has(X86_FEATURE_PLN))
 		return;
 
-	cpu = find_active_cpu_on_package(package_id);
+	cpu = find_active_cpu_on_package(rp->id);
 	if (cpu < 0)
 		return;
 
@@ -1192,7 +1168,7 @@ static int rapl_unregister_powercap(void)
 	 * hotplug lock held
 	 */
 	list_for_each_entry(rp, &rapl_packages, plist) {
-		package_power_limit_irq_restore(rp->id);
+		package_power_limit_irq_restore(rp);
 
 		for (rd = rp->domains; rd < rp->domains + rp->nr_domains;
 		     rd++) {
-- 
1.9.1
