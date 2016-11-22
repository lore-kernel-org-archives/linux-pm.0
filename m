From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 3/5] powercap/intel rapl: Convert to hotplug state machine
Date: Tue, 22 Nov 2016 21:16:00 -0000
Message-ID: <20161122211438.595830572@linutronix.de>
References: <20161122210518.079483154@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:60993 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932992AbcKVVSn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Nov 2016 16:18:43 -0500
Content-Disposition: inline;
 filename=powercapintel_rapl_Convert_to_hotplug_state_machine.patch
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Rafael Wysocki <rjw@sisk.pl>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Install the callbacks via the state machine as a first step. The init/exit
code is a duplicate of the hotplug code. This is cleaned up in a
consecutive patch.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 drivers/powercap/intel_rapl.c |   94 +++++++++++++++++++++---------------------
 1 file changed, 49 insertions(+), 45 deletions(-)

--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -1603,50 +1603,48 @@ static int rapl_add_package(int cpu)
  * associated domains. Cooling devices are handled accordingly at
  * per-domain level.
  */
-static int rapl_cpu_callback(struct notifier_block *nfb,
-				unsigned long action, void *hcpu)
+static int rapl_cpu_online(unsigned int cpu)
+{
+	struct rapl_package *rp;
+	int phy_package_id;
+
+	phy_package_id = topology_physical_package_id(cpu);
+
+	rp = find_package_by_id(phy_package_id);
+	if (rp)
+		rp->nr_cpus++;
+	else
+		rapl_add_package(cpu);
+	return 0;
+}
+
+static int rapl_cpu_down_prep(unsigned int cpu)
 {
-	unsigned long cpu = (unsigned long)hcpu;
 	int phy_package_id;
 	struct rapl_package *rp;
 	int lead_cpu;
 
 	phy_package_id = topology_physical_package_id(cpu);
-	switch (action) {
-	case CPU_ONLINE:
-	case CPU_ONLINE_FROZEN:
-	case CPU_DOWN_FAILED:
-	case CPU_DOWN_FAILED_FROZEN:
-		rp = find_package_by_id(phy_package_id);
-		if (rp)
-			++rp->nr_cpus;
-		else
-			rapl_add_package(cpu);
-		break;
-	case CPU_DOWN_PREPARE:
-	case CPU_DOWN_PREPARE_FROZEN:
-		rp = find_package_by_id(phy_package_id);
-		if (!rp)
-			break;
-		if (--rp->nr_cpus == 0)
-			rapl_remove_package(rp);
-		else if (cpu == rp->lead_cpu) {
-			/* choose another active cpu in the package */
-			lead_cpu = cpumask_any_but(topology_core_cpumask(cpu), cpu);
-			if (lead_cpu < nr_cpu_ids)
-				rp->lead_cpu = lead_cpu;
-			else /* should never go here */
-				pr_err("no active cpu available for package %d\n",
-					phy_package_id);
+	rp = find_package_by_id(phy_package_id);
+	if (!rp)
+		return 0;
+	if (--rp->nr_cpus == 0) {
+		rapl_remove_package(rp);
+	} else if (cpu == rp->lead_cpu) {
+		/* choose another active cpu in the package */
+		lead_cpu = cpumask_any_but(topology_core_cpumask(cpu), cpu);
+		if (lead_cpu < nr_cpu_ids) {
+			rp->lead_cpu = lead_cpu;
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
 
-static struct notifier_block rapl_cpu_notifier = {
-	.notifier_call = rapl_cpu_callback,
-};
+static enum cpuhp_state pcap_rapl_online;
 
 static int __init rapl_init(void)
 {
@@ -1663,36 +1661,42 @@ static int __init rapl_init(void)
 
 	rapl_defaults = (struct rapl_defaults *)id->driver_data;
 
-	cpu_notifier_register_begin();
-
 	/* prevent CPU hotplug during detection */
 	get_online_cpus();
 	ret = rapl_detect_topology();
 	if (ret)
-		goto done;
+		goto err;
 
 	if (rapl_register_powercap()) {
-		rapl_cleanup_data();
 		ret = -ENODEV;
-		goto done;
+		goto err_cleanup;
 	}
-	__register_hotcpu_notifier(&rapl_cpu_notifier);
-done:
+	ret = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
+					"powercap/rapl:online",
+					rapl_cpu_online, rapl_cpu_down_prep);
+	if (ret < 0)
+		goto err_unreg;
+	pcap_rapl_online = ret;
 	put_online_cpus();
-	cpu_notifier_register_done();
+	return 0;
 
+err_unreg:
+	rapl_unregister_powercap();
+
+err_cleanup:
+	rapl_cleanup_data();
+err:
+	put_online_cpus();
 	return ret;
 }
 
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
 
 module_init(rapl_init);


