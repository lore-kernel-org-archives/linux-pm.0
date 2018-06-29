From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 05/10] OPP: Populate OPPs from "required-opps" property
Date: Fri, 29 Jun 2018 11:49:35 +0530
Message-ID: <ba61fa8806c61a3408caed3074890371a07acb03.1530252803.git.viresh.kumar@linaro.org>
References: <cover.1530252803.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1530252803.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

An earlier commit populated the OPP tables from the "required-opps"
property, this commit populates the individual OPPs. This is repeated
for each OPP in the OPP table and these populated OPPs will be used by
later commits.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c |  1 +
 drivers/opp/of.c   | 93 +++++++++++++++++++++++++++++++++++++++++++++-
 drivers/opp/opp.h  |  6 +++
 3 files changed, 98 insertions(+), 2 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 22c927c5e4ea..acc34c238fd6 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -906,6 +906,7 @@ static void _opp_kref_release(struct kref *kref)
 	 * frequency/voltage list.
 	 */
 	blocking_notifier_call_chain(&opp_table->head, OPP_EVENT_REMOVE, opp);
+	_of_opp_free_required_opps(opp_table, opp);
 	opp_debug_remove_one(opp);
 	list_del(&opp->node);
 	kfree(opp);
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index b639195a1e3d..ffefccfdbc26 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -244,6 +244,89 @@ void _of_clear_opp_table(struct opp_table *opp_table)
 	_opp_table_free_required_tables(opp_table);
 }
 
+/*
+ * Release all resources previously acquired with a call to
+ * _of_opp_alloc_required_opps().
+ */
+void _of_opp_free_required_opps(struct opp_table *opp_table,
+				struct dev_pm_opp *opp)
+{
+	struct dev_pm_opp **required_opps = opp->required_opps;
+	int i, count = opp_table->required_opp_count;
+
+	if (!count)
+		return;
+
+	for (i = 0; i < count; i++) {
+		if (!required_opps[i])
+			break;
+
+		/* Put the reference back */
+		dev_pm_opp_put(required_opps[i]);
+	}
+
+	kfree(required_opps);
+	opp->required_opps = NULL;
+}
+
+/* Populate all required OPPs which are part of "required-opps" list */
+static int _of_opp_alloc_required_opps(struct opp_table *opp_table,
+				       struct dev_pm_opp *opp)
+{
+	struct dev_pm_opp *temp_opp, **required_opps;
+	struct opp_table *temp_table;
+	struct device_node *np;
+	int i, ret, count = opp_table->required_opp_count;
+
+	if (!count)
+		return 0;
+
+	required_opps = kcalloc(count, sizeof(*required_opps), GFP_KERNEL);
+	if (!required_opps)
+		return -ENOMEM;
+
+	opp->required_opps = required_opps;
+
+	for (i = 0; i < count; i++) {
+		temp_table = opp_table->required_opp_tables[i];
+
+		np = of_parse_phandle(opp->np, "required-opps", i);
+		if (unlikely(!np)) {
+			pr_err("%s: Unable to parse required-opps: %pOF (%d)\n",
+			       __func__, opp->np, i);
+			ret = -ENODEV;
+			goto free_required_opps;
+		}
+
+		mutex_lock(&temp_table->lock);
+
+		list_for_each_entry(temp_opp, &temp_table->opp_list, node) {
+			if (temp_opp->np == np) {
+				/* Take a reference to the OPP */
+				dev_pm_opp_get(temp_opp);
+				required_opps[i] = temp_opp;
+				break;
+			}
+		}
+
+		mutex_unlock(&temp_table->lock);
+
+		if (!required_opps[i]) {
+			pr_err("%s: Unable to find required OPP node: %pOF (%d)\n",
+			       __func__, opp->np, i);
+			ret = -ENODEV;
+			goto free_required_opps;
+		}
+	}
+
+	return 0;
+
+free_required_opps:
+	_of_opp_free_required_opps(opp_table, opp);
+
+	return ret;
+}
+
 static bool _opp_is_supported(struct device *dev, struct opp_table *opp_table,
 			      struct device_node *np)
 {
@@ -482,6 +565,10 @@ static int _opp_add_static_v2(struct opp_table *opp_table, struct device *dev,
 	new_opp->dynamic = false;
 	new_opp->available = true;
 
+	ret = _of_opp_alloc_required_opps(opp_table, new_opp);
+	if (ret)
+		goto free_opp;
+
 	if (!of_property_read_u32(np, "clock-latency-ns", &val))
 		new_opp->clock_latency_ns = val;
 
@@ -489,14 +576,14 @@ static int _opp_add_static_v2(struct opp_table *opp_table, struct device *dev,
 
 	ret = opp_parse_supplies(new_opp, dev, opp_table);
 	if (ret)
-		goto free_opp;
+		goto free_required_opps;
 
 	ret = _opp_add(dev, new_opp, opp_table, rate_not_available);
 	if (ret) {
 		/* Don't return error for duplicate OPPs */
 		if (ret == -EBUSY)
 			ret = 0;
-		goto free_opp;
+		goto free_required_opps;
 	}
 
 	/* OPP to select on device suspend */
@@ -526,6 +613,8 @@ static int _opp_add_static_v2(struct opp_table *opp_table, struct device *dev,
 	blocking_notifier_call_chain(&opp_table->head, OPP_EVENT_ADD, new_opp);
 	return 0;
 
+free_required_opps:
+	_of_opp_free_required_opps(opp_table, new_opp);
 free_opp:
 	_opp_free(new_opp);
 
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index fea70c71cc99..9efdc3e4840c 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -63,6 +63,7 @@ extern struct list_head opp_tables;
  * @supplies:	Power supplies voltage/current values
  * @clock_latency_ns: Latency (in nanoseconds) of switching to this OPP's
  *		frequency from any other OPP's frequency.
+ * @required_opps: List of OPPs that are required by this OPP.
  * @opp_table:	points back to the opp_table struct this opp belongs to
  * @np:		OPP's device node.
  * @dentry:	debugfs dentry pointer (per opp)
@@ -84,6 +85,7 @@ struct dev_pm_opp {
 
 	unsigned long clock_latency_ns;
 
+	struct dev_pm_opp **required_opps;
 	struct opp_table *opp_table;
 
 	struct device_node *np;
@@ -210,9 +212,13 @@ struct opp_table *_add_opp_table(struct device *dev);
 #ifdef CONFIG_OF
 void _of_init_opp_table(struct opp_table *opp_table, struct device *dev);
 void _of_clear_opp_table(struct opp_table *opp_table);
+void _of_opp_free_required_opps(struct opp_table *opp_table,
+				struct dev_pm_opp *opp);
 #else
 static inline void _of_init_opp_table(struct opp_table *opp_table, struct device *dev) {}
 static inline void _of_clear_opp_table(struct opp_table *opp_table) {}
+static inline void _of_opp_free_required_opps(struct opp_table *opp_table,
+					      struct dev_pm_opp *opp) {}
 #endif
 
 #ifdef CONFIG_DEBUG_FS
-- 
2.18.0.rc1.242.g61856ae69a2c
