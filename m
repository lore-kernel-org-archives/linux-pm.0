From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 04/11] OPP: Parse OPP table's DT properties from _of_init_opp_table()
Date: Wed, 12 Sep 2018 13:58:43 +0530
Message-ID: <9769f7f5b7772f0a96cf830209544cfb491d24f6.1536736872.git.viresh.kumar@linaro.org>
References: <cover.1536736872.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1536736872.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: niklas.cassel@linaro.org, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Parse the DT properties present in the OPP table from
_of_init_opp_table(), which is a dedicated routine for DT parsing.

Minor relocation of helpers is required for this.

It is possible now for _managed_opp() to return a partially initialized
OPP table if the OPP table is created via the helpers like
dev_pm_opp_set_supported_hw() and we need another flag to indicate if
the static OPP are already parsed or not to make sure we don't
incorrectly skip initializing the static OPPs.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/of.c  | 79 ++++++++++++++++++++++++++++-------------------
 drivers/opp/opp.h |  2 ++
 2 files changed, 50 insertions(+), 31 deletions(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index a91857d163b2..ebf467b4d99e 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -23,6 +23,24 @@
 
 #include "opp.h"
 
+/*
+ * Returns opp descriptor node for a device node, caller must
+ * do of_node_put().
+ */
+static struct device_node *_opp_of_get_opp_desc_node(struct device_node *np,
+						     int index)
+{
+	/* "operating-points-v2" can be an array for power domain providers */
+	return of_parse_phandle(np, "operating-points-v2", index);
+}
+
+/* Returns opp descriptor node for a device, caller must do of_node_put() */
+struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device *dev)
+{
+	return _opp_of_get_opp_desc_node(dev->of_node, 0);
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_of_get_opp_desc_node);
+
 static struct opp_table *_managed_opp(const struct device_node *np)
 {
 	struct opp_table *opp_table, *managed_table = NULL;
@@ -55,22 +73,37 @@ static struct opp_table *_managed_opp(const struct device_node *np)
 void _of_init_opp_table(struct opp_table *opp_table, struct device *dev,
 			int index)
 {
-	struct device_node *np;
+	struct device_node *np, *opp_np;
+	u32 val;
 
 	/*
 	 * Only required for backward compatibility with v1 bindings, but isn't
 	 * harmful for other cases. And so we do it unconditionally.
 	 */
 	np = of_node_get(dev->of_node);
-	if (np) {
-		u32 val;
-
-		if (!of_property_read_u32(np, "clock-latency", &val))
-			opp_table->clock_latency_ns_max = val;
-		of_property_read_u32(np, "voltage-tolerance",
-				     &opp_table->voltage_tolerance_v1);
-		of_node_put(np);
-	}
+	if (!np)
+		return;
+
+	if (!of_property_read_u32(np, "clock-latency", &val))
+		opp_table->clock_latency_ns_max = val;
+	of_property_read_u32(np, "voltage-tolerance",
+			     &opp_table->voltage_tolerance_v1);
+
+	/* Get OPP table node */
+	opp_np = _opp_of_get_opp_desc_node(np, index);
+	of_node_put(np);
+
+	if (!opp_np)
+		return;
+
+	if (of_property_read_bool(opp_np, "opp-shared"))
+		opp_table->shared_opp = OPP_TABLE_ACCESS_SHARED;
+	else
+		opp_table->shared_opp = OPP_TABLE_ACCESS_EXCLUSIVE;
+
+	opp_table->np = opp_np;
+
+	of_node_put(opp_np);
 }
 
 static bool _opp_is_supported(struct device *dev, struct opp_table *opp_table,
@@ -250,22 +283,6 @@ void dev_pm_opp_of_remove_table(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_of_remove_table);
 
-/* Returns opp descriptor node for a device node, caller must
- * do of_node_put() */
-static struct device_node *_opp_of_get_opp_desc_node(struct device_node *np,
-						     int index)
-{
-	/* "operating-points-v2" can be an array for power domain providers */
-	return of_parse_phandle(np, "operating-points-v2", index);
-}
-
-/* Returns opp descriptor node for a device, caller must do of_node_put() */
-struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device *dev)
-{
-	return _opp_of_get_opp_desc_node(dev->of_node, 0);
-}
-EXPORT_SYMBOL_GPL(dev_pm_opp_of_get_opp_desc_node);
-
 /**
  * _opp_add_static_v2() - Allocate static OPPs (As per 'v2' DT bindings)
  * @opp_table:	OPP table
@@ -392,6 +409,9 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np,
 		/* OPPs are already managed */
 		if (!_add_opp_dev(dev, opp_table))
 			ret = -ENOMEM;
+		else if (!opp_table->parsed_static_opps)
+			goto initialize_static_opps;
+
 		goto put_opp_table;
 	}
 
@@ -399,6 +419,7 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np,
 	if (!opp_table)
 		return -ENOMEM;
 
+initialize_static_opps:
 	/* We have opp-table node now, iterate over it and add OPPs */
 	for_each_available_child_of_node(opp_np, np) {
 		count++;
@@ -434,11 +455,7 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np,
 	if (pstate_count)
 		opp_table->genpd_performance_state = true;
 
-	opp_table->np = opp_np;
-	if (of_property_read_bool(opp_np, "opp-shared"))
-		opp_table->shared_opp = OPP_TABLE_ACCESS_SHARED;
-	else
-		opp_table->shared_opp = OPP_TABLE_ACCESS_EXCLUSIVE;
+	opp_table->parsed_static_opps = true;
 
 put_opp_table:
 	dev_pm_opp_put_opp_table(opp_table);
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 84aba19531b8..d218fc0a498d 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -129,6 +129,7 @@ enum opp_table_access {
  * @lock:	mutex protecting the opp_list and dev_list.
  * @np:		struct device_node pointer for opp's DT node.
  * @clock_latency_ns_max: Max clock latency in nanoseconds.
+ * @parsed_static_opps: True if OPPs are initialized from DT.
  * @shared_opp: OPP is shared between multiple devices.
  * @suspend_opp: Pointer to OPP to be used during device suspend.
  * @supported_hw: Array of version number to support.
@@ -164,6 +165,7 @@ struct opp_table {
 	/* For backward compatibility with v1 bindings */
 	unsigned int voltage_tolerance_v1;
 
+	bool parsed_static_opps;
 	enum opp_table_access shared_opp;
 	struct dev_pm_opp *suspend_opp;
 
-- 
2.18.0.rc1.242.g61856ae69a2c
