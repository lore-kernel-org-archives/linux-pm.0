From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch V2 03/12] thermal/x86_pkg_temp: Replace open coded cpu search
Date: Tue, 22 Nov 2016 17:57:06 -0000
Message-ID: <20161122175357.109909226@linutronix.de>
References: <20161122175256.922158782@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline;
 filename=thermalx86_pkg_temp_Replace_open_coded_cpu_search.patch
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Rui Zhang <rui.zhang@intel.com>, edubezval@gmail.com, Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, linux-pm@vger.kernel.org, x86@kernel.org, rt@linutronix.de, Srinivas Pandruvada <srinivas.pandruvada@intel.com>
List-Id: linux-pm@vger.kernel.org

find_next_sibling() iterates over the online cpus and searches for a cpu
with the same package id as the current cpu. This is a pointless exercise
as topology_core_cpumask() allows a simple cpumask search for an online cpu
on the same package.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 drivers/thermal/x86_pkg_temp_thermal.c |   19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

--- a/drivers/thermal/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/x86_pkg_temp_thermal.c
@@ -384,18 +384,6 @@ static int pkg_temp_thermal_platform_the
 	return 0;
 }
 
-static int find_siblings_cpu(int cpu)
-{
-	int i;
-	int id = topology_physical_package_id(cpu);
-
-	for_each_online_cpu(i)
-		if (i != cpu && topology_physical_package_id(i) == id)
-			return i;
-
-	return 0;
-}
-
 static int pkg_temp_thermal_device_add(unsigned int cpu)
 {
 	int err;
@@ -488,9 +476,10 @@ static int pkg_temp_thermal_device_remov
 	mutex_lock(&phy_dev_list_mutex);
 	/* If we are loosing the first cpu for this package, we need change */
 	if (phdev->first_cpu == cpu) {
-		phdev->first_cpu = find_siblings_cpu(cpu);
-		pr_debug("thermal_device_remove: first cpu switched %d\n",
-					phdev->first_cpu);
+		int target = cpumask_any_but(topology_core_cpumask(cpu), cpu);
+
+		phdev->first_cpu = target;
+		pr_debug("CPU %d down. New first_cpu%d\n", cpu, target);
 	}
 	/*
 	* It is possible that no siblings left as this was the last cpu
