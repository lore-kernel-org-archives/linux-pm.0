From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 09/20] powercap/intel rapl: Convert to hotplug state machine
Date: Thu, 17 Nov 2016 19:35:30 +0100
Message-ID: <20161117183541.8588-10-bigeasy@linutronix.de>
References: <20161117183541.8588-1-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161117183541.8588-1-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: rt@linuxtronix.de, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Install the callbacks via the state machine as a first step. The init/exit
code is a duplicate of the hotplug code. This is cleaned up in a
consecutive patch.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/powercap/intel_rapl.c | 94 ++++++++++++++++++++++-----------------=
----
 1 file changed, 49 insertions(+), 45 deletions(-)

diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
index 44b12e2e4aa7..a42dd3b7e8a1 100644
--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -1607,50 +1607,48 @@ static int rapl_add_package(int cpu)
  * associated domains. Cooling devices are handled accordingly at
  * per-domain level.
  */
-static int rapl_cpu_callback(struct notifier_block *nfb,
-				unsigned long action, void *hcpu)
+static int rapl_cpu_online(unsigned int cpu)
+{
+	int phy_package_id;
+	struct rapl_package *rp;
+
+	phy_package_id =3D topology_physical_package_id(cpu);
+
+	rp =3D find_package_by_id(phy_package_id);
+	if (rp)
+		++rp->nr_cpus;
+	else
+		rapl_add_package(cpu);
+	return 0;
+}
+
+static int rapl_cpu_down_prep(unsigned int cpu)
 {
-	unsigned long cpu =3D (unsigned long)hcpu;
 	int phy_package_id;
 	struct rapl_package *rp;
 	int lead_cpu;
=20
 	phy_package_id =3D topology_physical_package_id(cpu);
-	switch (action) {
-	case CPU_ONLINE:
-	case CPU_ONLINE_FROZEN:
-	case CPU_DOWN_FAILED:
-	case CPU_DOWN_FAILED_FROZEN:
-		rp =3D find_package_by_id(phy_package_id);
-		if (rp)
-			++rp->nr_cpus;
-		else
-			rapl_add_package(cpu);
-		break;
-	case CPU_DOWN_PREPARE:
-	case CPU_DOWN_PREPARE_FROZEN:
-		rp =3D find_package_by_id(phy_package_id);
-		if (!rp)
-			break;
-		if (--rp->nr_cpus =3D=3D 0)
-			rapl_remove_package(rp);
-		else if (cpu =3D=3D rp->lead_cpu) {
-			/* choose another active cpu in the package */
-			lead_cpu =3D cpumask_any_but(topology_core_cpumask(cpu), cpu);
-			if (lead_cpu < nr_cpu_ids)
-				rp->lead_cpu =3D lead_cpu;
-			else /* should never go here */
-				pr_err("no active cpu available for package %d\n",
-					phy_package_id);
+	rp =3D find_package_by_id(phy_package_id);
+	if (!rp)
+		return 0;
+	if (--rp->nr_cpus =3D=3D 0) {
+		rapl_remove_package(rp);
+	} else if (cpu =3D=3D rp->lead_cpu) {
+		/* choose another active cpu in the package */
+		lead_cpu =3D cpumask_any_but(topology_core_cpumask(cpu), cpu);
+		if (lead_cpu < nr_cpu_ids) {
+			rp->lead_cpu =3D lead_cpu;
+		} else {
+			/* should never go here */
+			pr_err("no active cpu available for package %d\n",
+			       phy_package_id);
 		}
 	}
-
-	return NOTIFY_OK;
+	return 0;
 }
=20
-static struct notifier_block rapl_cpu_notifier =3D {
-	.notifier_call =3D rapl_cpu_callback,
-};
+static enum cpuhp_state pcap_rapl_online;
=20
 static int __init rapl_init(void)
 {
@@ -1667,36 +1665,42 @@ static int __init rapl_init(void)
=20
 	rapl_defaults =3D (struct rapl_defaults *)id->driver_data;
=20
-	cpu_notifier_register_begin();
-
 	/* prevent CPU hotplug during detection */
 	get_online_cpus();
 	ret =3D rapl_detect_topology();
 	if (ret)
-		goto done;
+		goto err;
=20
 	if (rapl_register_powercap()) {
-		rapl_cleanup_data();
 		ret =3D -ENODEV;
-		goto done;
+		goto err_cleanup;
 	}
-	__register_hotcpu_notifier(&rapl_cpu_notifier);
-done:
+	ret =3D cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
+					"powercap/rapl:online",
+					rapl_cpu_online, rapl_cpu_down_prep);
+	if (ret < 0)
+		goto err_unreg;
+	pcap_rapl_online =3D ret;
 	put_online_cpus();
-	cpu_notifier_register_done();
+	return 0;
=20
+err_unreg:
+	rapl_unregister_powercap();
+
+err_cleanup:
+	rapl_cleanup_data();
+err:
+	put_online_cpus();
 	return ret;
 }
=20
 static void __exit rapl_exit(void)
 {
-	cpu_notifier_register_begin();
 	get_online_cpus();
-	__unregister_hotcpu_notifier(&rapl_cpu_notifier);
+	cpuhp_remove_state(pcap_rapl_online);
 	rapl_unregister_powercap();
 	rapl_cleanup_data();
 	put_online_cpus();
-	cpu_notifier_register_done();
 }
=20
 module_init(rapl_init);
--=20
2.10.2
