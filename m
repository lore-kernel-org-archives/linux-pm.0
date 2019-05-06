From: Len Brown <lenb@kernel.org>
Subject: [PATCH 09/22] powercap/intel_rapl: Simplify rapl_find_package()
Date: Mon,  6 May 2019 17:26:04 -0400
Message-ID: <b7a7b6e72e76510dc8dedb3e1b8b20de7cdca432.1557177585.git.len.brown@intel.com>
References: <6f53f0e494d743c79e18f6e3a98085711e6ddd0c.1557177585.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6f53f0e494d743c79e18f6e3a98085711e6ddd0c.1557177585.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Zhang Rui <rui.zhang@intel.com>

Syntax only, no functional or semantic change.

Simplify how the code to discover a package is called.
Rename find_package_by_id() to rapl_find_package_domain()

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-pm@vger.kernel.org
---
 drivers/powercap/intel_rapl.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
index 4347f15165f8..3c3c0c23180b 100644
--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -264,8 +264,9 @@ static struct powercap_control_type *control_type; /* PowerCap Controller */
 static struct rapl_domain *platform_rapl_domain; /* Platform (PSys) domain */
 
 /* caller to ensure CPU hotplug lock is held */
-static struct rapl_package *find_package_by_id(int id)
+static struct rapl_package *rapl_find_package_domain(int cpu)
 {
+	int id = topology_physical_package_id(cpu);
 	struct rapl_package *rp;
 
 	list_for_each_entry(rp, &rapl_packages, plist) {
@@ -1300,7 +1301,7 @@ static int __init rapl_register_psys(void)
 	rd->rpl[0].name = pl1_name;
 	rd->rpl[1].prim_id = PL2_ENABLE;
 	rd->rpl[1].name = pl2_name;
-	rd->rp = find_package_by_id(0);
+	rd->rp = rapl_find_package_domain(0);
 
 	power_zone = powercap_register_zone(&rd->power_zone, control_type,
 					    "psys", NULL,
@@ -1456,8 +1457,9 @@ static void rapl_remove_package(struct rapl_package *rp)
 }
 
 /* called from CPU hotplug notifier, hotplug lock held */
-static struct rapl_package *rapl_add_package(int cpu, int pkgid)
+static struct rapl_package *rapl_add_package(int cpu)
 {
+	int id = topology_physical_package_id(cpu);
 	struct rapl_package *rp;
 	int ret;
 
@@ -1466,7 +1468,7 @@ static struct rapl_package *rapl_add_package(int cpu, int pkgid)
 		return ERR_PTR(-ENOMEM);
 
 	/* add the new package to the list */
-	rp->id = pkgid;
+	rp->id = id;
 	rp->lead_cpu = cpu;
 
 	/* check if the package contains valid domains */
@@ -1497,12 +1499,11 @@ static struct rapl_package *rapl_add_package(int cpu, int pkgid)
  */
 static int rapl_cpu_online(unsigned int cpu)
 {
-	int pkgid = topology_physical_package_id(cpu);
 	struct rapl_package *rp;
 
-	rp = find_package_by_id(pkgid);
+	rp = rapl_find_package_domain(cpu);
 	if (!rp) {
-		rp = rapl_add_package(cpu, pkgid);
+		rp = rapl_add_package(cpu);
 		if (IS_ERR(rp))
 			return PTR_ERR(rp);
 	}
@@ -1512,11 +1513,10 @@ static int rapl_cpu_online(unsigned int cpu)
 
 static int rapl_cpu_down_prep(unsigned int cpu)
 {
-	int pkgid = topology_physical_package_id(cpu);
 	struct rapl_package *rp;
 	int lead_cpu;
 
-	rp = find_package_by_id(pkgid);
+	rp = rapl_find_package_domain(cpu);
 	if (!rp)
 		return 0;
 
-- 
2.18.0-rc0
