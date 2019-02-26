From: Len Brown <lenb@kernel.org>
Subject: [PATCH 08/14] powercap/intel_rapl: Support multi-die/package
Date: Tue, 26 Feb 2019 01:20:06 -0500
Message-ID: <680e11fe0dcc65e4cfa5bfeaa0d1cdbe7896e3c0.1551160674.git.len.brown@intel.com>
References: <e2810a5317d3a109a98204e883fd1461f77b9339.1551160674.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e2810a5317d3a109a98204e883fd1461f77b9339.1551160674.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Zhang Rui <rui.zhang@intel.com>

On the new dual-die/package systems, the RAPL MSR becomes die-scope.
Thus instead of one powercap device per physical package, now there
should be one powercap device for each unique die on these systems.

This patch introduces intel_rapl driver support for new
dual-die/package systems.

On the hardwares that do not have multi-die, topology_logical_die_id()
equals topology_physical_package_id(), thus there is no functional change.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-pm@vger.kernel.org
---
 drivers/powercap/intel_rapl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
index 6057d9695fed..8723e9ae7436 100644
--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -266,7 +266,7 @@ static struct rapl_domain *platform_rapl_domain; /* Platform (PSys) domain */
 /* caller to ensure CPU hotplug lock is held */
 static struct rapl_package *rapl_find_package(int cpu)
 {
-	int id = topology_physical_package_id(cpu);
+	int id = topology_logical_die_id(cpu);
 	struct rapl_package *rp;
 
 	list_for_each_entry(rp, &rapl_packages, plist) {
@@ -1457,7 +1457,7 @@ static void rapl_remove_package(struct rapl_package *rp)
 /* called from CPU hotplug notifier, hotplug lock held */
 static struct rapl_package *rapl_add_package(int cpu)
 {
-	int id = topology_physical_package_id(cpu);
+	int id = topology_logical_die_id(cpu);
 	struct rapl_package *rp;
 	int ret;
 
-- 
2.18.0-rc0
