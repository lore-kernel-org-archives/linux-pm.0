From: Quentin Perret <quentin.perret@arm.com>
Subject: [PATCH v2 1/2] PM / OPP: introduce an OPP power estimation helper
Date: Tue, 16 Jan 2018 16:51:18 +0000
Message-ID: <20180116165119.15168-2-quentin.perret@arm.com>
References: <20180116165119.15168-1-quentin.perret@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58120 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751097AbeAPQvu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 16 Jan 2018 11:51:50 -0500
In-Reply-To: <20180116165119.15168-1-quentin.perret@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, vireshk@kernel.org, nm@ti.com, sboyd@codeaurora.org, sudeep.holla@arm.com, amit.kachhap@gmail.com, javi.merino@kernel.org, rui.zhang@intel.com, edubezval@gmail.com, matthias.bgg@gmail.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, patrick.bellasi@arm.com, ionela.voinescu@arm.com, joelaf@google.com, tkjos@google.com, Quentin Perret <quentin.perret@arm.com>

The power dissipated by a CPU at a specific OPP is currently estimated by
the thermal subsystem as P = C * V^2 * f, with P the power, C the CPU's
capacitance, V the OPP's voltage and f the OPP's frequency. As this
feature can be useful for other clients requiring energy models of CPUs,
this commit introduces an equivalent power estimator directly into the OPP
library, hence enabling code re-use.

Signed-off-by: Quentin Perret <quentin.perret@arm.com>
---
 drivers/opp/core.c     | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/opp/of.c       | 13 +++++++----
 drivers/opp/opp.h      |  5 ++++
 include/linux/pm_opp.h | 14 +++++++++++
 4 files changed, 91 insertions(+), 4 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 92fa94a6dcc1..ca088b6230ca 100644
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
+	if (IS_ERR_OR_NULL(opp)) {
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
@@ -148,6 +166,29 @@ bool dev_pm_opp_is_turbo(struct dev_pm_opp *opp)
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
+	has_power = opp_table->capacitance;
+
+	dev_pm_opp_put_opp_table(opp_table);
+
+	return has_power;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_has_power);
+
 /**
  * dev_pm_opp_get_max_clock_latency() - Get max clock latency in nanoseconds
  * @dev:	device for which we do this operation
@@ -1112,6 +1153,8 @@ int _opp_add_v1(struct opp_table *opp_table, struct device *dev,
 		goto free_opp;
 	}
 
+	_opp_estimate_power(new_opp);
+
 	/*
 	 * Notify the changes in the availability of the operable
 	 * frequency/voltage list.
@@ -1728,6 +1771,26 @@ static int _opp_set_availability(struct device *dev, unsigned long freq,
 	return r;
 }
 
+/**
+ * _opp_estimate_power() -- helper to estimate power of an OPP
+ * @opp:	OPP for which we want to do this
+ *
+ * Estimate the power of an OPP as P = C * V^2 * f, with C the device's
+ * capacitance, V the OPP's voltage and f the OPP's frequency.
+ */
+void _opp_estimate_power(struct dev_pm_opp *opp)
+{
+	unsigned long capacitance = opp->opp_table->capacitance;
+	unsigned long mV, KHz, uW;
+
+	if (capacitance) {
+		mV = opp->supplies[0].u_volt / 1000;
+		KHz = opp->rate / 1000;
+		uW = capacitance * mV * mV * KHz / 1000000000;
+		opp->power_estimate_uw = uW;
+	}
+}
+
 /**
  * dev_pm_opp_enable() - Enable a specific OPP
  * @dev:	device for which we do this operation
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index cb716aa2f44b..607566c4fc9a 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -55,14 +55,17 @@ void _of_init_opp_table(struct opp_table *opp_table, struct device *dev)
 {
 	struct device_node *np;
 
-	/*
-	 * Only required for backward compatibility with v1 bindings, but isn't
-	 * harmful for other cases. And so we do it unconditionally.
-	 */
 	np = of_node_get(dev->of_node);
 	if (np) {
 		u32 val;
 
+		of_property_read_u32(np, "dynamic-power-coefficient",
+				     &opp_table->capacitance);
+
+		/*
+		 * Required for backward compatibility with v1 bindings, but
+		 * isn't harmful for other cases so we do it unconditionally.
+		 */
 		if (!of_property_read_u32(np, "clock-latency", &val))
 			opp_table->clock_latency_ns_max = val;
 		of_property_read_u32(np, "voltage-tolerance",
@@ -336,6 +339,8 @@ static int _opp_add_static_v2(struct opp_table *opp_table, struct device *dev,
 		goto free_opp;
 	}
 
+	_opp_estimate_power(new_opp);
+
 	/* OPP to select on device suspend */
 	if (of_property_read_bool(np, "opp-suspend")) {
 		if (opp_table->suspend_opp) {
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 4d00061648a3..cb331f9a565b 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -84,6 +84,8 @@ struct dev_pm_opp {
 
 	unsigned long clock_latency_ns;
 
+	unsigned long power_estimate_uw;
+
 	struct opp_table *opp_table;
 
 	struct device_node *np;
@@ -165,6 +167,8 @@ struct opp_table {
 	/* For backward compatibility with v1 bindings */
 	unsigned int voltage_tolerance_v1;
 
+	unsigned int capacitance;
+
 	enum opp_table_access shared_opp;
 	struct dev_pm_opp *suspend_opp;
 
@@ -198,6 +202,7 @@ int _opp_add(struct device *dev, struct dev_pm_opp *new_opp, struct opp_table *o
 int _opp_add_v1(struct opp_table *opp_table, struct device *dev, unsigned long freq, long u_volt, bool dynamic);
 void _dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask, bool of);
 struct opp_table *_add_opp_table(struct device *dev);
+void _opp_estimate_power(struct dev_pm_opp *opp);
 
 #ifdef CONFIG_OF
 void _of_init_opp_table(struct opp_table *opp_table, struct device *dev);
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 6c2d2e88f066..ad50203b7ea9 100644
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
-- 
2.15.1
