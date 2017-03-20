From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V4 5/9] PM / OPP: Add support to parse OPP table for power-domains
Date: Mon, 20 Mar 2017 15:02:17 +0530
Message-ID: <6831fa7061f4eee66b66b2d0eb8763ad6cf86938.1490001099.git.viresh.kumar@linaro.org>
References: <cover.1490001099.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1490001099.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1490001099.git.viresh.kumar@linaro.org>
References: <cover.1490001099.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org, Kevin Hilman <khilman@linaro.org>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, robh+dt@kernel.org, lina.iyer@linaro.org, rnayak@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Power domains can also represent their active states with the help of
OPP tables now and this patch enhances the OPP core to support that.

The OPP nodes are allowed to have the "domain-performance-state"
property, only if the device node contains a "power-domains" or
"#power-domain-cells" property. The OPP nodes aren't allowed to contain
this property partially, i.e. Either all OPP nodes in the OPP table have
the "domain-performance-state" property or none of them have it.

The "opp-hz" property isn't mandatory anymore. It is still required for
non-power-domain devices though. The power-domain devices need the
unique "domain-performance-state" property per OPP node. The OPP core
errors out if these rules aren't obeyed.

The per-OPP debugfs directories are also named based on
domain-performance-state for power-domain devices.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp/core.c    | 163 +++++++++++++++++++++++++++++++++++----
 drivers/base/power/opp/debugfs.c |   9 ++-
 drivers/base/power/opp/of.c      |  80 ++++++++++++++++---
 drivers/base/power/opp/opp.h     |  14 ++++
 4 files changed, 240 insertions(+), 26 deletions(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index dae61720b314..c435acb21a47 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -543,6 +543,63 @@ _generic_set_opp_clk_only(struct device *dev, struct clk *clk,
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
+static int _generic_set_opp_domain(struct device *dev, struct clk *clk,
+				   struct dev_pm_qos_request *req,
+				   unsigned long old_freq, unsigned long freq,
+				   int old_dps, int new_dps)
+{
+	int ret;
+
+	/* Scaling up? Scale voltage before frequency */
+	if (freq > old_freq) {
+		ret = _update_pm_qos_request(dev, req, new_dps);
+		if (ret)
+			return ret;
+	}
+
+	/* Change frequency */
+	ret = _generic_set_opp_clk_only(dev, clk, old_freq, freq);
+	if (ret)
+		goto restore_dps;
+
+	/* Scaling down? Scale voltage after frequency */
+	if (freq < old_freq) {
+		ret = _update_pm_qos_request(dev, req, new_dps);
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
+restore_dps:
+	if (old_dps != -1)
+		_update_pm_qos_request(dev, req, old_dps);
+
+	return ret;
+}
+
 static int _generic_set_opp(struct dev_pm_set_opp_data *data)
 {
 	struct dev_pm_opp_supply *old_supply = data->old_opp.supplies;
@@ -663,6 +720,19 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 
 	regulators = opp_table->regulators;
 
+	/* Has power domains performance states */
+	if (opp_table->has_domain_perf_states) {
+		int old_dps = -1, new_dps;
+		struct dev_pm_qos_request *req = &opp_table->qos_request;
+
+		new_dps = opp->domain_perf_state;
+		if (!IS_ERR(old_opp))
+			old_dps = old_opp->domain_perf_state;
+
+		return _generic_set_opp_domain(dev, clk, req, old_freq, freq,
+					       old_dps, new_dps);
+	}
+
 	/* Only frequency scaling */
 	if (!regulators) {
 		ret = _generic_set_opp_clk_only(dev, clk, old_freq, freq);
@@ -808,6 +878,9 @@ static void _opp_table_kref_release(struct kref *kref)
 	struct opp_table *opp_table = container_of(kref, struct opp_table, kref);
 	struct opp_device *opp_dev;
 
+	if (dev_pm_qos_request_active(&opp_table->qos_request))
+		dev_pm_qos_remove_request(&opp_table->qos_request);
+
 	/* Release clk */
 	if (!IS_ERR(opp_table->clk))
 		clk_put(opp_table->clk);
@@ -950,18 +1023,8 @@ static bool _opp_supported_by_regulators(struct dev_pm_opp *opp,
 	return true;
 }
 
-/*
- * Returns:
- * 0: On success. And appropriate error message for duplicate OPPs.
- * -EBUSY: For OPP with same freq/volt and is available. The callers of
- *  _opp_add() must return 0 if they receive -EBUSY from it. This is to make
- *  sure we don't print error messages unnecessarily if different parts of
- *  kernel try to initialize the OPP table.
- * -EEXIST: For OPP with same freq but different volt or is unavailable. This
- *  should be considered an error by the callers of _opp_add().
- */
-int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
-	     struct opp_table *opp_table)
+struct list_head *_opp_add_freq(struct device *dev, struct dev_pm_opp *new_opp,
+				struct opp_table *opp_table)
 {
 	struct dev_pm_opp *opp;
 	struct list_head *head;
@@ -975,7 +1038,6 @@ int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
 	 * loop, don't replace it with head otherwise it will become an infinite
 	 * loop.
 	 */
-	mutex_lock(&opp_table->lock);
 	head = &opp_table->opp_list;
 
 	list_for_each_entry(opp, &opp_table->opp_list, node) {
@@ -997,8 +1059,81 @@ int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
 		ret = opp->available &&
 		      new_opp->supplies[0].u_volt == opp->supplies[0].u_volt ? -EBUSY : -EEXIST;
 
+		return ERR_PTR(ret);
+	}
+
+	return head;
+}
+
+struct list_head *_opp_add_domain(struct device *dev, struct dev_pm_opp *new_opp,
+				  struct opp_table *opp_table)
+{
+	struct dev_pm_opp *opp;
+	struct list_head *head;
+	int ret;
+
+	/*
+	 * Insert new OPP in order of increasing performance level and discard
+	 * if already present.
+	 *
+	 * Need to use &opp_table->opp_list in the condition part of the 'for'
+	 * loop, don't replace it with head otherwise it will become an infinite
+	 * loop.
+	 */
+	head = &opp_table->opp_list;
+
+	list_for_each_entry(opp, &opp_table->opp_list, node) {
+		if (new_opp->domain_perf_state > opp->domain_perf_state) {
+			head = &opp->node;
+			continue;
+		}
+
+		if (new_opp->domain_perf_state < opp->domain_perf_state)
+			break;
+
+		/* Duplicate OPPs */
+		dev_warn(dev, "%s: duplicate OPPs detected. Existing: DPS: %u, volt: %lu, enabled: %d. New-DPS: %u, volt: %lu, enabled: %d\n",
+			 __func__, opp->domain_perf_state,
+			 opp->supplies[0].u_volt, opp->available,
+			 new_opp->domain_perf_state,
+			 new_opp->supplies[0].u_volt, new_opp->available);
+
+		/* Should we compare voltages for all regulators here ? */
+		ret = opp->available &&
+		      new_opp->supplies[0].u_volt == opp->supplies[0].u_volt ? -EBUSY : -EEXIST;
+
+		return ERR_PTR(ret);
+	}
+
+	return head;
+}
+
+/*
+ * Returns:
+ * 0: On success. And appropriate error message for duplicate OPPs.
+ * -EBUSY: For OPP with same freq/dps and volt and is available. The callers of
+ *  _opp_add() must return 0 if they receive -EBUSY from it. This is to make
+ *  sure we don't print error messages unnecessarily if different parts of
+ *  kernel try to initialize the OPP table.
+ * -EEXIST: For OPP with same freq/dps but different volt or is unavailable.
+ *  This should be considered an error by the callers of _opp_add().
+ */
+int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
+	     struct opp_table *opp_table)
+{
+	struct list_head *head;
+	int ret;
+
+	mutex_lock(&opp_table->lock);
+
+	if (new_opp->rate)
+		head = _opp_add_freq(dev, new_opp, opp_table);
+	else
+		head = _opp_add_domain(dev, new_opp, opp_table);
+
+	if (IS_ERR(head)) {
 		mutex_unlock(&opp_table->lock);
-		return ret;
+		return PTR_ERR(head);
 	}
 
 	list_add(&new_opp->node, head);
diff --git a/drivers/base/power/opp/debugfs.c b/drivers/base/power/opp/debugfs.c
index 95f433db4ac7..779f911fdf38 100644
--- a/drivers/base/power/opp/debugfs.c
+++ b/drivers/base/power/opp/debugfs.c
@@ -81,8 +81,9 @@ int opp_debug_create_one(struct dev_pm_opp *opp, struct opp_table *opp_table)
 	struct dentry *d;
 	char name[25];	/* 20 chars for 64 bit value + 5 (opp:\0) */
 
-	/* Rate is unique to each OPP, use it to give opp-name */
-	snprintf(name, sizeof(name), "opp:%lu", opp->rate);
+	/* Rate and perf-state are unique to each OPP, use them for opp-name */
+	snprintf(name, sizeof(name), "opp:%lu",
+		 opp->rate ? opp->rate : opp->domain_perf_state);
 
 	/* Create per-opp directory */
 	d = debugfs_create_dir(name, pdentry);
@@ -104,6 +105,10 @@ int opp_debug_create_one(struct dev_pm_opp *opp, struct opp_table *opp_table)
 	if (!debugfs_create_ulong("rate_hz", S_IRUGO, d, &opp->rate))
 		return -ENOMEM;
 
+	if (!debugfs_create_u32("power_domain_perf_state", S_IRUGO, d,
+				&opp->domain_perf_state))
+		return -ENOMEM;
+
 	if (!opp_debug_create_supplies(opp, opp_table, d))
 		return -ENOMEM;
 
diff --git a/drivers/base/power/opp/of.c b/drivers/base/power/opp/of.c
index 779428676f63..15c62010e816 100644
--- a/drivers/base/power/opp/of.c
+++ b/drivers/base/power/opp/of.c
@@ -284,24 +284,70 @@ static int _opp_add_static_v2(struct opp_table *opp_table, struct device *dev,
 	if (!new_opp)
 		return -ENOMEM;
 
-	ret = of_property_read_u64(np, "opp-hz", &rate);
-	if (ret < 0) {
-		dev_err(dev, "%s: opp-hz not found\n", __func__);
+	/* Check if the OPP supports hardware's hierarchy of versions or not */
+	if (!_opp_is_supported(dev, opp_table, np)) {
+		dev_dbg(dev, "OPP %s not supported by hardware\n",
+			np->full_name);
+		ret = 0;
 		goto free_opp;
 	}
 
-	/* Check if the OPP supports hardware's hierarchy of versions or not */
-	if (!_opp_is_supported(dev, opp_table, np)) {
-		dev_dbg(dev, "OPP not supported by hardware: %llu\n", rate);
+	ret = of_property_read_u64(np, "opp-hz", &rate);
+	if (!ret) {
+		/*
+		 * Rate is defined as an unsigned long in clk API, and so
+		 * casting explicitly to its type. Must be fixed once rate is 64
+		 * bit guaranteed in clk API.
+		 */
+		new_opp->rate = (unsigned long)rate;
+	} else if (unlikely(!opp_table->is_domain)) {
+		/* All devices except power-domains must have opp-hz */
+		dev_err(dev, "%s: opp-hz not found\n", __func__);
 		goto free_opp;
 	}
 
 	/*
-	 * Rate is defined as an unsigned long in clk API, and so casting
-	 * explicitly to its type. Must be fixed once rate is 64 bit
-	 * guaranteed in clk API.
+	 * Nodes can contain domain-performance-state property only if they are
+	 * power-domains or they have parent power domain. And either all nodes
+	 * must have domain-performance-state property or none.
 	 */
-	new_opp->rate = (unsigned long)rate;
+	if (!of_property_read_u32(np, "domain-performance-state",
+				  &new_opp->domain_perf_state)) {
+		if (unlikely(!(opp_table->has_domain ||
+			       opp_table->is_domain))) {
+			ret = -EINVAL;
+			dev_err(dev, "%s: OPP node can't have domain-performance-state\n",
+				__func__);
+			goto free_opp;
+		}
+
+		if (opp_table->has_domain_perf_states == -1) {
+			opp_table->has_domain_perf_states = 1;
+		} else if (unlikely(!opp_table->has_domain_perf_states)) {
+			ret = -EINVAL;
+			dev_err(dev, "%s: Not all OPP nodes have domain-performance-state\n",
+				__func__);
+			goto free_opp;
+		}
+	} else {
+		/* Power-domains must have this property */
+		if (unlikely(opp_table->is_domain)) {
+			ret = -EINVAL;
+			dev_err(dev, "%s: OPP node doesn't have domain-performance-state property\n",
+				__func__);
+			goto free_opp;
+		}
+
+		if (opp_table->has_domain_perf_states == -1) {
+			opp_table->has_domain_perf_states = 0;
+		} else if (unlikely(opp_table->has_domain_perf_states)) {
+			ret = -EINVAL;
+			dev_err(dev, "%s: Not all OPP nodes have domain-performance-state\n",
+				__func__);
+			goto free_opp;
+		}
+	}
+
 	new_opp->turbo = of_property_read_bool(np, "turbo-mode");
 
 	new_opp->np = np;
@@ -375,6 +421,20 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np)
 	if (!opp_table)
 		return -ENOMEM;
 
+	/*
+	 * Only power domains or devices with parent power-domains can have
+	 * domain-performance states.
+	 */
+	if (of_find_property(dev->of_node, "power-domains", NULL)) {
+		opp_table->has_domain = true;
+		opp_table->has_domain_perf_states = -1;
+	}
+
+	if (of_find_property(dev->of_node, "#power-domain-cells", NULL)) {
+		opp_table->is_domain = true;
+		opp_table->has_domain_perf_states = -1;
+	}
+
 	/* We have opp-table node now, iterate over it and add OPPs */
 	for_each_available_child_of_node(opp_np, np) {
 		count++;
diff --git a/drivers/base/power/opp/opp.h b/drivers/base/power/opp/opp.h
index 166eef990599..1d1e9ea8cda5 100644
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
+ * @domain_perf_state: Performance state of power domain
  * @rate:	Frequency in hertz
  * @supplies:	Power supplies voltage/current values
  * @clock_latency_ns: Latency (in nanoseconds) of switching to this OPP's
@@ -76,6 +78,7 @@ struct dev_pm_opp {
 	bool dynamic;
 	bool turbo;
 	bool suspend;
+	unsigned int domain_perf_state;
 	unsigned long rate;
 
 	struct dev_pm_opp_supply *supplies;
@@ -137,6 +140,12 @@ enum opp_table_access {
  * @regulator_count: Number of power supply regulators
  * @set_opp: Platform specific set_opp callback
  * @set_opp_data: Data to be passed to set_opp callback
+ * @is_domain: True if the device node contains "#power-domain-cells" property
+ * @has_domain: True if the device node contains "power-domain" property
+ * @has_domain_perf_states: Can have value of 0, 1 or -1. -1 means uninitialized
+ * state, 0 means that OPP nodes don't have perf states and 1 means that OPP
+ * nodes have perf states.
+ * @qos_request: Qos request.
  * @dentry:	debugfs dentry pointer of the real device directory (not links).
  * @dentry_name: Name of the real dentry.
  *
@@ -174,6 +183,11 @@ struct opp_table {
 	int (*set_opp)(struct dev_pm_set_opp_data *data);
 	struct dev_pm_set_opp_data *set_opp_data;
 
+	bool is_domain;
+	bool has_domain;
+	int has_domain_perf_states;
+	struct dev_pm_qos_request qos_request;
+
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *dentry;
 	char dentry_name[NAME_MAX];
-- 
2.12.0.432.g71c3a4f4ba37
