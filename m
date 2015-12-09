From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 2/2] PM / OPP: Parse 'opp-<prop>-<name>' bindings
Date: Wed,  9 Dec 2015 08:01:47 +0530
Message-ID: <e3744c43a5ad26e9e49cf938b3ecd846cc500fce.1449627691.git.viresh.kumar@linaro.org>
References: <cover.1449627691.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1449627691.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1449627691.git.viresh.kumar@linaro.org>
References: <cover.1449627691.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Pavel Machek <pavel@ucw.cz>, Stephen Boyd <sboyd@codeaurora.org>, Viresh Kumar <vireshk@kernel.org>
List-Id: linux-pm@vger.kernel.org

OPP bindings (for few properties) allow a platform to choose a
value/range among a set of available options. The options are present as
opp-<prop>-<name>, where the platform needs to supply the <name> string.

The OPP properties which allow such an option are: opp-microvolt and
opp-microamp.

Add support to the OPP-core to parse these bindings, by introducing
dev_pm_opp_{set|put}_prop_name() APIs.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp/core.c | 165 ++++++++++++++++++++++++++++++++++++++----
 drivers/base/power/opp/opp.h  |   2 +
 include/linux/pm_opp.h        |   9 +++
 3 files changed, 161 insertions(+), 15 deletions(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index 55cf1a99b532..5c01fec1ed14 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -562,6 +562,9 @@ static void _remove_device_opp(struct device_opp *dev_opp)
 	if (dev_opp->supported_hw)
 		return;
 
+	if (dev_opp->prop_name)
+		return;
+
 	list_dev = list_first_entry(&dev_opp->dev_list, struct device_list_opp,
 				    node);
 
@@ -794,35 +797,48 @@ static int _opp_add_v1(struct device *dev, unsigned long freq, long u_volt,
 }
 
 /* TODO: Support multiple regulators */
-static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev)
+static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev,
+			      struct device_opp *dev_opp)
 {
 	u32 microvolt[3] = {0};
 	u32 val;
 	int count, ret;
+	struct property *prop = NULL;
+	char name[NAME_MAX];
+
+	/* Search for "opp-microvolt-<name>" */
+	if (dev_opp->prop_name) {
+		sprintf(name, "opp-microvolt-%s", dev_opp->prop_name);
+		prop = of_find_property(opp->np, name, NULL);
+	}
+
+	if (!prop) {
+		/* Search for "opp-microvolt" */
+		name[13] = '\0';
+		prop = of_find_property(opp->np, name, NULL);
 
-	/* Missing property isn't a problem, but an invalid entry is */
-	if (!of_find_property(opp->np, "opp-microvolt", NULL))
-		return 0;
+		/* Missing property isn't a problem, but an invalid entry is */
+		if (!prop)
+			return 0;
+	}
 
-	count = of_property_count_u32_elems(opp->np, "opp-microvolt");
+	count = of_property_count_u32_elems(opp->np, name);
 	if (count < 0) {
-		dev_err(dev, "%s: Invalid opp-microvolt property (%d)\n",
-			__func__, count);
+		dev_err(dev, "%s: Invalid %s property (%d)\n",
+			__func__, name, count);
 		return count;
 	}
 
 	/* There can be one or three elements here */
 	if (count != 1 && count != 3) {
-		dev_err(dev, "%s: Invalid number of elements in opp-microvolt property (%d)\n",
-			__func__, count);
+		dev_err(dev, "%s: Invalid number of elements in %s property (%d)\n",
+			__func__, name, count);
 		return -EINVAL;
 	}
 
-	ret = of_property_read_u32_array(opp->np, "opp-microvolt", microvolt,
-					 count);
+	ret = of_property_read_u32_array(opp->np, name, microvolt, count);
 	if (ret) {
-		dev_err(dev, "%s: error parsing opp-microvolt: %d\n", __func__,
-			ret);
+		dev_err(dev, "%s: error parsing %s: %d\n", __func__, name, ret);
 		return -EINVAL;
 	}
 
@@ -830,7 +846,20 @@ static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev)
 	opp->u_volt_min = microvolt[1];
 	opp->u_volt_max = microvolt[2];
 
-	if (!of_property_read_u32(opp->np, "opp-microamp", &val))
+	/* Search for "opp-microamp-<name>" */
+	prop = NULL;
+	if (dev_opp->prop_name) {
+		sprintf(name, "opp-microamp-%s", dev_opp->prop_name);
+		prop = of_find_property(opp->np, name, NULL);
+	}
+
+	if (!prop) {
+		/* Search for "opp-microamp" */
+		name[12] = '\0';
+		prop = of_find_property(opp->np, name, NULL);
+	}
+
+	if (prop && !of_property_read_u32(opp->np, name, &val))
 		opp->u_amp = val;
 
 	return 0;
@@ -948,6 +977,112 @@ void dev_pm_opp_put_supported_hw(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_put_supported_hw);
 
+/**
+ * dev_pm_opp_set_prop_name() - Set prop-extn name
+ * @dev: Device for which the regulator has to be set.
+ * @name: name to postfix to properties.
+ *
+ * This is required only for the V2 bindings, and it enables a platform to
+ * specify the extn to be used for certain property names. The properties to
+ * which the extension will apply are opp-microvolt and opp-microamp. OPP core
+ * should postfix the property name with -<name> while looking for them.
+ *
+ * Locking: The internal device_opp and opp structures are RCU protected.
+ * Hence this function internally uses RCU updater strategy with mutex locks
+ * to keep the integrity of the internal data structures. Callers should ensure
+ * that this function is *NOT* called under RCU protection or in contexts where
+ * mutex cannot be locked.
+ */
+int dev_pm_opp_set_prop_name(struct device *dev, const char *name)
+{
+	struct device_opp *dev_opp;
+	int ret = 0;
+
+	/* Hold our list modification lock here */
+	mutex_lock(&dev_opp_list_lock);
+
+	dev_opp = _add_device_opp(dev);
+	if (!dev_opp) {
+		ret = -ENOMEM;
+		goto unlock;
+	}
+
+	/* Make sure there are no concurrent readers while updating dev_opp */
+	WARN_ON(!list_empty(&dev_opp->opp_list));
+
+	/* Do we already have a prop-name associated with dev_opp? */
+	if (dev_opp->prop_name) {
+		dev_err(dev, "%s: Already have prop-name %s\n", __func__,
+			dev_opp->prop_name);
+		ret = -EBUSY;
+		goto err;
+	}
+
+	dev_opp->prop_name = kstrdup(name, GFP_KERNEL);
+	if (!dev_opp->prop_name) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	mutex_unlock(&dev_opp_list_lock);
+	return 0;
+
+err:
+	_remove_device_opp(dev_opp);
+unlock:
+	mutex_unlock(&dev_opp_list_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_set_prop_name);
+
+/**
+ * dev_pm_opp_put_prop_name() - Releases resources blocked for prop-name
+ * @dev: Device for which the regulator has to be set.
+ *
+ * This is required only for the V2 bindings, and is called for a matching
+ * dev_pm_opp_set_prop_name(). Until this is called, the device_opp structure
+ * will not be freed.
+ *
+ * Locking: The internal device_opp and opp structures are RCU protected.
+ * Hence this function internally uses RCU updater strategy with mutex locks
+ * to keep the integrity of the internal data structures. Callers should ensure
+ * that this function is *NOT* called under RCU protection or in contexts where
+ * mutex cannot be locked.
+ */
+void dev_pm_opp_put_prop_name(struct device *dev)
+{
+	struct device_opp *dev_opp;
+
+	/* Hold our list modification lock here */
+	mutex_lock(&dev_opp_list_lock);
+
+	/* Check for existing list for 'dev' first */
+	dev_opp = _find_device_opp(dev);
+	if (IS_ERR(dev_opp)) {
+		dev_err(dev, "Failed to find dev_opp: %ld\n", PTR_ERR(dev_opp));
+		goto unlock;
+	}
+
+	/* Make sure there are no concurrent readers while updating dev_opp */
+	WARN_ON(!list_empty(&dev_opp->opp_list));
+
+	if (!dev_opp->prop_name) {
+		dev_err(dev, "%s: Doesn't have a prop-name\n", __func__);
+		goto unlock;
+	}
+
+	kfree(dev_opp->prop_name);
+	dev_opp->prop_name = NULL;
+
+	/* Try freeing device_opp if this was the last blocking resource */
+	_remove_device_opp(dev_opp);
+
+unlock:
+	mutex_unlock(&dev_opp_list_lock);
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_put_prop_name);
+
 static bool _opp_is_supported(struct device *dev, struct device_opp *dev_opp,
 			      struct device_node *np)
 {
@@ -1042,7 +1177,7 @@ static int _opp_add_static_v2(struct device *dev, struct device_node *np)
 	if (!of_property_read_u32(np, "clock-latency-ns", &val))
 		new_opp->clock_latency_ns = val;
 
-	ret = opp_parse_supplies(new_opp, dev);
+	ret = opp_parse_supplies(new_opp, dev, dev_opp);
 	if (ret)
 		goto free_opp;
 
diff --git a/drivers/base/power/opp/opp.h b/drivers/base/power/opp/opp.h
index 70f4564a6ab9..690638ef36ee 100644
--- a/drivers/base/power/opp/opp.h
+++ b/drivers/base/power/opp/opp.h
@@ -131,6 +131,7 @@ struct device_list_opp {
  * @suspend_opp: Pointer to OPP to be used during device suspend.
  * @supported_hw: Array of version number to support.
  * @supported_hw_count: Number of elements in supported_hw array.
+ * @prop_name: A name to postfix to many DT properties, while parsing them.
  * @dentry:	debugfs dentry pointer of the real device directory (not links).
  * @dentry_name: Name of the real dentry.
  *
@@ -157,6 +158,7 @@ struct device_opp {
 
 	unsigned int *supported_hw;
 	unsigned int supported_hw_count;
+	const char *prop_name;
 
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *dentry;
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 3a85110242f0..95403d2ccaf5 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -58,6 +58,8 @@ struct srcu_notifier_head *dev_pm_opp_get_notifier(struct device *dev);
 int dev_pm_opp_set_supported_hw(struct device *dev, const u32 *versions,
 				unsigned int count);
 void dev_pm_opp_put_supported_hw(struct device *dev);
+int dev_pm_opp_set_prop_name(struct device *dev, const char *name);
+void dev_pm_opp_put_prop_name(struct device *dev);
 #else
 static inline unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp)
 {
@@ -142,6 +144,13 @@ static inline int dev_pm_opp_set_supported_hw(struct device *dev,
 
 static inline void dev_pm_opp_put_supported_hw(struct device *dev) {}
 
+static inline int dev_pm_opp_set_prop_name(struct device *dev, const char *name)
+{
+	return -EINVAL;
+}
+
+static inline void dev_pm_opp_put_prop_name(struct device *dev) {}
+
 #endif		/* CONFIG_PM_OPP */
 
 #if defined(CONFIG_PM_OPP) && defined(CONFIG_OF)
-- 
2.6.2.198.g614a2ac
