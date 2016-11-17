From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 10/20] powercap/intel_rapl: Cleanup duplicated init code
Date: Thu, 17 Nov 2016 19:35:31 +0100
Message-ID: <20161117183541.8588-11-bigeasy@linutronix.de>
References: <20161117183541.8588-1-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161117183541.8588-1-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: rt@linuxtronix.de, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
List-Id: linux-pm@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

The whole init/exit code is a duplicate of the cpuhotplug code. So we can
just let the hotplug code do the actual work of setting up and tearing down
the domains.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/powercap/intel_rapl.c | 173 +++++---------------------------------=
----
 1 file changed, 20 insertions(+), 153 deletions(-)

diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
index a42dd3b7e8a1..6c2e415c55c1 100644
--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -275,18 +275,6 @@ static struct rapl_package *find_package_by_id(int id)
 	return NULL;
 }
=20
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
 static int get_energy_counter(struct powercap_zone *power_zone, u64 *energ=
y_raw)
 {
 	struct rapl_domain *rd;
@@ -1173,58 +1161,24 @@ static void rapl_update_domain_data(struct rapl_pac=
kage *rp)
 	for (dmn =3D 0; dmn < rp->nr_domains; dmn++) {
 		pr_debug("update package %d domain %s data\n", rp->id,
 			 rp->domains[dmn].name);
-			/* exclude non-raw primitives */
+		/* exclude non-raw primitives */
 		for (prim =3D 0; prim < NR_RAW_PRIMITIVES; prim++) {
 			if (!rapl_read_data_raw(&rp->domains[dmn], prim,
-						rpi[prim].unit,	&val))
-				rp->domains[dmn].rdd.primitives[prim] =3D val;
+						rpi[prim].unit, &val))
+				rp->domains[dmn].rdd.primitives[prim] =3D	val;
 		}
 	}
=20
 }
=20
-static int rapl_unregister_powercap(void)
+static void rapl_unregister_powercap(void)
 {
-	struct rapl_package *rp;
-	struct rapl_domain *rd, *rd_package =3D NULL;
-
-	/* unregister all active rapl packages from the powercap layer,
-	 * hotplug lock held
-	 */
-	list_for_each_entry(rp, &rapl_packages, plist) {
-		package_power_limit_irq_restore(rp);
-
-		for (rd =3D rp->domains; rd < rp->domains + rp->nr_domains;
-		     rd++) {
-			pr_debug("remove package, undo power limit on %d: %s\n",
-				rp->id, rd->name);
-			rapl_write_data_raw(rd, PL1_ENABLE, 0);
-			rapl_write_data_raw(rd, PL1_CLAMP, 0);
-			if (find_nr_power_limit(rd) > 1) {
-				rapl_write_data_raw(rd, PL2_ENABLE, 0);
-				rapl_write_data_raw(rd, PL2_CLAMP, 0);
-			}
-			if (rd->id =3D=3D RAPL_DOMAIN_PACKAGE) {
-				rd_package =3D rd;
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
=20
 static int rapl_package_register_powercap(struct rapl_package *rp)
@@ -1347,37 +1301,16 @@ static int rapl_register_psys(void)
=20
 static int rapl_register_powercap(void)
 {
-	struct rapl_domain *rd;
-	struct rapl_package *rp;
-	int ret =3D 0;
-
 	control_type =3D powercap_register_control_type(NULL, "intel-rapl", NULL);
 	if (IS_ERR(control_type)) {
 		pr_debug("failed to register powercap control_type.\n");
 		return PTR_ERR(control_type);
 	}
=20
-	list_for_each_entry(rp, &rapl_packages, plist)
-		if (rapl_package_register_powercap(rp))
-			goto err_cleanup_package;
-
 	/* Don't bail out if PSys is not supported */
 	rapl_register_psys();
=20
-	return ret;
-
-err_cleanup_package:
-	/* clean up previously initialized packages */
-	list_for_each_entry_continue_reverse(rp, &rapl_packages, plist) {
-		for (rd =3D rp->domains; rd < rp->domains + rp->nr_domains;
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
=20
 static int rapl_check_domain(int cpu, int domain)
@@ -1486,76 +1419,26 @@ static int rapl_detect_domains(struct rapl_package =
*rp, int cpu)
 	return ret;
 }
=20
-static bool is_package_new(int package)
-{
-	struct rapl_package *rp;
-
-	/* caller prevents cpu hotplug, there will be no new packages added
-	 * or deleted while traversing the package list, no need for locking.
-	 */
-	list_for_each_entry(rp, &rapl_packages, plist)
-		if (package =3D=3D rp->id)
-			return false;
-
-	return true;
-}
-
-/* RAPL interface can be made of a two-level hierarchy: package level and =
domain
- * level. We first detect the number of packages then domains of each pack=
age.
- * We have to consider the possiblity of CPU online/offline due to hotplug=
 and
- * other scenarios.
- */
-static int rapl_detect_topology(void)
-{
-	int i;
-	int phy_package_id;
-	struct rapl_package *new_package, *rp;
-
-	for_each_online_cpu(i) {
-		phy_package_id =3D topology_physical_package_id(i);
-		if (is_package_new(phy_package_id)) {
-			new_package =3D kzalloc(sizeof(*rp), GFP_KERNEL);
-			if (!new_package) {
-				rapl_cleanup_data();
-				return -ENOMEM;
-			}
-			/* add the new package to the list */
-			new_package->id =3D phy_package_id;
-			new_package->nr_cpus =3D 1;
-			/* use the first active cpu of the package to access */
-			new_package->lead_cpu =3D i;
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
-			rp =3D find_package_by_id(phy_package_id);
-			if (rp)
-				++rp->nr_cpus;
-		}
-	}
-
-	return 0;
-}
-
 /* called from CPU hotplug notifier, hotplug lock held */
 static void rapl_remove_package(struct rapl_package *rp)
 {
 	struct rapl_domain *rd, *rd_package =3D NULL;
=20
 	for (rd =3D rp->domains; rd < rp->domains + rp->nr_domains; rd++) {
+		package_power_limit_irq_restore(rp);
+
+		pr_debug("remove package, undo power limit on %d: %s\n",
+			 rp->id, rd->name);
+		rapl_write_data_raw(rd, PL1_ENABLE, 0);
+		rapl_write_data_raw(rd, PL1_CLAMP, 0);
+		if (find_nr_power_limit(rd) > 1) {
+			rapl_write_data_raw(rd, PL2_ENABLE, 0);
+			rapl_write_data_raw(rd, PL2_CLAMP, 0);
+		}
 		if (rd->id =3D=3D RAPL_DOMAIN_PACKAGE) {
 			rd_package =3D rd;
 			continue;
 		}
-		pr_debug("remove package %d, %s domain\n", rp->id, rd->name);
 		powercap_unregister_zone(control_type, &rd->power_zone);
 	}
 	/* do parent zone last */
@@ -1652,8 +1535,8 @@ static enum cpuhp_state pcap_rapl_online;
=20
 static int __init rapl_init(void)
 {
-	int ret =3D 0;
 	const struct x86_cpu_id *id;
+	int ret;
=20
 	id =3D x86_match_cpu(rapl_ids);
 	if (!id) {
@@ -1665,42 +1548,26 @@ static int __init rapl_init(void)
=20
 	rapl_defaults =3D (struct rapl_defaults *)id->driver_data;
=20
-	/* prevent CPU hotplug during detection */
-	get_online_cpus();
-	ret =3D rapl_detect_topology();
+	ret =3D rapl_register_powercap();
 	if (ret)
-		goto err;
+		return ret;
=20
-	if (rapl_register_powercap()) {
-		ret =3D -ENODEV;
-		goto err_cleanup;
-	}
-	ret =3D cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
-					"powercap/rapl:online",
-					rapl_cpu_online, rapl_cpu_down_prep);
+	ret =3D cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "powercap/rapl:online",
+				rapl_cpu_online, rapl_cpu_down_prep);
 	if (ret < 0)
 		goto err_unreg;
 	pcap_rapl_online =3D ret;
-	put_online_cpus();
 	return 0;
=20
 err_unreg:
 	rapl_unregister_powercap();
-
-err_cleanup:
-	rapl_cleanup_data();
-err:
-	put_online_cpus();
 	return ret;
 }
=20
 static void __exit rapl_exit(void)
 {
-	get_online_cpus();
 	cpuhp_remove_state(pcap_rapl_online);
 	rapl_unregister_powercap();
-	rapl_cleanup_data();
-	put_online_cpus();
 }
=20
 module_init(rapl_init);
--=20
2.10.2
