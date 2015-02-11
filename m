From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 6/7] opp: Add helpers for initializing CPU opps
Date: Wed, 11 Feb 2015 16:16:29 +0800
Message-ID: <6bd4f6207604d97c0fd46ee39b0d296d5208ac68.1423642246.git.viresh.kumar@linaro.org>
References: <cover.1423642246.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:38263 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751971AbbBKIRP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 11 Feb 2015 03:17:15 -0500
Received: by pdbft15 with SMTP id ft15so2901693pdb.5
        for <linux-pm@vger.kernel.org>; Wed, 11 Feb 2015 00:17:14 -0800 (PST)
In-Reply-To: <cover.1423642246.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1423642246.git.viresh.kumar@linaro.org>
References: <cover.1423642246.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, rob.herring@linaro.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, arnd.bergmann@linaro.org, grant.likely@linaro.org, olof@lixom.net, nm@ti.com, Sudeep.Holla@arm.com, sboyd@codeaurora.org, devicetree@vger.kernel.org, santosh.shilimkar@oracle.com, mike.turquette@linaro.org, kesavan.abhilash@gmail.com, catalin.marinas@arm.com, ta.omasab@gmail.com, linux-arm-kernel@lists.infradead.org, thomas.petazzoni@free-electrons.com, l.stach@pengutronix.de, broonie@kernel.org, viswanath.puttagunta@linaro.org, Viresh Kumar <viresh.kumar@linaro.org>

This provides helpers to find which CPUs share OPPs and initialize OPPs for
them.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp.c | 113 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_opp.h   |  17 +++++++
 2 files changed, 130 insertions(+)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index 24a014b7a68a..751f56f323bf 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -11,6 +11,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/cpu.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/err.h>
@@ -1321,6 +1322,44 @@ int of_init_opp_table(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(of_init_opp_table);
 
+int of_cpumask_init_opp_table(cpumask_var_t cpumask)
+{
+	struct device *cpu_dev;
+	int cpu, tcpu, ret = 0;
+
+	if (cpumask_empty(cpumask))
+		return -EINVAL;
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
+			for_each_cpu(tcpu, cpumask) {
+				if (cpu == tcpu)
+					break;
+
+				cpu_dev = get_cpu_device(tcpu);
+				if (cpu_dev)
+					of_free_opp_table(cpu_dev);
+			}
+			break;
+		}
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(of_cpumask_init_opp_table);
+
 /**
  * of_free_opp_table() - Free OPP table entries created from static DT entries
  * @dev:	device pointer used to lookup device OPPs.
@@ -1368,4 +1407,78 @@ void of_free_opp_table(struct device *dev)
 	mutex_unlock(&dev_opp_list_lock);
 }
 EXPORT_SYMBOL_GPL(of_free_opp_table);
+
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
+/* Works only for OPP v2 bindings */
+int of_get_cpus_sharing_opps(struct device *cpu_dev, cpumask_var_t cpumask)
+{
+	struct device_node *np, *tmp_np;
+	struct device *tcpu_dev;
+	int cpu, ret = 0;
+
+	cpumask_set_cpu(cpu_dev->id, cpumask);
+
+	/* Get OPP descriptor node */
+	np = of_get_opp_desc_node(cpu_dev);
+	if (IS_ERR(np)) {
+		dev_info(cpu_dev, "%s: Couldn't find opp node: %ld\n", __func__,
+			 PTR_ERR(np));
+		return -EINVAL;
+	}
+
+	/* OPPs are shared ? */
+	if (!of_get_property(np, "shared-opp", NULL))
+		goto put_cpu_node;
+
+	for_each_possible_cpu(cpu) {
+		if (cpu == cpu_dev->id)
+			continue;
+
+		tcpu_dev = get_cpu_device(cpu);
+		if (!tcpu_dev) {
+			pr_err("failed to get cpu%d device\n", cpu);
+			ret = -ENODEV;
+			goto put_cpu_node;
+		}
+
+		/* Get OPP descriptor node */
+		tmp_np = of_get_opp_desc_node(tcpu_dev);
+		if (IS_ERR(tmp_np)) {
+			dev_info(tcpu_dev, "%s: Couldn't find opp node: %ld\n",
+				 __func__, PTR_ERR(np));
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
index 9949d07a93f9..41cbc7469b5a 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -115,6 +115,9 @@ static inline struct srcu_notifier_head *dev_pm_opp_get_notifier(
 #if defined(CONFIG_PM_OPP) && defined(CONFIG_OF)
 int of_init_opp_table(struct device *dev);
 void of_free_opp_table(struct device *dev);
+int of_cpumask_init_opp_table(cpumask_var_t cpumask);
+void of_cpumask_free_opp_table(cpumask_var_t cpumask);
+int of_get_cpus_sharing_opps(struct device *cpu_dev, cpumask_var_t cpumask);
 struct device_node *of_get_opp_desc_node(struct device *dev);
 #else
 static inline int of_init_opp_table(struct device *dev)
@@ -126,6 +129,20 @@ static inline void of_free_opp_table(struct device *dev)
 {
 }
 
+static inline int of_cpumask_init_opp_table(cpumask_var_t cpumask)
+{
+	return -EINVAL;
+}
+
+static inline void of_cpumask_free_opp_table(cpumask_var_t cpumask)
+{
+}
+
+static inline int of_get_cpus_sharing_opps(struct device *cpu_dev, cpumask_var_t cpumask)
+{
+	return -EINVAL;
+}
+
 static inline struct device_node *of_get_opp_desc_node(struct device *dev)
 {
 	return ERR_PTR(-EINVAL);
-- 
2.3.0.rc0.44.ga94655d

