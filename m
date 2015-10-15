From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 4/4] PM / OPP: Create separate structure for regulator/supplies
Date: Thu, 15 Oct 2015 21:42:46 +0530
Message-ID: <f5b244327b168ce419b4bc94404a1aac3ca69f61.1444925400.git.viresh.kumar@linaro.org>
References: <cover.1444925400.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1444925400.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1444925400.git.viresh.kumar@linaro.org>
References: <cover.1444925400.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, nm@ti.com, Viresh Kumar <viresh.kumar@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dmitry Torokhov <dtor@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

Support for multiple regulators will be added later, until then move
all power-supply related information in a separate structure.

To make allocating/freeing memory for these supply structures easy,
allocate memory for them along with opp.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp/core.c | 57 ++++++++++++++++++++++++++++---------------
 drivers/base/power/opp/opp.h  | 29 ++++++++++++++++------
 2 files changed, 58 insertions(+), 28 deletions(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index 8fa522f41226..4c00ba719ae4 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -127,7 +127,7 @@ unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp)
 	if (IS_ERR_OR_NULL(tmp_opp) || !tmp_opp->available)
 		pr_err("%s: Invalid parameters\n", __func__);
 	else
-		v = tmp_opp->u_volt;
+		v = tmp_opp->supplies[0].u_volt;
 
 	return v;
 }
@@ -483,13 +483,14 @@ struct device_list_opp *_add_list_dev(const struct device *dev,
 /**
  * _add_device_opp() - Find device OPP table or allocate a new one
  * @dev:	device for which we do this operation
+ * @supply_count: Number of supplies available for each OPP.
  *
  * It tries to find an existing table first, if it couldn't find one, it
  * allocates a new OPP table and returns that.
  *
  * Return: valid device_opp pointer if success, else NULL.
  */
-static struct device_opp *_add_device_opp(struct device *dev)
+static struct device_opp *_add_device_opp(struct device *dev, int supply_count)
 {
 	struct device_opp *dev_opp;
 	struct device_list_opp *list_dev;
@@ -507,6 +508,7 @@ static struct device_opp *_add_device_opp(struct device *dev)
 	if (!dev_opp)
 		return NULL;
 
+	dev_opp->supply_count = supply_count;
 	INIT_LIST_HEAD(&dev_opp->dev_list);
 
 	list_dev = _add_list_dev(dev, dev_opp);
@@ -643,24 +645,31 @@ void dev_pm_opp_remove(struct device *dev, unsigned long freq)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_remove);
 
-static struct dev_pm_opp *_allocate_opp(struct device *dev,
-					struct device_opp **dev_opp)
+static struct dev_pm_opp *
+_allocate_opp(struct device *dev, struct device_opp **dev_opp, int supply_count)
 {
 	struct dev_pm_opp *opp;
+	size_t size = sizeof(*opp);
+
+	/* Memory for the OPP and its supplies is allocated together */
+	size += supply_count * sizeof(*opp->supplies);
 
 	/* allocate new OPP node */
-	opp = kzalloc(sizeof(*opp), GFP_KERNEL);
+	opp = kzalloc(size, GFP_KERNEL);
 	if (!opp)
 		return NULL;
 
 	INIT_LIST_HEAD(&opp->node);
 
-	*dev_opp = _add_device_opp(dev);
+	*dev_opp = _add_device_opp(dev, supply_count);
 	if (!*dev_opp) {
 		kfree(opp);
 		return NULL;
 	}
 
+	/* Supplies points to the memory right after the opp */
+	opp->supplies = (struct opp_supply *)(opp + 1);
+
 	return opp;
 }
 
@@ -689,10 +698,12 @@ static int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
 
 		/* Duplicate OPPs */
 		dev_warn(dev, "%s: duplicate OPPs detected. Existing: freq: %lu, volt: %lu, enabled: %d. New: freq: %lu, volt: %lu, enabled: %d\n",
-			 __func__, opp->rate, opp->u_volt, opp->available,
-			 new_opp->rate, new_opp->u_volt, new_opp->available);
+			 __func__, opp->rate, opp->supplies[0].u_volt,
+			 opp->available, new_opp->rate,
+			 new_opp->supplies[0].u_volt, new_opp->available);
 
-		return opp->available && new_opp->u_volt == opp->u_volt ?
+		return opp->available &&
+			opp->supplies[0].u_volt == new_opp->supplies[0].u_volt ?
 			0 : -EEXIST;
 	}
 
@@ -739,7 +750,7 @@ static int _opp_add_v1(struct device *dev, unsigned long freq, long u_volt,
 	/* Hold our list modification lock here */
 	mutex_lock(&dev_opp_list_lock);
 
-	new_opp = _allocate_opp(dev, &dev_opp);
+	new_opp = _allocate_opp(dev, &dev_opp, 1);
 	if (!new_opp) {
 		ret = -ENOMEM;
 		goto unlock;
@@ -747,7 +758,7 @@ static int _opp_add_v1(struct device *dev, unsigned long freq, long u_volt,
 
 	/* populate the opp table */
 	new_opp->rate = freq;
-	new_opp->u_volt = u_volt;
+	new_opp->supplies[0].u_volt = u_volt;
 	new_opp->available = true;
 	new_opp->dynamic = dynamic;
 
@@ -774,6 +785,7 @@ static int _opp_add_v1(struct device *dev, unsigned long freq, long u_volt,
 /* TODO: Support multiple regulators */
 static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev)
 {
+	struct opp_supply *supply = &opp->supplies[0];
 	u32 microvolt[3] = {0};
 	u32 val;
 	int count, ret;
@@ -804,12 +816,12 @@ static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev)
 		return -EINVAL;
 	}
 
-	opp->u_volt = microvolt[0];
-	opp->u_volt_min = microvolt[1];
-	opp->u_volt_max = microvolt[2];
+	supply->u_volt = microvolt[0];
+	supply->u_volt_min = microvolt[1];
+	supply->u_volt_max = microvolt[2];
 
 	if (!of_property_read_u32(opp->np, "opp-microamp", &val))
-		opp->u_amp = val;
+		supply->u_amp = val;
 
 	return 0;
 }
@@ -818,6 +830,7 @@ static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev)
  * _opp_add_static_v2() - Allocate static OPPs (As per 'v2' DT bindings)
  * @dev:	device for which we do this operation
  * @np:		device node
+ * @supply_count: Number of supplies available for each OPP
  *
  * This function adds an opp definition to the opp list and returns status. The
  * opp can be controlled using dev_pm_opp_enable/disable functions and may be
@@ -837,10 +850,12 @@ static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev)
  * -ENOMEM	Memory allocation failure
  * -EINVAL	Failed parsing the OPP node
  */
-static int _opp_add_static_v2(struct device *dev, struct device_node *np)
+static int _opp_add_static_v2(struct device *dev, struct device_node *np,
+			      int supply_count)
 {
 	struct device_opp *dev_opp;
 	struct dev_pm_opp *new_opp;
+	struct opp_supply *supply;
 	u64 rate;
 	u32 val;
 	int ret;
@@ -848,7 +863,7 @@ static int _opp_add_static_v2(struct device *dev, struct device_node *np)
 	/* Hold our list modification lock here */
 	mutex_lock(&dev_opp_list_lock);
 
-	new_opp = _allocate_opp(dev, &dev_opp);
+	new_opp = _allocate_opp(dev, &dev_opp, supply_count);
 	if (!new_opp) {
 		ret = -ENOMEM;
 		goto unlock;
@@ -898,9 +913,10 @@ static int _opp_add_static_v2(struct device *dev, struct device_node *np)
 
 	mutex_unlock(&dev_opp_list_lock);
 
+	supply = &new_opp->supplies[0];
 	pr_debug("%s: turbo:%d rate:%lu uv:%lu uvmin:%lu uvmax:%lu latency:%lu\n",
-		 __func__, new_opp->turbo, new_opp->rate, new_opp->u_volt,
-		 new_opp->u_volt_min, new_opp->u_volt_max,
+		 __func__, new_opp->turbo, new_opp->rate, supply->u_volt,
+		 supply->u_volt_min, supply->u_volt_max,
 		 new_opp->clock_latency_ns);
 
 	/*
@@ -1187,7 +1203,8 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np)
 	for_each_available_child_of_node(opp_np, np) {
 		count++;
 
-		ret = _opp_add_static_v2(dev, np);
+		/* Todo: Add support for multiple supplies */
+		ret = _opp_add_static_v2(dev, np, 1);
 		if (ret) {
 			dev_err(dev, "%s: Failed to add OPP, %d\n", __func__,
 				ret);
diff --git a/drivers/base/power/opp/opp.h b/drivers/base/power/opp/opp.h
index dcb38f78dae4..bdc2bbab1444 100644
--- a/drivers/base/power/opp/opp.h
+++ b/drivers/base/power/opp/opp.h
@@ -38,6 +38,22 @@
  */
 
 /**
+ * struct opp_supply - Per power-supply structure
+ * @u_volt:	Target voltage in microvolts corresponding to this OPP
+ * @u_volt_min:	Minimum voltage in microvolts corresponding to this OPP
+ * @u_volt_max:	Maximum voltage in microvolts corresponding to this OPP
+ * @u_amp:	Maximum current drawn by the device in microamperes
+ *
+ * This structure stores the OPP power-supply information for a given device.
+ */
+struct opp_supply {
+	unsigned long u_volt;
+	unsigned long u_volt_min;
+	unsigned long u_volt_max;
+	unsigned long u_amp;
+};
+
+/**
  * struct dev_pm_opp - Generic OPP description structure
  * @node:	opp list node. The nodes are maintained throughout the lifetime
  *		of boot. It is expected only an optimal set of OPPs are
@@ -51,10 +67,7 @@
  * @available:	true/false - marks if this OPP as available or not
  * @turbo:	true if turbo (boost) OPP
  * @rate:	Frequency in hertz
- * @u_volt:	Target voltage in microvolts corresponding to this OPP
- * @u_volt_min:	Minimum voltage in microvolts corresponding to this OPP
- * @u_volt_max:	Maximum voltage in microvolts corresponding to this OPP
- * @u_amp:	Maximum current drawn by the device in microamperes
+ * @supplies:	Array of power-supplies for the device.
  * @clock_latency_ns: Latency (in nanoseconds) of switching to this OPP's
  *		frequency from any other OPP's frequency.
  * @dev_opp:	points back to the device_opp struct this opp belongs to
@@ -71,10 +84,8 @@ struct dev_pm_opp {
 	bool turbo;
 	unsigned long rate;
 
-	unsigned long u_volt;
-	unsigned long u_volt_min;
-	unsigned long u_volt_max;
-	unsigned long u_amp;
+	struct opp_supply *supplies;
+
 	unsigned long clock_latency_ns;
 
 	struct device_opp *dev_opp;
@@ -110,6 +121,7 @@ struct device_list_opp {
  * @dev_list:	list of devices that share these OPPs
  * @opp_list:	list of opps
  * @np:		struct device_node pointer for opp's DT node.
+ * @supply_count: Number of power-supplies
  * @shared_opp: OPP is shared between multiple devices.
  *
  * This is an internal data structure maintaining the link to opps attached to
@@ -130,6 +142,7 @@ struct device_opp {
 
 	struct device_node *np;
 	unsigned long clock_latency_ns_max;
+	unsigned int supply_count;
 	bool shared_opp;
 	struct dev_pm_opp *suspend_opp;
 };
-- 
2.4.0
