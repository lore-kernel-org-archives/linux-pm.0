From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 4/5] powercap/intel_rapl: Cleanup duplicated init code
Date: Tue, 22 Nov 2016 21:16:02 -0000
Message-ID: <20161122211438.672994024@linutronix.de>
References: <20161122210518.079483154@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline;
 filename=powercapintel_rapl_Cleanup_duplicated_init_code.patch
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Rafael Wysocki <rjw@sisk.pl>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

The whole init/exit code is a duplicate of the cpuhotplug code. So we can
just let the hotplug code do the actual work of setting up and tearing down
the domains.

This also restores the package hardware when a package is removed during
hotplug instead of leaving it in the last configured state and only reset
it when the driver is removed.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 drivers/powercap/intel_rapl.c |  234 ++++++++----------------------------------
 1 file changed, 46 insertions(+), 188 deletions(-)

--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -275,18 +275,6 @@ static struct rapl_package *find_package
 	return NULL;
 }
 
-/* caller must hold cpu hotplug lock */
-static void rapl_cleanup_data(void)
-{
-	struct rapl_package *p, *tmp;
-
-	list_for_each_entry_safe(p, tmp, &rapl_packages, plist) {
-		kfree(p->domains);
-		list_del(&p->plist);
-		kfree(p);
-	}
-}
-
 static int get_energy_counter(struct powercap_zone *power_zone, u64 *energy_raw)
 {
 	struct rapl_domain *rd;
@@ -976,10 +964,20 @@ static void package_power_limit_irq_save
 	smp_call_function_single(rp->lead_cpu, power_limit_irq_save_cpu, rp, 1);
 }
 
-static void power_limit_irq_restore_cpu(void *info)
+/*
+ * Restore per package power limit interrupt enable state. Called from cpu
+ * hotplug code on package removal.
+ */
+static void package_power_limit_irq_restore(struct rapl_package *rp)
 {
-	u32 l, h = 0;
-	struct rapl_package *rp = (struct rapl_package *)info;
+	u32 l, h;
+
+	if (!boot_cpu_has(X86_FEATURE_PTS) || !boot_cpu_has(X86_FEATURE_PLN))
+		return;
+
+	/* irq enable state not saved, nothing to restore */
+	if (!(rp->power_limit_irq & PACKAGE_PLN_INT_SAVED))
+		return;
 
 	rdmsr_safe(MSR_IA32_PACKAGE_THERM_INTERRUPT, &l, &h);
 
@@ -991,19 +989,6 @@ static void power_limit_irq_restore_cpu(
 	wrmsr_safe(MSR_IA32_PACKAGE_THERM_INTERRUPT, l, h);
 }
 
-/* restore per package power limit interrupt enable state */
-static void package_power_limit_irq_restore(struct rapl_package *rp)
-{
-	if (!boot_cpu_has(X86_FEATURE_PTS) || !boot_cpu_has(X86_FEATURE_PLN))
-		return;
-
-	/* irq enable state not saved, nothing to restore */
-	if (!(rp->power_limit_irq & PACKAGE_PLN_INT_SAVED))
-		return;
-
-	smp_call_function_single(rp->lead_cpu, power_limit_irq_restore_cpu, rp, 1);
-}
-
 static void set_floor_freq_default(struct rapl_domain *rd, bool mode)
 {
 	int nr_powerlimit = find_nr_power_limit(rd);
@@ -1183,48 +1168,14 @@ static void rapl_update_domain_data(stru
 
 }
 
-static int rapl_unregister_powercap(void)
+static void rapl_unregister_powercap(void)
 {
-	struct rapl_package *rp;
-	struct rapl_domain *rd, *rd_package = NULL;
-
-	/* unregister all active rapl packages from the powercap layer,
-	 * hotplug lock held
-	 */
-	list_for_each_entry(rp, &rapl_packages, plist) {
-		package_power_limit_irq_restore(rp);
-
-		for (rd = rp->domains; rd < rp->domains + rp->nr_domains;
-		     rd++) {
-			pr_debug("remove package, undo power limit on %d: %s\n",
-				rp->id, rd->name);
-			rapl_write_data_raw(rd, PL1_ENABLE, 0);
-			rapl_write_data_raw(rd, PL1_CLAMP, 0);
-			if (find_nr_power_limit(rd) > 1) {
-				rapl_write_data_raw(rd, PL2_ENABLE, 0);
-				rapl_write_data_raw(rd, PL2_CLAMP, 0);
-			}
-			if (rd->id == RAPL_DOMAIN_PACKAGE) {
-				rd_package = rd;
-				continue;
-			}
-			powercap_unregister_zone(control_type, &rd->power_zone);
-		}
-		/* do the package zone last */
-		if (rd_package)
-			powercap_unregister_zone(control_type,
-						&rd_package->power_zone);
-	}
-
 	if (platform_rapl_domain) {
 		powercap_unregister_zone(control_type,
 					 &platform_rapl_domain->power_zone);
 		kfree(platform_rapl_domain);
 	}
-
 	powercap_unregister_control_type(control_type);
-
-	return 0;
 }
 
 static int rapl_package_register_powercap(struct rapl_package *rp)
@@ -1289,7 +1240,8 @@ static int rapl_package_register_powerca
 	return 0;
 
 err_cleanup:
-	/* clean up previously initialized domains within the package if we
+	/*
+	 * Clean up previously initialized domains within the package if we
 	 * failed after the first domain setup.
 	 */
 	while (--rd >= rp->domains) {
@@ -1300,7 +1252,7 @@ static int rapl_package_register_powerca
 	return ret;
 }
 
-static int rapl_register_psys(void)
+static int __init rapl_register_psys(void)
 {
 	struct rapl_domain *rd;
 	struct powercap_zone *power_zone;
@@ -1341,39 +1293,14 @@ static int rapl_register_psys(void)
 	return 0;
 }
 
-static int rapl_register_powercap(void)
+static int __init rapl_register_powercap(void)
 {
-	struct rapl_domain *rd;
-	struct rapl_package *rp;
-	int ret = 0;
-
 	control_type = powercap_register_control_type(NULL, "intel-rapl", NULL);
 	if (IS_ERR(control_type)) {
 		pr_debug("failed to register powercap control_type.\n");
 		return PTR_ERR(control_type);
 	}
-
-	list_for_each_entry(rp, &rapl_packages, plist)
-		if (rapl_package_register_powercap(rp))
-			goto err_cleanup_package;
-
-	/* Don't bail out if PSys is not supported */
-	rapl_register_psys();
-
-	return ret;
-
-err_cleanup_package:
-	/* clean up previously initialized packages */
-	list_for_each_entry_continue_reverse(rp, &rapl_packages, plist) {
-		for (rd = rp->domains; rd < rp->domains + rp->nr_domains;
-		     rd++) {
-			pr_debug("unregister zone/package %d, %s domain\n",
-				rp->id, rd->name);
-			powercap_unregister_zone(control_type, &rd->power_zone);
-		}
-	}
-
-	return ret;
+	return 0;
 }
 
 static int rapl_check_domain(int cpu, int domain)
@@ -1446,9 +1373,8 @@ static void rapl_detect_powerlimit(struc
  */
 static int rapl_detect_domains(struct rapl_package *rp, int cpu)
 {
-	int i;
-	int ret = 0;
 	struct rapl_domain *rd;
+	int i;
 
 	for (i = 0; i < RAPL_DOMAIN_MAX; i++) {
 		/* use physical package id to read counters */
@@ -1460,84 +1386,20 @@ static int rapl_detect_domains(struct ra
 	rp->nr_domains = bitmap_weight(&rp->domain_map,	RAPL_DOMAIN_MAX);
 	if (!rp->nr_domains) {
 		pr_debug("no valid rapl domains found in package %d\n", rp->id);
-		ret = -ENODEV;
-		goto done;
+		return -ENODEV;
 	}
 	pr_debug("found %d domains on package %d\n", rp->nr_domains, rp->id);
 
 	rp->domains = kcalloc(rp->nr_domains + 1, sizeof(struct rapl_domain),
 			GFP_KERNEL);
-	if (!rp->domains) {
-		ret = -ENOMEM;
-		goto done;
-	}
+	if (!rp->domains)
+		return -ENOMEM;
+
 	rapl_init_domains(rp);
 
 	for (rd = rp->domains; rd < rp->domains + rp->nr_domains; rd++)
 		rapl_detect_powerlimit(rd);
 
-
-
-done:
-	return ret;
-}
-
-static bool is_package_new(int package)
-{
-	struct rapl_package *rp;
-
-	/* caller prevents cpu hotplug, there will be no new packages added
-	 * or deleted while traversing the package list, no need for locking.
-	 */
-	list_for_each_entry(rp, &rapl_packages, plist)
-		if (package == rp->id)
-			return false;
-
-	return true;
-}
-
-/* RAPL interface can be made of a two-level hierarchy: package level and domain
- * level. We first detect the number of packages then domains of each package.
- * We have to consider the possiblity of CPU online/offline due to hotplug and
- * other scenarios.
- */
-static int rapl_detect_topology(void)
-{
-	int i;
-	int phy_package_id;
-	struct rapl_package *new_package, *rp;
-
-	for_each_online_cpu(i) {
-		phy_package_id = topology_physical_package_id(i);
-		if (is_package_new(phy_package_id)) {
-			new_package = kzalloc(sizeof(*rp), GFP_KERNEL);
-			if (!new_package) {
-				rapl_cleanup_data();
-				return -ENOMEM;
-			}
-			/* add the new package to the list */
-			new_package->id = phy_package_id;
-			new_package->nr_cpus = 1;
-			/* use the first active cpu of the package to access */
-			new_package->lead_cpu = i;
-			/* check if the package contains valid domains */
-			if (rapl_detect_domains(new_package, i) ||
-				rapl_defaults->check_unit(new_package, i)) {
-				kfree(new_package->domains);
-				kfree(new_package);
-				/* free up the packages already initialized */
-				rapl_cleanup_data();
-				return -ENODEV;
-			}
-			INIT_LIST_HEAD(&new_package->plist);
-			list_add(&new_package->plist, &rapl_packages);
-		} else {
-			rp = find_package_by_id(phy_package_id);
-			if (rp)
-				++rp->nr_cpus;
-		}
-	}
-
 	return 0;
 }
 
@@ -1546,12 +1408,21 @@ static void rapl_remove_package(struct r
 {
 	struct rapl_domain *rd, *rd_package = NULL;
 
+	package_power_limit_irq_restore(rp);
+
 	for (rd = rp->domains; rd < rp->domains + rp->nr_domains; rd++) {
+		rapl_write_data_raw(rd, PL1_ENABLE, 0);
+		rapl_write_data_raw(rd, PL1_CLAMP, 0);
+		if (find_nr_power_limit(rd) > 1) {
+			rapl_write_data_raw(rd, PL2_ENABLE, 0);
+			rapl_write_data_raw(rd, PL2_CLAMP, 0);
+		}
 		if (rd->id == RAPL_DOMAIN_PACKAGE) {
 			rd_package = rd;
 			continue;
 		}
-		pr_debug("remove package %d, %s domain\n", rp->id, rd->name);
+		pr_debug("remove package, undo power limit on %d: %s\n",
+			 rp->id, rd->name);
 		powercap_unregister_zone(control_type, &rd->power_zone);
 	}
 	/* do parent zone last */
@@ -1611,11 +1482,11 @@ static int rapl_cpu_online(unsigned int
 	phy_package_id = topology_physical_package_id(cpu);
 
 	rp = find_package_by_id(phy_package_id);
-	if (rp)
+	if (rp) {
 		rp->nr_cpus++;
-	else
-		rapl_add_package(cpu);
-	return 0;
+		return 0;
+	}
+	return rapl_add_package(cpu);
 }
 
 static int rapl_cpu_down_prep(unsigned int cpu)
@@ -1648,8 +1519,8 @@ static enum cpuhp_state pcap_rapl_online
 
 static int __init rapl_init(void)
 {
-	int ret = 0;
 	const struct x86_cpu_id *id;
+	int ret;
 
 	id = x86_match_cpu(rapl_ids);
 	if (!id) {
@@ -1661,42 +1532,29 @@ static int __init rapl_init(void)
 
 	rapl_defaults = (struct rapl_defaults *)id->driver_data;
 
-	/* prevent CPU hotplug during detection */
-	get_online_cpus();
-	ret = rapl_detect_topology();
+	ret = rapl_register_powercap();
 	if (ret)
-		goto err;
+		return ret;
 
-	if (rapl_register_powercap()) {
-		ret = -ENODEV;
-		goto err_cleanup;
-	}
-	ret = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
-					"powercap/rapl:online",
-					rapl_cpu_online, rapl_cpu_down_prep);
+	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "powercap/rapl:online",
+				rapl_cpu_online, rapl_cpu_down_prep);
 	if (ret < 0)
 		goto err_unreg;
 	pcap_rapl_online = ret;
-	put_online_cpus();
+
+	/* Don't bail out if PSys is not supported */
+	rapl_register_psys();
 	return 0;
 
 err_unreg:
 	rapl_unregister_powercap();
-
-err_cleanup:
-	rapl_cleanup_data();
-err:
-	put_online_cpus();
 	return ret;
 }
 
 static void __exit rapl_exit(void)
 {
-	get_online_cpus();
 	cpuhp_remove_state(pcap_rapl_online);
 	rapl_unregister_powercap();
-	rapl_cleanup_data();
-	put_online_cpus();
 }
 
 module_init(rapl_init);
