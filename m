From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 04/10] PM / OPP: Relocate dev_pm_opp_set_sharing_cpus()
Date: Thu, 21 Apr 2016 14:28:56 +0530
Message-ID: <2e64f9a691dd6549baee5bf81cfe99d4b287b161.1461228504.git.viresh.kumar@linaro.org>
References: <cover.1461228504.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1461228504.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1461228504.git.viresh.kumar@linaro.org>
References: <cover.1461228504.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, arnd.bergmann@linaro.org, andrew@lunn.ch, gregory.clement@free-electrons.com, jason@lakedaemon.net, sebastian.hesselbarth@gmail.com, thomas.petazzoni@free-electrons.com, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Move dev_pm_opp_set_sharing_cpus() towards the end of the file. This
is required for better readability after the next patch is applied,
which adds dev_pm_opp_get_sharing_cpus().

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp/cpu.c | 112 +++++++++++++++++++++----------------------
 1 file changed, 56 insertions(+), 56 deletions(-)

diff --git a/drivers/base/power/opp/cpu.c b/drivers/base/power/opp/cpu.c
index b151401d1513..491e8684bd5f 100644
--- a/drivers/base/power/opp/cpu.c
+++ b/drivers/base/power/opp/cpu.c
@@ -119,62 +119,6 @@ void dev_pm_opp_free_cpufreq_table(struct device *dev,
 EXPORT_SYMBOL_GPL(dev_pm_opp_free_cpufreq_table);
 #endif	/* CONFIG_CPU_FREQ */
 
-/**
- * dev_pm_opp_set_sharing_cpus() - Mark OPP table as shared by few CPUs
- * @cpu_dev:	CPU device for which we do this operation
- * @cpumask:	cpumask of the CPUs which share the OPP table with @cpu_dev
- *
- * This marks OPP table of the @cpu_dev as shared by the CPUs present in
- * @cpumask.
- *
- * Returns -ENODEV if OPP table isn't already present.
- *
- * Locking: The internal opp_table and opp structures are RCU protected.
- * Hence this function internally uses RCU updater strategy with mutex locks
- * to keep the integrity of the internal data structures. Callers should ensure
- * that this function is *NOT* called under RCU protection or in contexts where
- * mutex cannot be locked.
- */
-int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, cpumask_var_t cpumask)
-{
-	struct opp_device *opp_dev;
-	struct opp_table *opp_table;
-	struct device *dev;
-	int cpu, ret = 0;
-
-	mutex_lock(&opp_table_lock);
-
-	opp_table = _find_opp_table(cpu_dev);
-	if (IS_ERR(opp_table)) {
-		ret = PTR_ERR(opp_table);
-		goto unlock;
-	}
-
-	for_each_cpu(cpu, cpumask) {
-		if (cpu == cpu_dev->id)
-			continue;
-
-		dev = get_cpu_device(cpu);
-		if (!dev) {
-			dev_err(cpu_dev, "%s: failed to get cpu%d device\n",
-				__func__, cpu);
-			continue;
-		}
-
-		opp_dev = _add_opp_dev(dev, opp_table);
-		if (!opp_dev) {
-			dev_err(dev, "%s: failed to add opp-dev for cpu%d device\n",
-				__func__, cpu);
-			continue;
-		}
-	}
-unlock:
-	mutex_unlock(&opp_table_lock);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(dev_pm_opp_set_sharing_cpus);
-
 #ifdef CONFIG_OF
 /**
  * dev_pm_opp_of_cpumask_remove_table() - Removes OPP table for @cpumask
@@ -326,3 +270,59 @@ int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev, cpumask_var_t cpumask
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_of_get_sharing_cpus);
 #endif
+
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
+int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, cpumask_var_t cpumask)
+{
+	struct opp_device *opp_dev;
+	struct opp_table *opp_table;
+	struct device *dev;
+	int cpu, ret = 0;
+
+	mutex_lock(&opp_table_lock);
+
+	opp_table = _find_opp_table(cpu_dev);
+	if (IS_ERR(opp_table)) {
+		ret = PTR_ERR(opp_table);
+		goto unlock;
+	}
+
+	for_each_cpu(cpu, cpumask) {
+		if (cpu == cpu_dev->id)
+			continue;
+
+		dev = get_cpu_device(cpu);
+		if (!dev) {
+			dev_err(cpu_dev, "%s: failed to get cpu%d device\n",
+				__func__, cpu);
+			continue;
+		}
+
+		opp_dev = _add_opp_dev(dev, opp_table);
+		if (!opp_dev) {
+			dev_err(dev, "%s: failed to add opp-dev for cpu%d device\n",
+				__func__, cpu);
+			continue;
+		}
+	}
+unlock:
+	mutex_unlock(&opp_table_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_set_sharing_cpus);
-- 
2.7.1.410.g6faf27b
