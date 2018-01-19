From: Quentin Perret <quentin.perret@arm.com>
Subject: [PATCH v3 1/2] PM / OPP: introduce an OPP power estimation helper
Date: Fri, 19 Jan 2018 09:45:48 +0000
Message-ID: <20180119094549.5468-2-quentin.perret@arm.com>
References: <20180119094549.5468-1-quentin.perret@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36536 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752519AbeASJqF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 19 Jan 2018 04:46:05 -0500
In-Reply-To: <20180119094549.5468-1-quentin.perret@arm.com>
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
 drivers/opp/core.c     | 32 ++++++++++++++++++++++++++++++++
 drivers/opp/of.c       | 11 +++++++----
 drivers/opp/opp.h      |  7 +++++++
 include/linux/pm_opp.h |  7 +++++++
 4 files changed, 53 insertions(+), 4 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 92fa94a6dcc1..81bf18554b34 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -127,6 +127,24 @@ unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_freq);
 
+/**
+ * dev_pm_opp_get_power() - Gets the estimated power corresponding to an opp
+ * @opp:	opp for which power has to be returned for
+ *
+ * Return: estimated power in micro-watts corresponding to the opp, else
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
@@ -985,6 +1003,18 @@ static bool _opp_supported_by_regulators(struct dev_pm_opp *opp,
 	return true;
 }
 
+/**
+ * Estimate the power of an OPP as P = C * V^2 * f, with C the device's
+ * capacitance, V the OPP's voltage and f the OPP's frequency.
+ */
+static void _opp_estimate_power(struct dev_pm_opp *opp, unsigned long cap)
+{
+	unsigned long mV = opp->supplies[0].u_volt / 1000;
+	unsigned long KHz = opp->rate / 1000;
+
+	opp->power_estimate_uw = cap * mV * mV * KHz / 1000000000;
+}
+
 /*
  * Returns:
  * 0: On success. And appropriate error message for duplicate OPPs.
@@ -1039,6 +1069,8 @@ int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
 	if (opp_table->get_pstate)
 		new_opp->pstate = opp_table->get_pstate(dev, new_opp->rate);
 
+	_opp_estimate_power(new_opp, opp_table->capacitance);
+
 	list_add(&new_opp->node, head);
 	mutex_unlock(&opp_table->lock);
 
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index cb716aa2f44b..d28d9dbb5272 100644
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
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 4d00061648a3..8815b51dd117 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -63,6 +63,8 @@ extern struct list_head opp_tables;
  * @supplies:	Power supplies voltage/current values
  * @clock_latency_ns: Latency (in nanoseconds) of switching to this OPP's
  *		frequency from any other OPP's frequency.
+ * @power_estimate_uw: Estimation of the power (in micro-watts) dissipated by
+ *		the device at this OPP.
  * @opp_table:	points back to the opp_table struct this opp belongs to
  * @np:		OPP's device node.
  * @dentry:	debugfs dentry pointer (per opp)
@@ -84,6 +86,8 @@ struct dev_pm_opp {
 
 	unsigned long clock_latency_ns;
 
+	unsigned long power_estimate_uw;
+
 	struct opp_table *opp_table;
 
 	struct device_node *np;
@@ -129,6 +133,7 @@ enum opp_table_access {
  * @lock:	mutex protecting the opp_list.
  * @np:		struct device_node pointer for opp's DT node.
  * @clock_latency_ns_max: Max clock latency in nanoseconds.
+ * @capacitance: Device's capacitance, used to estimate its power.
  * @shared_opp: OPP is shared between multiple devices.
  * @suspend_opp: Pointer to OPP to be used during device suspend.
  * @supported_hw: Array of version number to support.
@@ -165,6 +170,8 @@ struct opp_table {
 	/* For backward compatibility with v1 bindings */
 	unsigned int voltage_tolerance_v1;
 
+	unsigned int capacitance;
+
 	enum opp_table_access shared_opp;
 	struct dev_pm_opp *suspend_opp;
 
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 6c2d2e88f066..8c73d8b61726 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -85,6 +85,8 @@ unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp);
 
 unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp);
 
+unsigned long dev_pm_opp_get_power(struct dev_pm_opp *opp);
+
 bool dev_pm_opp_is_turbo(struct dev_pm_opp *opp);
 
 int dev_pm_opp_get_opp_count(struct device *dev);
@@ -150,6 +152,11 @@ static inline unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp)
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
-- 
2.15.1
