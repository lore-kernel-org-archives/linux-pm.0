From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 7/7] PM / OPP: Add support to parse domain-performance-state
Date: Fri, 24 Feb 2017 14:36:39 +0530
Message-ID: <d6a703e223e812fe30f3a24ce792d4abfc7d47dc.1487926924.git.viresh.kumar@linaro.org>
References: <cover.1487926924.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:36491 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751356AbdBXJQR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Feb 2017 04:16:17 -0500
Received: by mail-pf0-f177.google.com with SMTP id c193so1827341pfb.3
        for <linux-pm@vger.kernel.org>; Fri, 24 Feb 2017 01:16:17 -0800 (PST)
In-Reply-To: <cover.1487926924.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1487926924.git.viresh.kumar@linaro.org>
References: <cover.1487926924.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org, Kevin Hilman <khilman@linaro.org>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, robh+dt@kernel.org, lina.iyer@linaro.org, rnayak@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

This patch allows the OPP core to parse the "domain-performance-state"
property in the OPP nodes. The nodes are allowed to have the
"domain-performance-state" property, only if the device node contains a
"power-domains" property. The OPP nodes aren't allowed to contain the
property partially, i.e. Either all OPP nodes in the OPP table have the
"domain-performance-state" property or none of them have it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Tested-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 drivers/base/power/opp/core.c    | 73 ++++++++++++++++++++++++++++++++++++++++
 drivers/base/power/opp/debugfs.c |  4 +++
 drivers/base/power/opp/of.c      | 37 ++++++++++++++++++++
 drivers/base/power/opp/opp.h     | 12 +++++++
 4 files changed, 126 insertions(+)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index 91ec3232d630..211551f377e9 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -542,6 +542,63 @@ _generic_set_opp_clk_only(struct device *dev, struct clk *clk,
 	return ret;
 }
 
+static int _update_pm_qos_request(struct device *dev,
+				  struct dev_pm_qos_request *req,
+				  unsigned int perf)
+{
+	int ret;
+
+	if (likely(dev_pm_qos_request_active(req)))
+		ret = dev_pm_qos_update_request(req, perf);
+	else
+		ret = dev_pm_qos_add_request(dev, req, DEV_PM_QOS_PERFORMANCE,
+					     perf);
+
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int _generic_set_opp_pd(struct device *dev, struct clk *clk,
+			       struct dev_pm_qos_request *req,
+			       unsigned long old_freq, unsigned long freq,
+			       unsigned int old_perf, unsigned int new_perf)
+{
+	int ret;
+
+	/* Scaling up? Scale voltage before frequency */
+	if (freq > old_freq) {
+		ret = _update_pm_qos_request(dev, req, new_perf);
+		if (ret)
+			return ret;
+	}
+
+	/* Change frequency */
+	ret = _generic_set_opp_clk_only(dev, clk, old_freq, freq);
+	if (ret)
+		goto restore_perf;
+
+	/* Scaling down? Scale voltage after frequency */
+	if (freq < old_freq) {
+		ret = _update_pm_qos_request(dev, req, new_perf);
+		if (ret)
+			goto restore_freq;
+	}
+
+	return 0;
+
+restore_freq:
+	if (_generic_set_opp_clk_only(dev, clk, freq, old_freq))
+		dev_err(dev, "%s: failed to restore old-freq (%lu Hz)\n",
+			__func__, old_freq);
+restore_perf:
+	if (old_perf)
+		_update_pm_qos_request(dev, req, old_perf);
+
+	return ret;
+}
+
 static int _generic_set_opp(struct dev_pm_set_opp_data *data)
 {
 	struct dev_pm_opp_supply *old_supply = data->old_opp.supplies;
@@ -662,6 +719,19 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 
 	regulators = opp_table->regulators;
 
+	/* Has power domains performance states */
+	if (opp_table->has_pd_perf_states) {
+		unsigned int old_perf = 0, new_perf;
+		struct dev_pm_qos_request *req = &opp_table->qos_request;
+
+		new_perf = opp->pd_perf_state;
+		if (!IS_ERR(old_opp))
+			old_perf = old_opp->pd_perf_state;
+
+		return _generic_set_opp_pd(dev, clk, req, old_freq, freq,
+					   old_perf, new_perf);
+	}
+
 	/* Only frequency scaling */
 	if (!regulators) {
 		ret = _generic_set_opp_clk_only(dev, clk, old_freq, freq);
@@ -807,6 +877,9 @@ static void _opp_table_kref_release(struct kref *kref)
 	struct opp_table *opp_table = container_of(kref, struct opp_table, kref);
 	struct opp_device *opp_dev;
 
+	if (dev_pm_qos_request_active(&opp_table->qos_request))
+		dev_pm_qos_remove_request(&opp_table->qos_request);
+
 	/* Release clk */
 	if (!IS_ERR(opp_table->clk))
 		clk_put(opp_table->clk);
diff --git a/drivers/base/power/opp/debugfs.c b/drivers/base/power/opp/debugfs.c
index 95f433db4ac7..264958ab3de9 100644
--- a/drivers/base/power/opp/debugfs.c
+++ b/drivers/base/power/opp/debugfs.c
@@ -104,6 +104,10 @@ int opp_debug_create_one(struct dev_pm_opp *opp, struct opp_table *opp_table)
 	if (!debugfs_create_ulong("rate_hz", S_IRUGO, d, &opp->rate))
 		return -ENOMEM;
 
+	if (!debugfs_create_u32("power_domain_perf_state", S_IRUGO, d,
+				&opp->pd_perf_state))
+		return -ENOMEM;
+
 	if (!opp_debug_create_supplies(opp, opp_table, d))
 		return -ENOMEM;
 
diff --git a/drivers/base/power/opp/of.c b/drivers/base/power/opp/of.c
index 779428676f63..e3b5f10e7f25 100644
--- a/drivers/base/power/opp/of.c
+++ b/drivers/base/power/opp/of.c
@@ -311,6 +311,38 @@ static int _opp_add_static_v2(struct opp_table *opp_table, struct device *dev,
 	if (!of_property_read_u32(np, "clock-latency-ns", &val))
 		new_opp->clock_latency_ns = val;
 
+	/*
+	 * Make sure that all information is present around domain power states
+	 * and nothing is left out.
+	 */
+	if (!of_property_read_u32(np, "domain-performance-state",
+				  &new_opp->pd_perf_state)) {
+		if (!opp_table->has_pd) {
+			ret = -EINVAL;
+			dev_err(dev, "%s: OPP node can't have performance state as device doesn't have power-domain\n",
+				__func__);
+			goto free_opp;
+		}
+
+		if (opp_table->has_pd_perf_states == -1) {
+			opp_table->has_pd_perf_states = 1;
+		} else if (!opp_table->has_pd_perf_states) {
+			ret = -EINVAL;
+			dev_err(dev, "%s: Not all OPP nodes have performance state\n",
+				__func__);
+			goto free_opp;
+		}
+	} else {
+		if (opp_table->has_pd_perf_states == -1) {
+			opp_table->has_pd_perf_states = 0;
+		} else if (opp_table->has_pd_perf_states) {
+			ret = -EINVAL;
+			dev_err(dev, "%s: Not all OPP nodes have performance state\n",
+				__func__);
+			goto free_opp;
+		}
+	}
+
 	ret = opp_parse_supplies(new_opp, dev, opp_table);
 	if (ret)
 		goto free_opp;
@@ -375,6 +407,11 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np)
 	if (!opp_table)
 		return -ENOMEM;
 
+	if (of_find_property(dev->of_node, "power-domains", NULL)) {
+		opp_table->has_pd = true;
+		opp_table->has_pd_perf_states = -1;
+	}
+
 	/* We have opp-table node now, iterate over it and add OPPs */
 	for_each_available_child_of_node(opp_np, np) {
 		count++;
diff --git a/drivers/base/power/opp/opp.h b/drivers/base/power/opp/opp.h
index 166eef990599..41a2c0a67031 100644
--- a/drivers/base/power/opp/opp.h
+++ b/drivers/base/power/opp/opp.h
@@ -20,6 +20,7 @@
 #include <linux/list.h>
 #include <linux/limits.h>
 #include <linux/pm_opp.h>
+#include <linux/pm_qos.h>
 #include <linux/notifier.h>
 
 struct clk;
@@ -58,6 +59,7 @@ extern struct list_head opp_tables;
  * @dynamic:	not-created from static DT entries.
  * @turbo:	true if turbo (boost) OPP
  * @suspend:	true if suspend OPP
+ * @pd_perf_state: Performance state of power domain
  * @rate:	Frequency in hertz
  * @supplies:	Power supplies voltage/current values
  * @clock_latency_ns: Latency (in nanoseconds) of switching to this OPP's
@@ -76,6 +78,7 @@ struct dev_pm_opp {
 	bool dynamic;
 	bool turbo;
 	bool suspend;
+	unsigned int pd_perf_state;
 	unsigned long rate;
 
 	struct dev_pm_opp_supply *supplies;
@@ -137,6 +140,11 @@ enum opp_table_access {
  * @regulator_count: Number of power supply regulators
  * @set_opp: Platform specific set_opp callback
  * @set_opp_data: Data to be passed to set_opp callback
+ * @has_pd: True if the device node contains power-domain property
+ * @has_pd_perf_states: Can have value of 0, 1 or -1. -1 means uninitialized
+ * state, 0 means that OPP nodes don't have perf states and 1 means that OPP
+ * nodes have perf states.
+ * @qos_request: Qos request.
  * @dentry:	debugfs dentry pointer of the real device directory (not links).
  * @dentry_name: Name of the real dentry.
  *
@@ -174,6 +182,10 @@ struct opp_table {
 	int (*set_opp)(struct dev_pm_set_opp_data *data);
 	struct dev_pm_set_opp_data *set_opp_data;
 
+	bool has_pd;
+	int has_pd_perf_states;
+	struct dev_pm_qos_request qos_request;
+
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *dentry;
 	char dentry_name[NAME_MAX];
-- 
2.7.1.410.g6faf27b
