From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 1/6] PM / OPP: reuse of_parse_phandle()
Date: Fri,  4 Sep 2015 13:47:22 +0530
Message-ID: <6e9bebac1fd64de67d2f420eaa86e45716acfe8f.1441354424.git.viresh.kumar@linaro.org>
References: <cover.1441354424.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1441354424.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1441354424.git.viresh.kumar@linaro.org>
References: <cover.1441354424.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, sboyd@codeaurora.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com, Viresh Kumar <viresh.kumar@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

We already have a better API to get the opp descriptor block's node from
cpu-node. Lets reuse that instead of creating our own routines for the
same stuff. That cleans the code a lot.

This also kills a check we had earlier (as we are using the generic API
now). Earlier we used to check if the operating-points-v2 property
contained multiple phandles instead of a single phandle.

Killing this check isn't an issue because, we only parse the first entry
with of_parse_phandle(). So, if a user passes multiple phandles, its
really his problem :)

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp.c | 71 ++++++++++++------------------------------------
 1 file changed, 17 insertions(+), 54 deletions(-)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index eb254497a494..4741fdc13e83 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -1253,69 +1253,33 @@ void of_cpumask_free_opp_table(cpumask_var_t cpumask)
 }
 EXPORT_SYMBOL_GPL(of_cpumask_free_opp_table);
 
-/* Returns opp descriptor node from its phandle. Caller must do of_node_put() */
-static struct device_node *
-_of_get_opp_desc_node_from_prop(struct device *dev, const struct property *prop)
-{
-	struct device_node *opp_np;
-
-	opp_np = of_find_node_by_phandle(be32_to_cpup(prop->value));
-	if (!opp_np) {
-		dev_err(dev, "%s: Prop: %s contains invalid opp desc phandle\n",
-			__func__, prop->name);
-		return ERR_PTR(-EINVAL);
-	}
-
-	return opp_np;
-}
-
-/* Returns opp descriptor node for a device. Caller must do of_node_put() */
+/* Returns opp descriptor node for a device, caller must do of_node_put() */
 static struct device_node *_of_get_opp_desc_node(struct device *dev)
 {
-	const struct property *prop;
-
-	prop = of_find_property(dev->of_node, "operating-points-v2", NULL);
-	if (!prop)
-		return ERR_PTR(-ENODEV);
-	if (!prop->value)
-		return ERR_PTR(-ENODATA);
-
 	/*
 	 * TODO: Support for multiple OPP tables.
 	 *
 	 * There should be only ONE phandle present in "operating-points-v2"
 	 * property.
 	 */
-	if (prop->length != sizeof(__be32)) {
-		dev_err(dev, "%s: Invalid opp desc phandle\n", __func__);
-		return ERR_PTR(-EINVAL);
-	}
 
-	return _of_get_opp_desc_node_from_prop(dev, prop);
+	return of_parse_phandle(dev->of_node, "operating-points-v2", 0);
 }
 
 /* Initializes OPP tables based on new bindings */
 static int _of_init_opp_table_v2(struct device *dev,
-				 const struct property *prop)
+				 struct device_node *opp_np)
 {
-	struct device_node *opp_np, *np;
+	struct device_node *np;
 	struct device_opp *dev_opp;
 	int ret = 0, count = 0;
 
-	if (!prop->value)
-		return -ENODATA;
-
-	/* Get opp node */
-	opp_np = _of_get_opp_desc_node_from_prop(dev, prop);
-	if (IS_ERR(opp_np))
-		return PTR_ERR(opp_np);
-
 	dev_opp = _managed_opp(opp_np);
 	if (dev_opp) {
 		/* OPPs are already managed */
 		if (!_add_list_dev(dev, dev_opp))
 			ret = -ENOMEM;
-		goto put_opp_np;
+		return ret;
 	}
 
 	/* We have opp-list node now, iterate over it and add OPPs */
@@ -1331,10 +1295,8 @@ static int _of_init_opp_table_v2(struct device *dev,
 	}
 
 	/* There should be one of more OPP defined */
-	if (WARN_ON(!count)) {
-		ret = -ENOENT;
-		goto put_opp_np;
-	}
+	if (WARN_ON(!count))
+		return -ENOENT;
 
 	dev_opp = _find_device_opp(dev);
 	if (WARN_ON(IS_ERR(dev_opp))) {
@@ -1345,13 +1307,10 @@ static int _of_init_opp_table_v2(struct device *dev,
 	dev_opp->np = opp_np;
 	dev_opp->shared_opp = of_property_read_bool(opp_np, "opp-shared");
 
-	of_node_put(opp_np);
 	return 0;
 
 free_table:
 	of_free_opp_table(dev);
-put_opp_np:
-	of_node_put(opp_np);
 
 	return ret;
 }
@@ -1418,14 +1377,15 @@ static int _of_init_opp_table_v1(struct device *dev)
  */
 int of_init_opp_table(struct device *dev)
 {
-	const struct property *prop;
+	struct device_node *opp_np;
+	int ret;
 
 	/*
 	 * OPPs have two version of bindings now. The older one is deprecated,
 	 * try for the new binding first.
 	 */
-	prop = of_find_property(dev->of_node, "operating-points-v2", NULL);
-	if (!prop) {
+	opp_np = _of_get_opp_desc_node(dev);
+	if (!opp_np) {
 		/*
 		 * Try old-deprecated bindings for backward compatibility with
 		 * older dtbs.
@@ -1433,7 +1393,10 @@ int of_init_opp_table(struct device *dev)
 		return _of_init_opp_table_v1(dev);
 	}
 
-	return _of_init_opp_table_v2(dev, prop);
+	ret = _of_init_opp_table_v2(dev, opp_np);
+	of_node_put(opp_np);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(of_init_opp_table);
 
@@ -1522,7 +1485,7 @@ int of_get_cpus_sharing_opps(struct device *cpu_dev, cpumask_var_t cpumask)
 
 	/* Get OPP descriptor node */
 	np = _of_get_opp_desc_node(cpu_dev);
-	if (IS_ERR(np)) {
+	if (!np) {
 		dev_dbg(cpu_dev, "%s: Couldn't find opp node: %ld\n", __func__,
 			PTR_ERR(np));
 		return -ENOENT;
@@ -1546,7 +1509,7 @@ int of_get_cpus_sharing_opps(struct device *cpu_dev, cpumask_var_t cpumask)
 
 		/* Get OPP descriptor node */
 		tmp_np = _of_get_opp_desc_node(tcpu_dev);
-		if (IS_ERR(tmp_np)) {
+		if (!tmp_np) {
 			dev_err(tcpu_dev, "%s: Couldn't find opp node: %ld\n",
 				__func__, PTR_ERR(tmp_np));
 			ret = PTR_ERR(tmp_np);
-- 
2.4.0
