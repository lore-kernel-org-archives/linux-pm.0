From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 12/12] OPP: Pass OPP table to _of_add_opp_table_v{1|2}()
Date: Wed, 19 Sep 2018 15:20:31 -0700
Message-ID: <9ea47a1cc5f08797e6c854c234acbe269b98405a.1537394233.git.viresh.kumar@linaro.org>
References: <cover.1537394233.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1537394233.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1537394233.git.viresh.kumar@linaro.org>
References: <cover.1537394233.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Niklas Cassel <niklas.cassel@linaro.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Both _of_add_opp_table_v1() and _of_add_opp_table_v2() contain similar
code to get the OPP table and their parent routine also parses the DT to
find the OPP table's node pointer. This can be simplified by getting the
OPP table in advance and then passing it as argument to these routines.

Tested-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/of.c | 68 +++++++++++++++++++++++---------------------------------
 1 file changed, 28 insertions(+), 40 deletions(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 1ddef52c27fd..a71ff3acca0f 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -399,18 +399,12 @@ static int _opp_add_static_v2(struct opp_table *opp_table, struct device *dev,
 }
 
 /* Initializes OPP tables based on new bindings */
-static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np,
-				int index)
+static int _of_add_opp_table_v2(struct device *dev, struct opp_table *opp_table)
 {
 	struct device_node *np;
-	struct opp_table *opp_table;
 	int ret, count = 0, pstate_count = 0;
 	struct dev_pm_opp *opp;
 
-	opp_table = dev_pm_opp_get_opp_table_indexed(dev, index);
-	if (!opp_table)
-		return -ENOMEM;
-
 	/* OPP table is already initialized for the device */
 	if (opp_table->parsed_static_opps) {
 		kref_get(&opp_table->list_kref);
@@ -420,7 +414,7 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np,
 	kref_init(&opp_table->list_kref);
 
 	/* We have opp-table node now, iterate over it and add OPPs */
-	for_each_available_child_of_node(opp_np, np) {
+	for_each_available_child_of_node(opp_table->np, np) {
 		count++;
 
 		ret = _opp_add_static_v2(opp_table, dev, np);
@@ -458,15 +452,13 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np,
 
 put_list_kref:
 	_put_opp_list_kref(opp_table);
-	dev_pm_opp_put_opp_table(opp_table);
 
 	return ret;
 }
 
 /* Initializes OPP tables based on old-deprecated bindings */
-static int _of_add_opp_table_v1(struct device *dev)
+static int _of_add_opp_table_v1(struct device *dev, struct opp_table *opp_table)
 {
-	struct opp_table *opp_table;
 	const struct property *prop;
 	const __be32 *val;
 	int nr, ret = 0;
@@ -487,10 +479,6 @@ static int _of_add_opp_table_v1(struct device *dev)
 		return -EINVAL;
 	}
 
-	opp_table = dev_pm_opp_get_opp_table(dev);
-	if (!opp_table)
-		return -ENOMEM;
-
 	kref_init(&opp_table->list_kref);
 
 	val = prop->value;
@@ -503,7 +491,6 @@ static int _of_add_opp_table_v1(struct device *dev)
 			dev_err(dev, "%s: Failed to add OPP %ld (%d)\n",
 				__func__, freq, ret);
 			_put_opp_list_kref(opp_table);
-			dev_pm_opp_put_opp_table(opp_table);
 			return ret;
 		}
 		nr -= 2;
@@ -531,24 +518,24 @@ static int _of_add_opp_table_v1(struct device *dev)
  */
 int dev_pm_opp_of_add_table(struct device *dev)
 {
-	struct device_node *opp_np;
+	struct opp_table *opp_table;
 	int ret;
 
+	opp_table = dev_pm_opp_get_opp_table_indexed(dev, 0);
+	if (!opp_table)
+		return -ENOMEM;
+
 	/*
-	 * OPPs have two version of bindings now. The older one is deprecated,
-	 * try for the new binding first.
+	 * OPPs have two version of bindings now. Also try the old (v1)
+	 * bindings for backward compatibility with older dtbs.
 	 */
-	opp_np = dev_pm_opp_of_get_opp_desc_node(dev);
-	if (!opp_np) {
-		/*
-		 * Try old-deprecated bindings for backward compatibility with
-		 * older dtbs.
-		 */
-		return _of_add_opp_table_v1(dev);
-	}
+	if (opp_table->np)
+		ret = _of_add_opp_table_v2(dev, opp_table);
+	else
+		ret = _of_add_opp_table_v1(dev, opp_table);
 
-	ret = _of_add_opp_table_v2(dev, opp_np, 0);
-	of_node_put(opp_np);
+	if (ret)
+		dev_pm_opp_put_opp_table(opp_table);
 
 	return ret;
 }
@@ -575,28 +562,29 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_of_add_table);
  */
 int dev_pm_opp_of_add_table_indexed(struct device *dev, int index)
 {
-	struct device_node *opp_np;
+	struct opp_table *opp_table;
 	int ret, count;
 
-again:
-	opp_np = _opp_of_get_opp_desc_node(dev->of_node, index);
-	if (!opp_np) {
+	if (index) {
 		/*
 		 * If only one phandle is present, then the same OPP table
 		 * applies for all index requests.
 		 */
 		count = of_count_phandle_with_args(dev->of_node,
 						   "operating-points-v2", NULL);
-		if (count == 1 && index) {
-			index = 0;
-			goto again;
-		}
+		if (count != 1)
+			return -ENODEV;
 
-		return -ENODEV;
+		index = 0;
 	}
 
-	ret = _of_add_opp_table_v2(dev, opp_np, index);
-	of_node_put(opp_np);
+	opp_table = dev_pm_opp_get_opp_table_indexed(dev, index);
+	if (!opp_table)
+		return -ENOMEM;
+
+	ret = _of_add_opp_table_v2(dev, opp_table);
+	if (ret)
+		dev_pm_opp_put_opp_table(opp_table);
 
 	return ret;
 }
-- 
2.14.1
