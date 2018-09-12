From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 08/11] OPP: Don't remove dynamic OPPs from _dev_pm_opp_remove_table()
Date: Wed, 12 Sep 2018 13:58:47 +0530
Message-ID: <4d433fbb463a5a66a5576e37173dac9a55f48b82.1536736872.git.viresh.kumar@linaro.org>
References: <cover.1536736872.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1536736872.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: niklas.cassel@linaro.org, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Only one platform was depending on this feature and it is already
updated now. Stop removing dynamic OPPs from _dev_pm_opp_remove_table().
This simplifies lot of paths and removes unnecessary parameters.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 20 +++++---------------
 drivers/opp/cpu.c  |  9 +++------
 drivers/opp/of.c   | 10 +++++-----
 drivers/opp/opp.h  |  6 +++---
 4 files changed, 16 insertions(+), 29 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index b555121b878b..2319ad4a0177 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1759,14 +1759,10 @@ int dev_pm_opp_unregister_notifier(struct device *dev,
 EXPORT_SYMBOL(dev_pm_opp_unregister_notifier);
 
 /*
- * Free OPPs either created using static entries present in DT or even the
- * dynamically added entries based on remove_all param.
+ * Free OPPs either created using static entries present in DT.
  */
-void _dev_pm_opp_remove_table(struct opp_table *opp_table, struct device *dev,
-			      bool remove_all)
+void _dev_pm_opp_remove_table(struct opp_table *opp_table, struct device *dev)
 {
-	struct dev_pm_opp *opp, *tmp;
-
 	/* Protect dev_list */
 	mutex_lock(&opp_table->lock);
 
@@ -1775,12 +1771,6 @@ void _dev_pm_opp_remove_table(struct opp_table *opp_table, struct device *dev,
 		/* Free static OPPs */
 		_put_opp_list_kref(opp_table);
 
-		/* Free dynamic OPPs */
-		list_for_each_entry_safe(opp, tmp, &opp_table->opp_list, node) {
-			if (remove_all)
-				dev_pm_opp_put(opp);
-		}
-
 		/*
 		 * The OPP table is getting removed, drop the performance state
 		 * constraints.
@@ -1795,7 +1785,7 @@ void _dev_pm_opp_remove_table(struct opp_table *opp_table, struct device *dev,
 	mutex_unlock(&opp_table->lock);
 }
 
-void _dev_pm_opp_find_and_remove_table(struct device *dev, bool remove_all)
+void _dev_pm_opp_find_and_remove_table(struct device *dev)
 {
 	struct opp_table *opp_table;
 
@@ -1812,7 +1802,7 @@ void _dev_pm_opp_find_and_remove_table(struct device *dev, bool remove_all)
 		return;
 	}
 
-	_dev_pm_opp_remove_table(opp_table, dev, remove_all);
+	_dev_pm_opp_remove_table(opp_table, dev);
 
 	dev_pm_opp_put_opp_table(opp_table);
 }
@@ -1826,6 +1816,6 @@ void _dev_pm_opp_find_and_remove_table(struct device *dev, bool remove_all)
  */
 void dev_pm_opp_remove_table(struct device *dev)
 {
-	_dev_pm_opp_find_and_remove_table(dev, true);
+	_dev_pm_opp_find_and_remove_table(dev);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_remove_table);
diff --git a/drivers/opp/cpu.c b/drivers/opp/cpu.c
index 2868a022a040..2d4505ea34d2 100644
--- a/drivers/opp/cpu.c
+++ b/drivers/opp/cpu.c
@@ -108,7 +108,7 @@ void dev_pm_opp_free_cpufreq_table(struct device *dev,
 EXPORT_SYMBOL_GPL(dev_pm_opp_free_cpufreq_table);
 #endif	/* CONFIG_CPU_FREQ */
 
-void _dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask, bool of)
+void _dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask)
 {
 	struct device *cpu_dev;
 	int cpu;
@@ -123,10 +123,7 @@ void _dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask, bool of)
 			continue;
 		}
 
-		if (of)
-			dev_pm_opp_of_remove_table(cpu_dev);
-		else
-			dev_pm_opp_remove_table(cpu_dev);
+		_dev_pm_opp_find_and_remove_table(cpu_dev);
 	}
 }
 
@@ -140,7 +137,7 @@ void _dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask, bool of)
  */
 void dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask)
 {
-	_dev_pm_opp_cpumask_remove_table(cpumask, false);
+	_dev_pm_opp_cpumask_remove_table(cpumask);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_cpumask_remove_table);
 
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 892d17069f05..9c98682af374 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -279,7 +279,7 @@ static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev,
  */
 void dev_pm_opp_of_remove_table(struct device *dev)
 {
-	_dev_pm_opp_find_and_remove_table(dev, false);
+	_dev_pm_opp_find_and_remove_table(dev);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_of_remove_table);
 
@@ -432,7 +432,7 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np,
 		if (ret) {
 			dev_err(dev, "%s: Failed to add OPP, %d\n", __func__,
 				ret);
-			_dev_pm_opp_remove_table(opp_table, dev, false);
+			_dev_pm_opp_remove_table(opp_table, dev);
 			of_node_put(np);
 			goto put_opp_table;
 		}
@@ -453,7 +453,7 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np,
 		dev_err(dev, "Not all nodes have performance state set (%d: %d)\n",
 			count, pstate_count);
 		ret = -ENOENT;
-		_dev_pm_opp_remove_table(opp_table, dev, false);
+		_dev_pm_opp_remove_table(opp_table, dev);
 		goto put_opp_table;
 	}
 
@@ -507,7 +507,7 @@ static int _of_add_opp_table_v1(struct device *dev)
 		if (ret) {
 			dev_err(dev, "%s: Failed to add OPP %ld (%d)\n",
 				__func__, freq, ret);
-			_dev_pm_opp_remove_table(opp_table, dev, false);
+			_dev_pm_opp_remove_table(opp_table, dev);
 			break;
 		}
 		nr -= 2;
@@ -618,7 +618,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_of_add_table_indexed);
  */
 void dev_pm_opp_of_cpumask_remove_table(const struct cpumask *cpumask)
 {
-	_dev_pm_opp_cpumask_remove_table(cpumask, true);
+	_dev_pm_opp_cpumask_remove_table(cpumask);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_of_cpumask_remove_table);
 
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 783428fa9c33..3b1d94748a4d 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -194,13 +194,13 @@ void _get_opp_table_kref(struct opp_table *opp_table);
 int _get_opp_count(struct opp_table *opp_table);
 struct opp_table *_find_opp_table(struct device *dev);
 struct opp_device *_add_opp_dev(const struct device *dev, struct opp_table *opp_table);
-void _dev_pm_opp_remove_table(struct opp_table *opp_table, struct device *dev, bool remove_all);
-void _dev_pm_opp_find_and_remove_table(struct device *dev, bool remove_all);
+void _dev_pm_opp_remove_table(struct opp_table *opp_table, struct device *dev);
+void _dev_pm_opp_find_and_remove_table(struct device *dev);
 struct dev_pm_opp *_opp_allocate(struct opp_table *opp_table);
 void _opp_free(struct dev_pm_opp *opp);
 int _opp_add(struct device *dev, struct dev_pm_opp *new_opp, struct opp_table *opp_table, bool rate_not_available);
 int _opp_add_v1(struct opp_table *opp_table, struct device *dev, unsigned long freq, long u_volt, bool dynamic);
-void _dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask, bool of);
+void _dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask);
 struct opp_table *_add_opp_table(struct device *dev);
 void _put_opp_list_kref(struct opp_table *opp_table);
 
-- 
2.18.0.rc1.242.g61856ae69a2c
