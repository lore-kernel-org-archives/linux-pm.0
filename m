From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 3/3] PM / OPP: Parse 'opp-<prop>-<name>' bindings
Date: Mon, 16 Nov 2015 16:07:28 +0530
Message-ID: <c90cf734ae1cc009601a69cdcc744d412c7b9cfa.1447669859.git.viresh.kumar@linaro.org>
References: <cover.1447669859.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1447669859.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1447669859.git.viresh.kumar@linaro.org>
References: <cover.1447669859.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, robh+dt@kernel.org, nm@ti.com, Viresh Kumar <viresh.kumar@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dmitry Torokhov <dtor@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Shawn Guo <shawnguo@kernel.org>
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
 drivers/base/power/opp/core.c | 148 ++++++++++++++++++++++++++++++++++++++----
 drivers/base/power/opp/opp.h  |   2 +
 include/linux/pm_opp.h        |   9 +++
 3 files changed, 146 insertions(+), 13 deletions(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index 29fe251bf9ec..b3750aa9552f 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -105,6 +105,15 @@ struct device_opp *_find_device_opp(struct device *dev)
 	return ERR_PTR(-ENODEV);
 }
 
+static void _opp_create_prop_name(char *name, const char *prefix,
+				  const char *postfix)
+{
+	if (postfix)
+		sprintf(name, "%s-%s", prefix, postfix);
+	else
+		sprintf(name, "%s", prefix);
+}
+
 /**
  * dev_pm_opp_get_voltage() - Gets the voltage corresponding to an opp
  * @opp:	opp for which voltage has to be returned for
@@ -562,6 +571,9 @@ static void _remove_device_opp(struct device_opp *dev_opp)
 	if (dev_opp->supported_hw)
 		return;
 
+	if (dev_opp->prop_name)
+		return;
+
 	list_dev = list_first_entry(&dev_opp->dev_list, struct device_list_opp,
 				    node);
 
@@ -794,20 +806,32 @@ static int _opp_add_v1(struct device *dev, unsigned long freq, long u_volt,
 }
 
 /* TODO: Support multiple regulators */
-static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev)
+static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev,
+			      struct device_opp *dev_opp)
 {
 	u32 microvolt[3] = {0};
 	u32 val;
 	int count, ret;
+	struct property *prop;
+	char name[NAME_MAX];
 
-	/* Missing property isn't a problem, but an invalid entry is */
-	if (!of_find_property(opp->np, "opp-microvolt", NULL))
-		return 0;
+	/* Search for both "opp-microvolt-<name>" and "opp-microvolt" */
+	_opp_create_prop_name(name, "opp-microvolt", dev_opp->prop_name);
 
-	count = of_property_count_u32_elems(opp->np, "opp-microvolt");
+	prop = of_find_property(opp->np, name, NULL);
+	if (!prop) {
+		_opp_create_prop_name(name, "opp-microvolt", NULL);
+		prop = of_find_property(opp->np, name, NULL);
+
+		/* Missing property isn't a problem, but an invalid entry is */
+		if (!prop)
+			return 0;
+	}
+
+	count = of_property_count_u32_elems(opp->np, name);
 	if (count < 0) {
-		dev_err(dev, "%s: Invalid opp-microvolt property (%d)\n",
-			__func__, count);
+		dev_err(dev, "%s: Invalid %s property (%d)\n",
+			__func__, name, count);
 		return count;
 	}
 
@@ -818,11 +842,9 @@ static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev)
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
 
@@ -830,7 +852,15 @@ static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev)
 	opp->u_volt_min = microvolt[1];
 	opp->u_volt_max = microvolt[2];
 
-	if (!of_property_read_u32(opp->np, "opp-microamp", &val))
+	/* Search for both "opp-microamp-<name>" and "opp-microamp" */
+	_opp_create_prop_name(name, "opp-microamp", dev_opp->prop_name);
+	prop = of_find_property(opp->np, name, NULL);
+	if (!prop) {
+		_opp_create_prop_name(name, "opp-microamp", NULL);
+		prop = of_find_property(opp->np, name, NULL);
+	}
+
+	if (prop && !of_property_read_u32(opp->np, "opp-microamp", &val))
 		opp->u_amp = val;
 
 	return 0;
@@ -935,6 +965,98 @@ void dev_pm_opp_put_supported_hw(struct device *dev)
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
+ */
+int dev_pm_opp_set_prop_name(struct device *dev, const char *name)
+{
+	struct device_opp *dev_opp;
+	int ret = 0;
+
+	if (!dev || !name) {
+		pr_err("%s: Invalid arguments, dev:0x%p, name:%p\n", __func__,
+		       dev, name);
+		return -EINVAL;
+	}
+
+	/* Operations on OPP structures must be done from within rcu locks */
+	rcu_read_lock();
+
+	dev_opp = _add_device_opp(dev);
+	if (!dev_opp)
+		return -ENOMEM;
+
+	/* Do we already have a prop-name associated with dev_opp? */
+	if (dev_opp->prop_name) {
+		dev_err(dev, "%s: Already have prop-name %s\n", __func__,
+			dev_opp->prop_name);
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	dev_opp->prop_name = kstrdup(name, GFP_KERNEL);
+	if (!dev_opp->prop_name) {
+		ret = -ENOMEM;
+		goto unlock;
+	}
+
+unlock:
+	rcu_read_unlock();
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
+ */
+void dev_pm_opp_put_prop_name(struct device *dev)
+{
+	struct device_opp *dev_opp;
+
+	if (!dev) {
+		pr_err("%s: Invalid argument dev:0x%p\n", __func__, dev);
+		return;
+	}
+
+	/* Operations on OPP structures must be done from within rcu locks */
+	rcu_read_lock();
+
+	/* Check for existing list for 'dev' first */
+	dev_opp = _find_device_opp(dev);
+	if (IS_ERR(dev_opp)) {
+		dev_err(dev, "Failed to find dev_opp: %ld\n", PTR_ERR(dev_opp));
+		goto unlock;
+	}
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
+	rcu_read_unlock();
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_put_prop_name);
+
 static bool _opp_is_supported(struct device *dev, struct device_opp *dev_opp,
 			      struct device_node *np)
 {
@@ -1047,7 +1169,7 @@ static int _opp_add_static_v2(struct device *dev, struct device_node *np)
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
index d12471ed14a2..eec973130951 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -58,6 +58,8 @@ struct srcu_notifier_head *dev_pm_opp_get_notifier(struct device *dev);
 int dev_pm_opp_set_supported_hw(struct device *dev, u32 *versions,
 				unsigned int count);
 void dev_pm_opp_put_supported_hw(struct device *dev);
+int dev_pm_opp_set_prop_name(struct device *dev, const char *name);
+void dev_pm_opp_put_prop_name(struct device *dev);
 #else
 static inline unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp)
 {
@@ -141,6 +143,13 @@ static inline int dev_pm_opp_set_supported_hw(struct device *dev, u32 *versions,
 
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
