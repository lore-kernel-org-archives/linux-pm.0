From: Quentin Perret <quentin.perret@arm.com>
Subject: [PATCH 1/2] PM / OPP: introduce an OPP power estimation helper
Date: Tue,  9 Jan 2018 11:02:51 +0000
Message-ID: <20180109110252.13557-2-quentin.perret@arm.com>
References: <20180109110252.13557-1-quentin.perret@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52414 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752615AbeAILDD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 9 Jan 2018 06:03:03 -0500
In-Reply-To: <20180109110252.13557-1-quentin.perret@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, vireshk@kernel.org, nm@ti.com, sboyd@codeaurora.org, sudeep.holla@arm.com, amit.kachhap@gmail.com, javi.merino@kernel.org, rui.zhang@intel.com, edubezval@gmail.com, matthias.bgg@gmail.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, patrick.bellasi@arm.com, ionela.voinescu@arm.com

The power dissipated by a CPU at a specific OPP is currently estimated by
the thermal subsystem as P = C * V^2 * f, with P the power, C the CPU's
capacitance, V the OPP's voltage and f the OPP's frequency. As this
feature can be useful for other clients requiring energy models of CPUs,
this commit introduces an equivalent power estimator directly into the OPP
library, hence enabling code re-use.

Signed-off-by: Quentin Perret <quentin.perret@arm.com>
---
 drivers/opp/core.c     | 40 +++++++++++++++++++++++++++++++++
 drivers/opp/of.c       | 61 ++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/opp/opp.h      |  4 ++++
 include/linux/pm_opp.h | 20 +++++++++++++++++
 4 files changed, 125 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 92fa94a6dcc1..b5e1ad2d311d 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -127,6 +127,24 @@ unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_freq);
 
+/**
+ * dev_pm_opp_get_power() - Gets the estimated power corresponding to an opp
+ * @opp:	opp for which power has to be returned for
+ *
+ * Return: estimated power in mirco-watts corresponding to the opp, else
+ * return 0
+ */
+unsigned long dev_pm_opp_get_power(struct dev_pm_opp *opp)
+{
+	if (IS_ERR_OR_NULL(opp) || !opp->available) {
+		pr_err("%s: Invalid parameters\n", __func__);
+		return 0;
+	}
+
+	return opp->power_estimate_uw;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_get_power);
+
 /**
  * dev_pm_opp_is_turbo() - Returns if opp is turbo OPP or not
  * @opp: opp for which turbo mode is being verified
@@ -148,6 +166,28 @@ bool dev_pm_opp_is_turbo(struct dev_pm_opp *opp)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_is_turbo);
 
+/**
+ * dev_pm_opp_has_power() - Get the status of power values for OPPs
+ * @cpu_dev:	CPU device for which we do this operation
+ *
+ * Return: True if the OPPs hold power estimates for the CPU
+ */
+bool dev_pm_opp_has_power(struct device *cpu_dev)
+{
+	struct opp_table *opp_table;
+	bool has_power;
+
+	opp_table = _find_opp_table(cpu_dev);
+	if (IS_ERR(opp_table))
+		return false;
+
+	has_power = opp_table->has_power;
+
+	dev_pm_opp_put_opp_table(opp_table);
+
+	return has_power;
+}
+
 /**
  * dev_pm_opp_get_max_clock_latency() - Get max clock latency in nanoseconds
  * @dev:	device for which we do this operation
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index cb716aa2f44b..4a376cd00e8d 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -633,3 +633,64 @@ int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev,
 	return ret;
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_of_get_sharing_cpus);
+
+/**
+ * dev_pm_opp_of_estimate_power() - Estimates the power dissipated by @cpu_dev
+ *                                  at each OPP.
+ * @cpu_dev:	CPU device for which we do this estimation
+ *
+ * This estimates the active power consumed by a CPU at each OPP using:
+ *                         P = C * V^2 * f
+ * with P the power, C the CPU's capacitance, V the OPP's voltage and f the
+ * OPP's frequency. V and f are assumed to be known by the time this function
+ * is called and C is read from DT.
+ *
+ * Returns -EINVAL if the CPU's capacitance cannot be read from DT.
+ */
+int dev_pm_opp_of_estimate_power(struct device *cpu_dev)
+{
+	struct opp_table *opp_table;
+	unsigned long mV, uW, KHz;
+	struct device_node *np;
+	struct dev_pm_opp *opp;
+	u32 capacitance = 0;
+	int ret = 0;
+
+	opp_table = _find_opp_table(cpu_dev);
+	if (IS_ERR(opp_table)) {
+		ret = PTR_ERR(opp_table);
+		dev_dbg(cpu_dev, "%s: no OPP table (%d)\n", __func__, ret);
+		return ret;
+	}
+
+	np = of_node_get(cpu_dev->of_node);
+	if (!np) {
+		dev_err(cpu_dev, "%s: no node for cpu\n", __func__);
+		ret = -ENOENT;
+		goto out;
+	}
+
+	of_property_read_u32(np, "dynamic-power-coefficient", &capacitance);
+	of_node_put(np);
+
+	if (!capacitance) {
+		opp_table->has_power = false;
+		ret = -EINVAL;
+		goto out;
+	}
+
+	list_for_each_entry(opp, &opp_table->opp_list, node) {
+		mV = dev_pm_opp_get_voltage(opp) / 1000;
+		KHz = dev_pm_opp_get_freq(opp) / 1000;
+		uW = (unsigned long)capacitance * KHz * mV * mV;
+		uW /= 1000000000;
+		opp->power_estimate_uw = uW;
+	}
+
+	opp_table->has_power = true;
+
+out:
+	dev_pm_opp_put_opp_table(opp_table);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_of_estimate_power);
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 4d00061648a3..11cb62944bea 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -84,6 +84,8 @@ struct dev_pm_opp {
 
 	unsigned long clock_latency_ns;
 
+	unsigned long power_estimate_uw;
+
 	struct opp_table *opp_table;
 
 	struct device_node *np;
@@ -176,6 +178,8 @@ struct opp_table {
 	unsigned int regulator_count;
 	bool genpd_performance_state;
 
+	bool has_power;
+
 	int (*set_opp)(struct dev_pm_set_opp_data *data);
 	struct dev_pm_set_opp_data *set_opp_data;
 	int (*get_pstate)(struct device *dev, unsigned long rate);
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 6c2d2e88f066..63a0edc89c7c 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -85,8 +85,12 @@ unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp);
 
 unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp);
 
+unsigned long dev_pm_opp_get_power(struct dev_pm_opp *opp);
+
 bool dev_pm_opp_is_turbo(struct dev_pm_opp *opp);
 
+bool dev_pm_opp_has_power(struct device *cpu_dev);
+
 int dev_pm_opp_get_opp_count(struct device *dev);
 unsigned long dev_pm_opp_get_max_clock_latency(struct device *dev);
 unsigned long dev_pm_opp_get_max_volt_latency(struct device *dev);
@@ -150,11 +154,21 @@ static inline unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp)
 	return 0;
 }
 
+static inline unsigned long dev_pm_opp_get_power(struct dev_pm_opp *opp)
+{
+	return 0;
+}
+
 static inline bool dev_pm_opp_is_turbo(struct dev_pm_opp *opp)
 {
 	return false;
 }
 
+static inline bool dev_pm_opp_has_power(struct device *cpu_dev)
+{
+	return false;
+}
+
 static inline int dev_pm_opp_get_opp_count(struct device *dev)
 {
 	return 0;
@@ -308,6 +322,7 @@ int dev_pm_opp_of_cpumask_add_table(const struct cpumask *cpumask);
 void dev_pm_opp_of_cpumask_remove_table(const struct cpumask *cpumask);
 int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask);
 struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device *dev);
+int dev_pm_opp_of_estimate_power(struct device *cpu_dev);
 #else
 static inline int dev_pm_opp_of_add_table(struct device *dev)
 {
@@ -336,6 +351,11 @@ static inline struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device
 {
 	return NULL;
 }
+
+static inline int dev_pm_opp_of_estimate_power(struct device *cpu_dev)
+{
+	return -EINVAL;
+}
 #endif
 
 #endif		/* __LINUX_OPP_H__ */
-- 
2.15.1
