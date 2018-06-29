From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 01/10] OPP: Parse OPP table's DT properties from _of_init_opp_table()
Date: Fri, 29 Jun 2018 11:49:31 +0530
Message-ID: <415e586b2dedcc6f97ee07a76bd54124c4b7e8bb.1530252803.git.viresh.kumar@linaro.org>
References: <cover.1530252803.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1530252803.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Parse the DT properties present in the OPP table from
_of_init_opp_table(), which is a dedicated routine of DT parsing.

Minor relocation of helpers was required for this.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/of.c | 77 +++++++++++++++++++++++++++++-------------------
 1 file changed, 47 insertions(+), 30 deletions(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 7af0ddec936b..44a6b81fd228 100644
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
@@ -54,22 +72,35 @@ static struct opp_table *_managed_opp(const struct device_node *np)
 
 void _of_init_opp_table(struct opp_table *opp_table, struct device *dev)
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
+	opp_np = _opp_of_get_opp_desc_node(np, 0);
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
+	of_node_put(opp_np);
 }
 
 static bool _opp_is_supported(struct device *dev, struct opp_table *opp_table,
@@ -249,22 +280,6 @@ void dev_pm_opp_of_remove_table(struct device *dev)
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
@@ -431,11 +446,13 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np)
 	if (pstate_count)
 		opp_table->genpd_performance_state = true;
 
+	/*
+	 * This is used by _managed_opp() to find OPP tables that are fully
+	 * initialized by other devices sharing clock/voltage rails with current
+	 * device. And so we can't set this from _of_init_opp_table() as tables
+	 * aren't fully initialized at that point.
+	 */
 	opp_table->np = opp_np;
-	if (of_property_read_bool(opp_np, "opp-shared"))
-		opp_table->shared_opp = OPP_TABLE_ACCESS_SHARED;
-	else
-		opp_table->shared_opp = OPP_TABLE_ACCESS_EXCLUSIVE;
 
 put_opp_table:
 	dev_pm_opp_put_opp_table(opp_table);
-- 
2.18.0.rc1.242.g61856ae69a2c
