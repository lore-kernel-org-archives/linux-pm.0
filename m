From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 11/16] PM / OPP: Add helpers for initializing CPU OPPs
Date: Wed, 29 Jul 2015 16:23:06 +0530
Message-ID: <41e8c355e4e9f5a71b380cf87a7e09d10f00c606.1438166099.git.viresh.kumar@linaro.org>
References: <cover.1438166099.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1438166099.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1438166099.git.viresh.kumar@linaro.org>
References: <cover.1438166099.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, sboyd@codeaurora.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, rob.herring@linaro.org, arnd.bergmann@linaro.org, nm@ti.com, broonie@kernel.org, mturquette@baylibre.com, Sudeep.Holla@arm.com, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com, b.zolnierkie@samsung.com, Viresh Kumar <viresh.kumar@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

With "operating-points-v2" its possible to tell which devices share
OPPs. We already have infrastructure to decode that information.

This patch adds following APIs:
- of_get_cpus_sharing_opps: Returns cpumask of CPUs sharing OPPs (only
  valid with v2 bindings).
- of_cpumask_init_opp_table: Initializes OPPs for all CPUs present in
  cpumask.
- of_cpumask_free_opp_table: Frees OPPs for all CPUs present in cpumask.

- set_cpus_sharing_opps: Sets which CPUs share OPPs (only valid with old
  OPP bindings, as this information isn't present in DT).

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp.c | 175 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_opp.h   |  23 +++++++
 2 files changed, 198 insertions(+)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index 0ebcea49145a..9bc4e7c21deb 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -11,6 +11,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/cpu.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/err.h>
@@ -1195,6 +1196,26 @@ void of_free_opp_table(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(of_free_opp_table);
 
+void of_cpumask_free_opp_table(cpumask_var_t cpumask)
+{
+	struct device *cpu_dev;
+	int cpu;
+
+	WARN_ON(cpumask_empty(cpumask));
+
+	for_each_cpu(cpu, cpumask) {
+		cpu_dev = get_cpu_device(cpu);
+		if (!cpu_dev) {
+			pr_err("%s: failed to get cpu%d device\n", __func__,
+			       cpu);
+			continue;
+		}
+
+		of_free_opp_table(cpu_dev);
+	}
+}
+EXPORT_SYMBOL_GPL(of_cpumask_free_opp_table);
+
 /* Returns opp descriptor node from its phandle. Caller must do of_node_put() */
 static struct device_node *
 _of_get_opp_desc_node_from_prop(struct device *dev, const struct property *prop)
@@ -1211,6 +1232,31 @@ _of_get_opp_desc_node_from_prop(struct device *dev, const struct property *prop)
 	return opp_np;
 }
 
+/* Returns opp descriptor node for a device. Caller must do of_node_put() */
+static struct device_node *_of_get_opp_desc_node(struct device *dev)
+{
+	const struct property *prop;
+
+	prop = of_find_property(dev->of_node, "operating-points-v2", NULL);
+	if (!prop)
+		return ERR_PTR(-ENODEV);
+	if (!prop->value)
+		return ERR_PTR(-ENODATA);
+
+	/*
+	 * TODO: Support for multiple OPP tables.
+	 *
+	 * There should be only ONE phandle present in "operating-points-v2"
+	 * property.
+	 */
+	if (prop->length != sizeof(__be32)) {
+		dev_err(dev, "%s: Invalid opp desc phandle\n", __func__);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return _of_get_opp_desc_node_from_prop(dev, prop);
+}
+
 /* Initializes OPP tables based on new bindings */
 static int _of_init_opp_table_v2(struct device *dev,
 				 const struct property *prop)
@@ -1351,4 +1397,133 @@ int of_init_opp_table(struct device *dev)
 	return _of_init_opp_table_v2(dev, prop);
 }
 EXPORT_SYMBOL_GPL(of_init_opp_table);
+
+int of_cpumask_init_opp_table(cpumask_var_t cpumask)
+{
+	struct device *cpu_dev;
+	int cpu, ret = 0;
+
+	WARN_ON(cpumask_empty(cpumask));
+
+	for_each_cpu(cpu, cpumask) {
+		cpu_dev = get_cpu_device(cpu);
+		if (!cpu_dev) {
+			pr_err("%s: failed to get cpu%d device\n", __func__,
+			       cpu);
+			continue;
+		}
+
+		ret = of_init_opp_table(cpu_dev);
+		if (ret) {
+			pr_err("%s: couldn't find opp table for cpu:%d, %d\n",
+			       __func__, cpu, ret);
+
+			/* Free all other OPPs */
+			of_cpumask_free_opp_table(cpumask);
+			break;
+		}
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(of_cpumask_init_opp_table);
+
+/* Required only for V1 bindings, as v2 can manage it from DT itself */
+int set_cpus_sharing_opps(struct device *cpu_dev, cpumask_var_t cpumask)
+{
+	struct device_list_opp *list_dev;
+	struct device_opp *dev_opp;
+	struct device *dev;
+	int cpu, ret = 0;
+
+	rcu_read_lock();
+
+	dev_opp = _find_device_opp(cpu_dev);
+	if (IS_ERR(dev_opp)) {
+		ret = -EINVAL;
+		goto out_rcu_read_unlock;
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
+		list_dev = _add_list_dev(dev, dev_opp);
+		if (!list_dev) {
+			dev_err(dev, "%s: failed to add list-dev for cpu%d device\n",
+				__func__, cpu);
+			continue;
+		}
+	}
+out_rcu_read_unlock:
+	rcu_read_unlock();
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(set_cpus_sharing_opps);
+
+/*
+ * Works only for OPP v2 bindings.
+ *
+ * cpumask should be already set to mask of cpu_dev->id.
+ * Returns -ENOENT if operating-points-v2 bindings aren't supported.
+ */
+int of_get_cpus_sharing_opps(struct device *cpu_dev, cpumask_var_t cpumask)
+{
+	struct device_node *np, *tmp_np;
+	struct device *tcpu_dev;
+	int cpu, ret = 0;
+
+	/* Get OPP descriptor node */
+	np = _of_get_opp_desc_node(cpu_dev);
+	if (IS_ERR(np)) {
+		dev_dbg(cpu_dev, "%s: Couldn't find opp node: %ld\n", __func__,
+			PTR_ERR(np));
+		return -ENOENT;
+	}
+
+	/* OPPs are shared ? */
+	if (!of_get_property(np, "opp-shared", NULL))
+		goto put_cpu_node;
+
+	for_each_possible_cpu(cpu) {
+		if (cpu == cpu_dev->id)
+			continue;
+
+		tcpu_dev = get_cpu_device(cpu);
+		if (!tcpu_dev) {
+			dev_err(cpu_dev, "%s: failed to get cpu%d device\n",
+				__func__, cpu);
+			ret = -ENODEV;
+			goto put_cpu_node;
+		}
+
+		/* Get OPP descriptor node */
+		tmp_np = _of_get_opp_desc_node(tcpu_dev);
+		if (IS_ERR(tmp_np)) {
+			dev_info(tcpu_dev, "%s: Couldn't find opp node: %ld\n",
+				 __func__, PTR_ERR(tmp_np));
+			ret = -EINVAL;
+			goto put_cpu_node;
+		}
+
+		/* CPUs are sharing opp node */
+		if (np == tmp_np)
+			cpumask_set_cpu(cpu, cpumask);
+
+		of_node_put(tmp_np);
+	}
+
+put_cpu_node:
+	of_node_put(np);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(of_get_cpus_sharing_opps);
 #endif
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 20324b579adc..bb52fae5b921 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -121,6 +121,10 @@ static inline struct srcu_notifier_head *dev_pm_opp_get_notifier(
 #if defined(CONFIG_PM_OPP) && defined(CONFIG_OF)
 int of_init_opp_table(struct device *dev);
 void of_free_opp_table(struct device *dev);
+int of_cpumask_init_opp_table(cpumask_var_t cpumask);
+void of_cpumask_free_opp_table(cpumask_var_t cpumask);
+int of_get_cpus_sharing_opps(struct device *cpu_dev, cpumask_var_t cpumask);
+int set_cpus_sharing_opps(struct device *cpu_dev, cpumask_var_t cpumask);
 #else
 static inline int of_init_opp_table(struct device *dev)
 {
@@ -130,6 +134,25 @@ static inline int of_init_opp_table(struct device *dev)
 static inline void of_free_opp_table(struct device *dev)
 {
 }
+
+static inline int of_cpumask_init_opp_table(cpumask_var_t cpumask)
+{
+	return -ENOSYS;
+}
+
+static inline void of_cpumask_free_opp_table(cpumask_var_t cpumask)
+{
+}
+
+static inline int of_get_cpus_sharing_opps(struct device *cpu_dev, cpumask_var_t cpumask)
+{
+	return -ENOSYS;
+}
+
+static inline int set_cpus_sharing_opps(struct device *cpu_dev, cpumask_var_t cpumask)
+{
+	return -ENOSYS;
+}
 #endif
 
 #endif		/* __LINUX_OPP_H__ */
-- 
2.4.0
