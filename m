From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 5/5] powercap/intel_rapl: Track active CPUs internally
Date: Tue, 22 Nov 2016 21:16:05 -0000
Message-ID: <20161122211438.755830906@linutronix.de>
References: <20161122210518.079483154@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline;
 filename=powercap-intel_rapl--Track-active-cpus-internally.patch
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Rafael Wysocki <rjw@sisk.pl>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

The ability of the CPU hotplug code to stop online/offline at each step
makes it necessary to track the activated CPUs in a package directly,
because outerwise a CPU offline callback can find CPUs which have already
executed the offline callback, but are not yet marked offline in the
topology mask. That could make such a CPU the package leader and in case
that CPU goes fully offline leave the package lead orphaned.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/powercap/intel_rapl.c |   59 +++++++++++++++++-------------------------
 1 file changed, 24 insertions(+), 35 deletions(-)

--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -189,14 +189,13 @@ struct rapl_package {
 	unsigned int time_unit;
 	struct rapl_domain *domains; /* array of domains, sized at runtime */
 	struct powercap_zone *power_zone; /* keep track of parent zone */
-	int nr_cpus; /* active cpus on the package, topology info is lost during
-		      * cpu hotplug. so we have to track ourselves.
-		      */
 	unsigned long power_limit_irq; /* keep track of package power limit
 					* notify interrupt enable status.
 					*/
 	struct list_head plist;
 	int lead_cpu; /* one active cpu per package for access */
+	/* Track active cpus */
+	struct cpumask cpumask;
 };
 
 struct rapl_defaults {
@@ -1432,19 +1431,17 @@ static void rapl_remove_package(struct r
 }
 
 /* called from CPU hotplug notifier, hotplug lock held */
-static int rapl_add_package(int cpu)
+static struct rapl_package *rapl_add_package(int cpu, int pkgid)
 {
 	struct rapl_package *rp;
-	int ret, phy_package_id;
+	int ret;
 
-	phy_package_id = topology_physical_package_id(cpu);
 	rp = kzalloc(sizeof(struct rapl_package), GFP_KERNEL);
 	if (!rp)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	/* add the new package to the list */
-	rp->id = phy_package_id;
-	rp->nr_cpus = 1;
+	rp->id = pkgid;
 	rp->lead_cpu = cpu;
 
 	/* check if the package contains valid domains */
@@ -1457,14 +1454,13 @@ static int rapl_add_package(int cpu)
 	if (!ret) {
 		INIT_LIST_HEAD(&rp->plist);
 		list_add(&rp->plist, &rapl_packages);
-		return 0;
+		return rp;
 	}
 
 err_free_package:
 	kfree(rp->domains);
 	kfree(rp);
-
-	return ret;
+	return ERR_PTR(ret);
 }
 
 /* Handles CPU hotplug on multi-socket systems.
@@ -1476,42 +1472,35 @@ static int rapl_add_package(int cpu)
  */
 static int rapl_cpu_online(unsigned int cpu)
 {
+	int pkgid = topology_physical_package_id(cpu);
 	struct rapl_package *rp;
-	int phy_package_id;
-
-	phy_package_id = topology_physical_package_id(cpu);
 
-	rp = find_package_by_id(phy_package_id);
-	if (rp) {
-		rp->nr_cpus++;
-		return 0;
+	rp = find_package_by_id(pkgid);
+	if (!rp) {
+		rp = rapl_add_package(cpu, pkgid);
+		if (IS_ERR(rp))
+			return PTR_ERR(rp);
 	}
-	return rapl_add_package(cpu);
+	cpumask_set_cpu(cpu, &rp->cpumask);
+	return 0;
 }
 
 static int rapl_cpu_down_prep(unsigned int cpu)
 {
-	int phy_package_id;
+	int pkgid = topology_physical_package_id(cpu);
 	struct rapl_package *rp;
 	int lead_cpu;
 
-	phy_package_id = topology_physical_package_id(cpu);
-	rp = find_package_by_id(phy_package_id);
+	rp = find_package_by_id(pkgid);
 	if (!rp)
 		return 0;
-	if (--rp->nr_cpus == 0) {
+
+	cpumask_clear_cpu(cpu, &rp->cpumask);
+	lead_cpu = cpumask_first(&rp->cpumask);
+	if (lead_cpu >= nr_cpu_ids)
 		rapl_remove_package(rp);
-	} else if (cpu == rp->lead_cpu) {
-		/* choose another active cpu in the package */
-		lead_cpu = cpumask_any_but(topology_core_cpumask(cpu), cpu);
-		if (lead_cpu < nr_cpu_ids) {
-			rp->lead_cpu = lead_cpu;
-		} else {
-			/* should never go here */
-			pr_err("no active cpu available for package %d\n",
-			       phy_package_id);
-		}
-	}
+	else if (rp->lead_cpu == cpu)
+		rp->lead_cpu = lead_cpu;
 	return 0;
 }
 
