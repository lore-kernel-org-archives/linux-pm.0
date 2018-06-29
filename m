From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 04/10] OPP: Populate required opp tables from "required-opps" property
Date: Fri, 29 Jun 2018 11:49:34 +0530
Message-ID: <e141629140b648d3fc4d2f685a3daf947447172d.1530252803.git.viresh.kumar@linaro.org>
References: <cover.1530252803.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1530252803.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The current implementation works only for the case where a single
phandle is present in the "required-opps" property, while DT allows
multiple phandles to be present there.

This patch adds new infrastructure to parse all the phandles present in
"required-opps" property and save pointers of the required OPP's OPP
tables. These will be used by later commits.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c |   2 +
 drivers/opp/of.c   | 138 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/opp/opp.h  |   8 +++
 3 files changed, 148 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index c0c657fdbf33..22c927c5e4ea 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -863,6 +863,8 @@ static void _opp_table_kref_release(struct kref *kref)
 	struct opp_table *opp_table = container_of(kref, struct opp_table, kref);
 	struct opp_device *opp_dev;
 
+	_of_clear_opp_table(opp_table);
+
 	/* Release clk */
 	if (!IS_ERR(opp_table->clk))
 		clk_put(opp_table->clk);
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 218b8997d817..b639195a1e3d 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -70,6 +70,138 @@ static struct opp_table *_managed_opp(const struct device_node *np)
 	return managed_table;
 }
 
+static struct device_node *of_parse_required_opp(struct device_node *np,
+						 int index)
+{
+	struct device_node *required_np;
+
+	required_np = of_parse_phandle(np, "required-opps", index);
+	if (unlikely(!required_np)) {
+		pr_err("%s: Unable to parse required-opps: %pOF, index: %d\n",
+		       __func__, np, index);
+	}
+
+	return required_np;
+}
+
+/* The caller must call dev_pm_opp_put_opp_table() after the table is used */
+static struct opp_table *_get_required_opp_table(struct device_node *np)
+{
+	struct opp_table *opp_table, *required_opp_table = NULL;
+	struct dev_pm_opp *opp;
+
+	lockdep_assert_held(&opp_table_lock);
+
+	list_for_each_entry(opp_table, &opp_tables, node) {
+		mutex_lock(&opp_table->lock);
+
+		list_for_each_entry(opp, &opp_table->opp_list, node) {
+			if (opp->np == np) {
+				/* Found required OPP table */
+				if (opp_table->is_genpd) {
+					required_opp_table = opp_table;
+					break;
+				}
+
+				/*
+				 * We only support OPP of genpd's in the
+				 * "required-opps" for now, as we don't know how
+				 * to do DVFS for any other use cases. Error out
+				 * if the required OPP doesn't belong to a
+				 * genpd.
+				 */
+				pr_err("%s: required-opp doesn't belong to genpd: %pOF\n",
+				       __func__, opp->np);
+				break;
+			}
+		}
+
+		mutex_unlock(&opp_table->lock);
+
+		if (!required_opp_table)
+			continue;
+
+		_get_opp_table_kref(required_opp_table);
+
+		return required_opp_table;
+	}
+
+	return ERR_PTR(-ENODEV);
+}
+
+/* Free resources previously acquired by _opp_table_alloc_required_tables() */
+static void _opp_table_free_required_tables(struct opp_table *opp_table)
+{
+	struct opp_table **required_opp_tables = opp_table->required_opp_tables;
+	int i;
+
+	if (!required_opp_tables)
+		return;
+
+	for (i = 0; i < opp_table->required_opp_count; i++) {
+		if (IS_ERR_OR_NULL(required_opp_tables[i]))
+			break;
+
+		dev_pm_opp_put_opp_table(required_opp_tables[i]);
+	}
+
+	kfree(required_opp_tables);
+
+	opp_table->required_opp_count = 0;
+	opp_table->required_opp_tables = NULL;
+}
+
+/*
+ * Populate all devices and opp tables which are part of "required-opps" list.
+ * Checking only the first OPP node should be enough.
+ */
+static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
+					     struct device *dev,
+					     struct device_node *opp_np)
+{
+	struct opp_table **required_opp_tables;
+	struct device_node *required_np, *np;
+	int count, i;
+
+	/* Traversing the first OPP node is all we need */
+	np = of_get_next_available_child(opp_np, NULL);
+	if (!np) {
+		dev_err(dev, "Empty OPP table\n");
+		return;
+	}
+
+	count = of_count_phandle_with_args(np, "required-opps", NULL);
+	if (!count)
+		goto put_np;
+
+	required_opp_tables = kcalloc(count, sizeof(*required_opp_tables),
+				      GFP_KERNEL);
+	if (!required_opp_tables)
+		goto put_np;
+
+	opp_table->required_opp_tables = required_opp_tables;
+	opp_table->required_opp_count = count;
+
+	for (i = 0; i < count; i++) {
+		required_np = of_parse_required_opp(np, i);
+		if (!required_np)
+			goto free_required_tables;
+
+		required_opp_tables[i] = _get_required_opp_table(required_np);
+		of_node_put(required_np);
+
+		if (IS_ERR(required_opp_tables[i]))
+			goto free_required_tables;
+	}
+
+	goto put_np;
+
+free_required_tables:
+	_opp_table_free_required_tables(opp_table);
+put_np:
+	of_node_put(np);
+}
+
 void _of_init_opp_table(struct opp_table *opp_table, struct device *dev)
 {
 	struct device_node *np, *opp_np;
@@ -103,9 +235,15 @@ void _of_init_opp_table(struct opp_table *opp_table, struct device *dev)
 	else
 		opp_table->shared_opp = OPP_TABLE_ACCESS_EXCLUSIVE;
 
+	_opp_table_alloc_required_tables(opp_table, dev, opp_np);
 	of_node_put(opp_np);
 }
 
+void _of_clear_opp_table(struct opp_table *opp_table)
+{
+	_opp_table_free_required_tables(opp_table);
+}
+
 static bool _opp_is_supported(struct device *dev, struct opp_table *opp_table,
 			      struct device_node *np)
 {
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 3cd3b7b167b5..fea70c71cc99 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -131,6 +131,9 @@ enum opp_table_access {
  * @clock_latency_ns_max: Max clock latency in nanoseconds.
  * @shared_opp: OPP is shared between multiple devices.
  * @suspend_opp: Pointer to OPP to be used during device suspend.
+ * @required_opp_tables: List of device OPP tables that are required by OPPs in
+ *		this table.
+ * @required_opp_count: Number of required devices.
  * @supported_hw: Array of version number to support.
  * @supported_hw_count: Number of elements in supported_hw array.
  * @prop_name: A name to postfix to many DT properties, while parsing them.
@@ -168,6 +171,9 @@ struct opp_table {
 	enum opp_table_access shared_opp;
 	struct dev_pm_opp *suspend_opp;
 
+	struct opp_table **required_opp_tables;
+	unsigned int required_opp_count;
+
 	unsigned int *supported_hw;
 	unsigned int supported_hw_count;
 	const char *prop_name;
@@ -203,8 +209,10 @@ struct opp_table *_add_opp_table(struct device *dev);
 
 #ifdef CONFIG_OF
 void _of_init_opp_table(struct opp_table *opp_table, struct device *dev);
+void _of_clear_opp_table(struct opp_table *opp_table);
 #else
 static inline void _of_init_opp_table(struct opp_table *opp_table, struct device *dev) {}
+static inline void _of_clear_opp_table(struct opp_table *opp_table) {}
 #endif
 
 #ifdef CONFIG_DEBUG_FS
-- 
2.18.0.rc1.242.g61856ae69a2c
