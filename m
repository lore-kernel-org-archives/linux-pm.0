From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 07/16] PM / OPP: Add multiple regulators support
Date: Fri, 11 Sep 2015 17:32:03 +0530
Message-ID: <5ffbcd0ecb41500851dc5eb3a5393b21ebea7b76.1441972771.git.viresh.kumar@linaro.org>
References: <cover.1441972771.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1441972771.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1441972771.git.viresh.kumar@linaro.org>
References: <cover.1441972771.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, sboyd@codeaurora.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, rob.herring@linaro.org, lee.jones@linaro.org, Viresh Kumar <viresh.kumar@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dmitry Torokhov <dtor@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

This adds support to parse multiple regulators or power-supplies in OPP
core. This doesn't use those values yet.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp/core.c    | 197 +++++++++++++++++++++++++++++++--------
 drivers/base/power/opp/debugfs.c |  53 +++++++----
 drivers/base/power/opp/opp.h     |   4 +
 3 files changed, 201 insertions(+), 53 deletions(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index 14e5fa10be2d..d6e945ec6467 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -502,21 +502,27 @@ static struct device_opp *_add_device_opp(struct device *dev, int supply_count)
 {
 	struct device_opp *dev_opp;
 	struct device_list_opp *list_dev;
+	size_t size;
 
 	/* Check for existing list for 'dev' first */
 	dev_opp = _find_device_opp(dev);
 	if (!IS_ERR(dev_opp))
 		return dev_opp;
 
+	/* Allocate size for supply-names with dev_opp */
+	size = sizeof(*dev_opp) + supply_count * sizeof(*dev_opp->supply_names);
+
 	/*
 	 * Allocate a new device OPP table. In the infrequent case where a new
 	 * device is needed to be added, we pay this penalty.
 	 */
-	dev_opp = kzalloc(sizeof(*dev_opp), GFP_KERNEL);
+	dev_opp = kzalloc(size, GFP_KERNEL);
 	if (!dev_opp)
 		return NULL;
 
 	dev_opp->supply_count = supply_count;
+	dev_opp->supply_names = (const char **)(dev_opp + 1);
+
 	INIT_LIST_HEAD(&dev_opp->dev_list);
 
 	list_dev = _add_list_dev(dev, dev_opp);
@@ -525,6 +531,13 @@ static struct device_opp *_add_device_opp(struct device *dev, int supply_count)
 		return NULL;
 	}
 
+	/*
+	 * Initialize supply-name as dev-name for single supplies. This is
+	 * required for the debugfs code.
+	 */
+	if (supply_count == 1)
+		*dev_opp->supply_names = dev_name(dev);
+
 	srcu_init_notifier_head(&dev_opp->srcu_head);
 	INIT_LIST_HEAD(&dev_opp->opp_list);
 
@@ -682,6 +695,23 @@ _allocate_opp(struct device *dev, struct device_opp **dev_opp, int supply_count)
 	return opp;
 }
 
+static bool _supplies_match(struct device_opp *dev_opp,
+			    struct dev_pm_opp *old_opp,
+			    struct dev_pm_opp *new_opp)
+{
+	struct opp_supply *old = old_opp->supplies;
+	struct opp_supply *new = new_opp->supplies;
+	int i;
+
+	for (i = 0; i < dev_opp->supply_count; i++)
+		if (old[i].u_volt != new[i].u_volt ||
+		    old[i].u_volt_min != new[i].u_volt_min ||
+		    old[i].u_volt_max != new[i].u_volt_max)
+			return false;
+
+	return true;
+}
+
 static int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
 		    struct device_opp *dev_opp)
 {
@@ -712,9 +742,8 @@ static int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
 			 opp->available, new_opp->rate,
 			 new_opp->supplies[0].u_volt, new_opp->available);
 
-		return opp->available &&
-			opp->supplies[0].u_volt == new_opp->supplies[0].u_volt ?
-			0 : -EEXIST;
+		return opp->available && _supplies_match(dev_opp, opp, new_opp)
+			? 0 : -EEXIST;
 	}
 
 	new_opp->dev_opp = dev_opp;
@@ -797,41 +826,99 @@ static int _opp_add_v1(struct device *dev, unsigned long freq, long u_volt,
 	return ret;
 }
 
-/* TODO: Support multiple regulators */
-static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev)
+/* returns the number of entries used from microvolt */
+static void opp_parse_single_supply(struct opp_supply *supply, bool triplet,
+				    u32 *microvolt, u32 *microamp)
 {
-	struct opp_supply *supply = &opp->supplies[0];
-	u32 microvolt[3] = {0};
-	u32 val;
-	int count, ret;
+	if (triplet) {
+		supply->u_volt = microvolt[0];
+		supply->u_volt_min = microvolt[1];
+		supply->u_volt_max = microvolt[2];
+	} else {
+		supply->u_volt = microvolt[0];
+		supply->u_volt_min = microvolt[0];
+		supply->u_volt_max = microvolt[0];
+	}
+
+	supply->u_amp = *microamp;
+}
+
+static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev,
+			      int supply_count, bool triplets)
+{
+	struct opp_supply *supply = opp->supplies;
+	int i, vcount, icount, ret, step;
+	u32 *microvolt, *microamp;
 
-	count = of_property_count_u32_elems(opp->np, "opp-microvolt");
-	if (!count)
+	vcount = of_property_count_u32_elems(opp->np, "opp-microvolt");
+	if (!vcount)
 		return 0;
 
-	/* There can be one or three elements here */
-	if (count != 1 && count != 3) {
-		dev_err(dev, "%s: Invalid number of elements in opp-microvolt property (%d)\n",
-			__func__, count);
-		return -EINVAL;
-	}
+	icount = of_property_count_u32_elems(opp->np, "opp-microamp");
+	if (!icount)
+		return 0;
+
+	/* Allocate memory for volt/amp */
+	microvolt = kcalloc(vcount, sizeof(*microvolt), GFP_KERNEL);
+	microamp = kcalloc(icount, sizeof(*microamp), GFP_KERNEL);
+	if (!microvolt || !microamp)
+		return -ENOMEM;
 
 	ret = of_property_read_u32_array(opp->np, "opp-microvolt", microvolt,
-					 count);
+					 vcount);
 	if (ret) {
 		dev_err(dev, "%s: error parsing opp-microvolt: %d\n", __func__,
 			ret);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto free_microvolt;
 	}
 
-	supply->u_volt = microvolt[0];
-	supply->u_volt_min = microvolt[1];
-	supply->u_volt_max = microvolt[2];
+	ret = of_property_read_u32_array(opp->np, "opp-microamp", microamp,
+					 icount);
+	if (ret) {
+		dev_err(dev, "%s: error parsing opp-microamp: %d\n", __func__,
+			ret);
+		ret = -EINVAL;
+		goto free_microvolt;
+	}
 
-	if (!of_property_read_u32(opp->np, "opp-microamp", &val))
-		supply->u_amp = val;
+	/*
+	 * For single supply, "opp-microvolt-triplets" is not mandatory and we
+	 * need to find it ourselves.
+	 */
+	if (supply_count == 1) {
+		if (vcount == 1) {
+			triplets = false;
+		} else if (vcount == 3) {
+			triplets = true;
+		} else {
+			dev_err(dev, "%s: opp-microvolt property should have 1 or 3 elements (%d)\n",
+				__func__, vcount);
+			ret = -EINVAL;
+			goto free_microvolt;
+		}
+	}
 
-	return 0;
+	step = triplets ? 3 : 1;
+
+	/* microvolt sanity check */
+	if ((vcount != supply_count * step) || (icount != supply_count)) {
+		dev_err(dev, "%s: Invalid number of elements in opp-microvolt/amp property (v=%d i=%d c=%d t=%d)\n",
+			__func__, vcount, icount, supply_count * step,
+			triplets);
+		ret = -EINVAL;
+		goto free_microvolt;
+	}
+
+	for (i = 0; i < supply_count; i++)
+		opp_parse_single_supply(supply + i, triplets,
+					microvolt + step * i, microamp + i);
+
+free_microvolt:
+	kfree(microamp);
+	kfree(microvolt);
+
+	return ret;
 }
 
 /**
@@ -839,6 +926,8 @@ static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev)
  * @dev:	device for which we do this operation
  * @np:		device node
  * @supply_count: Number of supplies available for each OPP
+ * @triplets:	If true, microvolt property should be in form <target min max>,
+ *		else <target>.
  *
  * This function adds an opp definition to the opp list and returns status. The
  * opp can be controlled using dev_pm_opp_enable/disable functions and may be
@@ -859,7 +948,7 @@ static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev)
  * -EINVAL	Failed parsing the OPP node
  */
 static int _opp_add_static_v2(struct device *dev, struct device_node *np,
-			      int supply_count)
+			      int supply_count, bool triplets)
 {
 	struct device_opp *dev_opp;
 	struct dev_pm_opp *new_opp;
@@ -898,7 +987,7 @@ static int _opp_add_static_v2(struct device *dev, struct device_node *np,
 	if (!of_property_read_u32(np, "clock-latency-ns", &val))
 		new_opp->clock_latency_ns = val;
 
-	ret = opp_parse_supplies(new_opp, dev);
+	ret = opp_parse_supplies(new_opp, dev, supply_count, triplets);
 	if (ret)
 		goto free_opp;
 
@@ -1165,6 +1254,10 @@ void dev_pm_opp_of_remove_table(struct device *dev)
 
 	/* Find if dev_opp manages a single device */
 	if (list_is_singular(&dev_opp->dev_list)) {
+		/* Free dev_opp if no OPPs are added yet */
+		if (list_empty(&dev_opp->opp_list))
+			_remove_device_opp(dev_opp);
+
 		/* Free static OPPs */
 		list_for_each_entry_safe(opp, tmp, &dev_opp->opp_list, node) {
 			if (!opp->dynamic)
@@ -1197,7 +1290,9 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np)
 {
 	struct device_node *np;
 	struct device_opp *dev_opp;
-	int ret = 0, count = 0;
+	const char **name;
+	int ret = 0, count, supply_count, string_count;
+	bool triplets;
 
 	dev_opp = _managed_opp(opp_np);
 	if (dev_opp) {
@@ -1207,12 +1302,44 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np)
 		return ret;
 	}
 
+	triplets = of_property_read_bool(opp_np, "opp-microvolt-triplets");
+	string_count = of_property_count_strings(opp_np, "supply-names");
+
+	/* Fallback to single power-supply if multiple aren't present */
+	if (string_count <= 0) {
+		supply_count = 1;
+		string_count = 0;
+	} else {
+		supply_count = string_count;
+	}
+
+	/*
+	 * We need to add dev_opp before adding any OPPs, so that supply_names
+	 * are valid while the OPPs are getting added.
+	 */
+	dev_opp = _add_device_opp(dev, supply_count);
+	if (!dev_opp)
+		return -ENOMEM;
+
+	/* Parse supply names */
+	name = dev_opp->supply_names;
+	for (count = 0; count < string_count; count++, name++) {
+		/* Parse supply names */
+		ret = of_property_read_string_index(opp_np, "supply-names",
+						    count, name);
+		if (ret) {
+			dev_err(dev, "%s: read supply names (%s) error (%d)\n",
+				__func__, opp_np->name, ret);
+			goto free_table;
+		}
+	}
+
 	/* We have opp-list node now, iterate over it and add OPPs */
+	count = 0;
 	for_each_available_child_of_node(opp_np, np) {
 		count++;
 
-		/* Todo: Add support for multiple supplies */
-		ret = _opp_add_static_v2(dev, np, 1);
+		ret = _opp_add_static_v2(dev, np, supply_count, triplets);
 		if (ret) {
 			dev_err(dev, "%s: Failed to add OPP, %d\n", __func__,
 				ret);
@@ -1221,12 +1348,8 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np)
 	}
 
 	/* There should be one of more OPP defined */
-	if (WARN_ON(!count))
-		return -ENOENT;
-
-	dev_opp = _find_device_opp(dev);
-	if (WARN_ON(IS_ERR(dev_opp))) {
-		ret = PTR_ERR(dev_opp);
+	if (WARN_ON(!count)) {
+		ret = -ENOENT;
 		goto free_table;
 	}
 
diff --git a/drivers/base/power/opp/debugfs.c b/drivers/base/power/opp/debugfs.c
index e6ba29c04513..de2083d69297 100644
--- a/drivers/base/power/opp/debugfs.c
+++ b/drivers/base/power/opp/debugfs.c
@@ -31,12 +31,44 @@ void opp_debug_remove_one(struct dev_pm_opp *opp)
 	debugfs_remove_recursive(opp->dentry);
 }
 
+int opp_debug_create_supplies(struct dev_pm_opp *opp,
+			      struct device_opp *dev_opp, struct dentry *dentry)
+{
+	struct opp_supply *supply = opp->supplies;
+	char name[NAME_MAX];
+	const char **supply_name = dev_opp->supply_names;
+	int i;
+
+	for (i = 0; i < dev_opp->supply_count; i++, supply_name++) {
+		snprintf(name, sizeof(name), "%s_u_volt_target", *supply_name);
+		if (!debugfs_create_u32(name, S_IRUGO, dentry,
+					(u32 *)&supply->u_volt))
+			return -ENOMEM;
+
+		snprintf(name, sizeof(name), "%s_u_volt_min", *supply_name);
+		if (!debugfs_create_u32(name, S_IRUGO, dentry,
+					(u32 *)&supply->u_volt_min))
+			return -ENOMEM;
+
+		snprintf(name, sizeof(name), "%s_u_volt_max", *supply_name);
+		if (!debugfs_create_u32(name, S_IRUGO, dentry,
+					(u32 *)&supply->u_volt_max))
+			return -ENOMEM;
+	}
+
+	if (!debugfs_create_u32("u_amp", S_IRUGO, dentry,
+				(u32 *)&supply->u_amp))
+		return -ENOMEM;
+
+	return 0;
+}
+
 int opp_debug_create_one(struct dev_pm_opp *opp, struct device_opp *dev_opp)
 {
 	struct dentry *pdentry = dev_opp->dentry;
-	struct opp_supply *supply = &opp->supplies[0];
 	struct dentry *d;
 	char name[15];
+	int ret;
 
 	/* Rate is unique to each OPP, use it to give opp-name */
 	sprintf(name, "opp:%lu", opp->rate);
@@ -59,25 +91,14 @@ int opp_debug_create_one(struct dev_pm_opp *opp, struct device_opp *dev_opp)
 	if (!debugfs_create_u32("rate_hz", S_IRUGO, d, (u32 *)&opp->rate))
 		return -ENOMEM;
 
-	if (!debugfs_create_u32("u_volt_target", S_IRUGO, d,
-				(u32 *)&supply->u_volt))
-		return -ENOMEM;
-
-	if (!debugfs_create_u32("u_volt_min", S_IRUGO, d,
-				(u32 *)&supply->u_volt_min))
-		return -ENOMEM;
-
-	if (!debugfs_create_u32("u_volt_max", S_IRUGO, d,
-				(u32 *)&supply->u_volt_max))
-		return -ENOMEM;
-
-	if (!debugfs_create_u32("u_amp", S_IRUGO, d, (u32 *)&supply->u_amp))
-		return -ENOMEM;
-
 	if (!debugfs_create_u32("clock_latency_ns", S_IRUGO, d,
 				(u32 *)&opp->clock_latency_ns))
 		return -ENOMEM;
 
+	ret = opp_debug_create_supplies(opp, dev_opp, d);
+	if (ret)
+		return ret;
+
 	opp->dentry = d;
 	return 0;
 }
diff --git a/drivers/base/power/opp/opp.h b/drivers/base/power/opp/opp.h
index a7a6917d6fbd..16575268f6ce 100644
--- a/drivers/base/power/opp/opp.h
+++ b/drivers/base/power/opp/opp.h
@@ -135,6 +135,7 @@ struct device_list_opp {
  * @opp_list:	list of opps
  * @np:		struct device_node pointer for opp's DT node.
  * @supply_count: Number of power-supplies
+ * @supply_names: Array of strings containing names of the power-supplies
  * @shared_opp: OPP is shared between multiple devices.
  * @dentry:	debugfs dentry pointer of the real device directory (not links).
  * @dentry_name: Name of the real dentry.
@@ -157,7 +158,10 @@ struct device_opp {
 
 	struct device_node *np;
 	unsigned long clock_latency_ns_max;
+
 	unsigned int supply_count;
+	const char **supply_names;
+
 	bool shared_opp;
 	struct dev_pm_opp *suspend_opp;
 
-- 
2.4.0
