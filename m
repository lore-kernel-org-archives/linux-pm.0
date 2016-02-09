From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 01/16] PM / OPP: get/put regulators from OPP core
Date: Tue,  9 Feb 2016 10:30:33 +0530
Message-ID: <cfc33f1cd2e6a1f59d90b5d1ee3161efa3038fb0.1454992186.git.viresh.kumar@linaro.org>
References: <cover.1454992186.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:36354 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750962AbcBIFBI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 9 Feb 2016 00:01:08 -0500
Received: by mail-pa0-f50.google.com with SMTP id yy13so85137207pab.3
        for <linux-pm@vger.kernel.org>; Mon, 08 Feb 2016 21:01:08 -0800 (PST)
In-Reply-To: <cover.1454992186.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1454992186.git.viresh.kumar@linaro.org>
References: <cover.1454992186.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, nm@ti.com, Viresh Kumar <viresh.kumar@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Viresh Kumar <vireshk@kernel.org>

This allows the OPP core to request/free the regulator resource,
attached to a device OPP. The regulator device is fetched using the name
provided by the driver, while calling: dev_pm_opp_set_regulator().

This will work for both OPP-v1 and v2 bindings.

This is a preliminary step for moving the OPP switching logic into the
OPP core.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp/core.c | 111 ++++++++++++++++++++++++++++++++++++++++++
 drivers/base/power/opp/opp.h  |   4 ++
 include/linux/pm_opp.h        |   9 ++++
 3 files changed, 124 insertions(+)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index cf351d3dab1c..1e22b71abf1e 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -19,6 +19,7 @@
 #include <linux/device.h>
 #include <linux/of.h>
 #include <linux/export.h>
+#include <linux/regulator/consumer.h>
 
 #include "opp.h"
 
@@ -565,6 +566,9 @@ static void _remove_device_opp(struct device_opp *dev_opp)
 	if (dev_opp->prop_name)
 		return;
 
+	if (!IS_ERR_OR_NULL(dev_opp->regulator))
+		return;
+
 	list_dev = list_first_entry(&dev_opp->dev_list, struct device_list_opp,
 				    node);
 
@@ -1085,6 +1089,113 @@ void dev_pm_opp_put_prop_name(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_put_prop_name);
 
+/**
+ * dev_pm_opp_set_regulator() - Set regulator name for the device
+ * @dev: Device for which regulator name is being set.
+ * @name: Name of the regulator.
+ *
+ * In order to support OPP switching, OPP layer needs to know the name of the
+ * device's regulator, as the core would be required to switch voltages as well.
+ *
+ * This must be called before any OPPs are initialized for the device.
+ *
+ * Locking: The internal device_opp and opp structures are RCU protected.
+ * Hence this function internally uses RCU updater strategy with mutex locks
+ * to keep the integrity of the internal data structures. Callers should ensure
+ * that this function is *NOT* called under RCU protection or in contexts where
+ * mutex cannot be locked.
+ */
+int dev_pm_opp_set_regulator(struct device *dev, const char *name)
+{
+	struct device_opp *dev_opp;
+	struct regulator *reg;
+	int ret;
+
+	mutex_lock(&dev_opp_list_lock);
+
+	dev_opp = _add_device_opp(dev);
+	if (!dev_opp) {
+		ret = -ENOMEM;
+		goto unlock;
+	}
+
+	/* This should be called before OPPs are initialized */
+	if (WARN_ON(!list_empty(&dev_opp->opp_list))) {
+		ret = -EBUSY;
+		goto err;
+	}
+
+	/* Already have a regulator set */
+	if (WARN_ON(!IS_ERR_OR_NULL(dev_opp->regulator))) {
+		ret = -EBUSY;
+		goto err;
+	}
+	/* Allocate the regulator */
+	reg = regulator_get_optional(dev, name);
+	if (IS_ERR(reg)) {
+		ret = PTR_ERR(reg);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "%s: no regulator (%s) found: %d\n",
+				__func__, name, ret);
+		goto err;
+	}
+
+	dev_opp->regulator = reg;
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
+EXPORT_SYMBOL_GPL(dev_pm_opp_set_regulator);
+
+/**
+ * dev_pm_opp_put_regulator() - Releases resources blocked for regulator
+ * @dev: Device for which regulator was set.
+ *
+ * Locking: The internal device_opp and opp structures are RCU protected.
+ * Hence this function internally uses RCU updater strategy with mutex locks
+ * to keep the integrity of the internal data structures. Callers should ensure
+ * that this function is *NOT* called under RCU protection or in contexts where
+ * mutex cannot be locked.
+ */
+void dev_pm_opp_put_regulator(struct device *dev)
+{
+	struct device_opp *dev_opp;
+
+	mutex_lock(&dev_opp_list_lock);
+
+	/* Check for existing list for 'dev' first */
+	dev_opp = _find_device_opp(dev);
+	if (IS_ERR(dev_opp)) {
+		dev_err(dev, "Failed to find dev_opp: %ld\n", PTR_ERR(dev_opp));
+		goto unlock;
+	}
+
+	if (IS_ERR_OR_NULL(dev_opp->regulator)) {
+		dev_err(dev, "%s: Doesn't have regulator set\n", __func__);
+		goto unlock;
+	}
+
+	/* Make sure there are no concurrent readers while updating dev_opp */
+	WARN_ON(!list_empty(&dev_opp->opp_list));
+
+	regulator_put(dev_opp->regulator);
+	dev_opp->regulator = ERR_PTR(-EINVAL);
+
+	/* Try freeing device_opp if this was the last blocking resource */
+	_remove_device_opp(dev_opp);
+
+unlock:
+	mutex_unlock(&dev_opp_list_lock);
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_put_regulator);
+
 static bool _opp_is_supported(struct device *dev, struct device_opp *dev_opp,
 			      struct device_node *np)
 {
diff --git a/drivers/base/power/opp/opp.h b/drivers/base/power/opp/opp.h
index 690638ef36ee..416293b7da23 100644
--- a/drivers/base/power/opp/opp.h
+++ b/drivers/base/power/opp/opp.h
@@ -22,6 +22,8 @@
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
 
+struct regulator;
+
 /* Lock to allow exclusive modification to the device and opp lists */
 extern struct mutex dev_opp_list_lock;
 
@@ -132,6 +134,7 @@ struct device_list_opp {
  * @supported_hw: Array of version number to support.
  * @supported_hw_count: Number of elements in supported_hw array.
  * @prop_name: A name to postfix to many DT properties, while parsing them.
+ * @regulator: Supply regulator
  * @dentry:	debugfs dentry pointer of the real device directory (not links).
  * @dentry_name: Name of the real dentry.
  *
@@ -159,6 +162,7 @@ struct device_opp {
 	unsigned int *supported_hw;
 	unsigned int supported_hw_count;
 	const char *prop_name;
+	struct regulator *regulator;
 
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *dentry;
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 95403d2ccaf5..c70a18ac9c8a 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -60,6 +60,8 @@ int dev_pm_opp_set_supported_hw(struct device *dev, const u32 *versions,
 void dev_pm_opp_put_supported_hw(struct device *dev);
 int dev_pm_opp_set_prop_name(struct device *dev, const char *name);
 void dev_pm_opp_put_prop_name(struct device *dev);
+int dev_pm_opp_set_regulator(struct device *dev, const char *name);
+void dev_pm_opp_put_regulator(struct device *dev);
 #else
 static inline unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp)
 {
@@ -151,6 +153,13 @@ static inline int dev_pm_opp_set_prop_name(struct device *dev, const char *name)
 
 static inline void dev_pm_opp_put_prop_name(struct device *dev) {}
 
+static inline int dev_pm_opp_set_regulator(struct device *dev, const char *name)
+{
+	return -EINVAL;
+}
+
+static inline void dev_pm_opp_put_regulator(struct device *dev) {}
+
 #endif		/* CONFIG_PM_OPP */
 
 #if defined(CONFIG_PM_OPP) && defined(CONFIG_OF)
-- 
2.7.1.370.gb2aa7f8

