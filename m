From: Waldemar Rymarkiewicz <waldemarx.rymarkiewicz@intel.com>
Subject: [PATCH v5 1/1] PM / OPP: Fix get sharing cpus when hotplug is used
Date: Thu, 27 Jul 2017 12:01:17 +0200
Message-ID: <20170727100128.26818-1-waldemarx.rymarkiewicz@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:21886 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751441AbdG0KBf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 27 Jul 2017 06:01:35 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: waldemar.rymarkiewicz@gmail.com, Waldemar Rymarkiewicz <waldemarx.rymarkiewicz@intel.com>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

We fail dev_pm_opp_of_get_sharing_cpus() when possible cpu device does not
exist. This can happen on platforms where not all possible CPUs are
available at start up ie. hotplugged out. Cpu device is not registered in
the system so we are not able to check struct device to set the sharing
CPUs bitmask properly.

Example (real use case):
2 physical MIPS cores, 4 VPE, cpu0/2 run Linux and cpu1/3 are not available
for Linux at boot up. cpufreq-dt driver + opp v2 fail to register opp_table
due to the fact there is no struct device for cpu1 (remains offline at
bootup).

To solve the bug, stop using device struct to check device_node. Instead
get cpu device_node directly from device tree with of_get_cpu_node().

Signed-off-by: Waldemar Rymarkiewicz <waldemarx.rymarkiewicz@intel.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/base/power/opp/of.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/base/power/opp/of.c b/drivers/base/power/opp/of.c
index 57eec1c..fba6d2e 100644
--- a/drivers/base/power/opp/of.c
+++ b/drivers/base/power/opp/of.c
@@ -248,15 +248,22 @@ void dev_pm_opp_of_remove_table(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_of_remove_table);
 
-/* Returns opp descriptor node for a device, caller must do of_node_put() */
-struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device *dev)
+/* Returns opp descriptor node for a device node, caller must
+ * do of_node_put() */
+static struct device_node *_opp_of_get_opp_desc_node(struct device_node *np)
 {
 	/*
 	 * There should be only ONE phandle present in "operating-points-v2"
 	 * property.
 	 */
 
-	return of_parse_phandle(dev->of_node, "operating-points-v2", 0);
+	return of_parse_phandle(np, "operating-points-v2", 0);
+}
+
+/* Returns opp descriptor node for a device, caller must do of_node_put() */
+struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device *dev)
+{
+	return _opp_of_get_opp_desc_node(dev->of_node);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_of_get_opp_desc_node);
 
@@ -572,8 +579,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_of_cpumask_add_table);
 int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev,
 				   struct cpumask *cpumask)
 {
-	struct device_node *np, *tmp_np;
-	struct device *tcpu_dev;
+	struct device_node *np, *tmp_np, *cpu_np;
 	int cpu, ret = 0;
 
 	/* Get OPP descriptor node */
@@ -593,19 +599,18 @@ int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev,
 		if (cpu == cpu_dev->id)
 			continue;
 
-		tcpu_dev = get_cpu_device(cpu);
-		if (!tcpu_dev) {
-			dev_err(cpu_dev, "%s: failed to get cpu%d device\n",
+		cpu_np = of_get_cpu_node(cpu, NULL);
+		if (!cpu_np) {
+			dev_err(cpu_dev, "%s: failed to get cpu%d node\n",
 				__func__, cpu);
-			ret = -ENODEV;
+			ret = -ENOENT;
 			goto put_cpu_node;
 		}
 
 		/* Get OPP descriptor node */
-		tmp_np = dev_pm_opp_of_get_opp_desc_node(tcpu_dev);
+		tmp_np = _opp_of_get_opp_desc_node(cpu_np);
 		if (!tmp_np) {
-			dev_err(tcpu_dev, "%s: Couldn't find opp node.\n",
-				__func__);
+			pr_err("%pOF: Couldn't find opp node\n", cpu_np);
 			ret = -ENOENT;
 			goto put_cpu_node;
 		}
-- 
2.10.1
