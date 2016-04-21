From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 02/10] PM / OPP: Add missing doc style comments
Date: Thu, 21 Apr 2016 14:28:54 +0530
Message-ID: <084f8a8dbb2b0c97d2e1343d1f14d165b9942e02.1461228504.git.viresh.kumar@linaro.org>
References: <cover.1461228504.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1461228504.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1461228504.git.viresh.kumar@linaro.org>
References: <cover.1461228504.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, arnd.bergmann@linaro.org, andrew@lunn.ch, gregory.clement@free-electrons.com, jason@lakedaemon.net, sebastian.hesselbarth@gmail.com, thomas.petazzoni@free-electrons.com, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Few of the routines in cpu.c were missing these, add them.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp/cpu.c | 59 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 58 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/opp/cpu.c b/drivers/base/power/opp/cpu.c
index b7411a3cdcb1..b151401d1513 100644
--- a/drivers/base/power/opp/cpu.c
+++ b/drivers/base/power/opp/cpu.c
@@ -119,7 +119,22 @@ void dev_pm_opp_free_cpufreq_table(struct device *dev,
 EXPORT_SYMBOL_GPL(dev_pm_opp_free_cpufreq_table);
 #endif	/* CONFIG_CPU_FREQ */
 
-/* Required only for V1 bindings, as v2 can manage it from DT itself */
+/**
+ * dev_pm_opp_set_sharing_cpus() - Mark OPP table as shared by few CPUs
+ * @cpu_dev:	CPU device for which we do this operation
+ * @cpumask:	cpumask of the CPUs which share the OPP table with @cpu_dev
+ *
+ * This marks OPP table of the @cpu_dev as shared by the CPUs present in
+ * @cpumask.
+ *
+ * Returns -ENODEV if OPP table isn't already present.
+ *
+ * Locking: The internal opp_table and opp structures are RCU protected.
+ * Hence this function internally uses RCU updater strategy with mutex locks
+ * to keep the integrity of the internal data structures. Callers should ensure
+ * that this function is *NOT* called under RCU protection or in contexts where
+ * mutex cannot be locked.
+ */
 int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, cpumask_var_t cpumask)
 {
 	struct opp_device *opp_dev;
@@ -161,6 +176,18 @@ int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, cpumask_var_t cpumask)
 EXPORT_SYMBOL_GPL(dev_pm_opp_set_sharing_cpus);
 
 #ifdef CONFIG_OF
+/**
+ * dev_pm_opp_of_cpumask_remove_table() - Removes OPP table for @cpumask
+ * @cpumask:	cpumask for which OPP table needs to be removed
+ *
+ * This removes the OPP tables for CPUs present in the @cpumask.
+ *
+ * Locking: The internal opp_table and opp structures are RCU protected.
+ * Hence this function internally uses RCU updater strategy with mutex locks
+ * to keep the integrity of the internal data structures. Callers should ensure
+ * that this function is *NOT* called under RCU protection or in contexts where
+ * mutex cannot be locked.
+ */
 void dev_pm_opp_of_cpumask_remove_table(cpumask_var_t cpumask)
 {
 	struct device *cpu_dev;
@@ -181,6 +208,18 @@ void dev_pm_opp_of_cpumask_remove_table(cpumask_var_t cpumask)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_of_cpumask_remove_table);
 
+/**
+ * dev_pm_opp_of_cpumask_add_table() - Adds OPP table for @cpumask
+ * @cpumask:	cpumask for which OPP table needs to be added.
+ *
+ * This adds the OPP tables for CPUs present in the @cpumask.
+ *
+ * Locking: The internal opp_table and opp structures are RCU protected.
+ * Hence this function internally uses RCU updater strategy with mutex locks
+ * to keep the integrity of the internal data structures. Callers should ensure
+ * that this function is *NOT* called under RCU protection or in contexts where
+ * mutex cannot be locked.
+ */
 int dev_pm_opp_of_cpumask_add_table(cpumask_var_t cpumask)
 {
 	struct device *cpu_dev;
@@ -216,6 +255,24 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_of_cpumask_add_table);
  *
  * Returns -ENOENT if operating-points-v2 bindings aren't supported.
  */
+/**
+ * dev_pm_opp_of_get_sharing_cpus() - Get cpumask of CPUs sharing OPPs with
+ *				      @cpu_dev using operating-points-v2
+ *				      bindings.
+ *
+ * @cpu_dev:	CPU device for which we do this operation
+ * @cpumask:	cpumask to update with information of sharing CPUs
+ *
+ * This updates the @cpumask with CPUs that are sharing OPPs with @cpu_dev.
+ *
+ * Returns -ENOENT if operating-points-v2 isn't present for @cpu_dev.
+ *
+ * Locking: The internal opp_table and opp structures are RCU protected.
+ * Hence this function internally uses RCU updater strategy with mutex locks
+ * to keep the integrity of the internal data structures. Callers should ensure
+ * that this function is *NOT* called under RCU protection or in contexts where
+ * mutex cannot be locked.
+ */
 int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev, cpumask_var_t cpumask)
 {
 	struct device_node *np, *tmp_np;
-- 
2.7.1.410.g6faf27b
