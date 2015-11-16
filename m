From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 2/3] PM / OPP: Parse 'opp-supported-hw' binding
Date: Mon, 16 Nov 2015 16:07:27 +0530
Message-ID: <6d603a73028b40493b280ba7ac9c3fcb51bb2362.1447669859.git.viresh.kumar@linaro.org>
References: <cover.1447669859.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34210 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752151AbbKPKiS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 16 Nov 2015 05:38:18 -0500
Received: by padhx2 with SMTP id hx2so171681993pad.1
        for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2015 02:38:17 -0800 (PST)
In-Reply-To: <cover.1447669859.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1447669859.git.viresh.kumar@linaro.org>
References: <cover.1447669859.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, robh+dt@kernel.org, nm@ti.com, Viresh Kumar <viresh.kumar@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dmitry Torokhov <dtor@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Shawn Guo <shawnguo@kernel.org>

OPP bindings allow a platform to enable OPPs based on the version of the
hardware they are used for.

Add support to the OPP-core to parse these bindings, by introducing
dev_pm_opp_{set|put}_supported_hw() APIs.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp/core.c | 153 ++++++++++++++++++++++++++++++++++++++++++
 drivers/base/power/opp/opp.h  |   5 ++
 include/linux/pm_opp.h        |  12 ++++
 3 files changed, 170 insertions(+)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index 6aa172be6e8e..29fe251bf9ec 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -559,6 +559,9 @@ static void _remove_device_opp(struct device_opp *dev_opp)
 	if (!list_empty(&dev_opp->opp_list))
 		return;
 
+	if (dev_opp->supported_hw)
+		return;
+
 	list_dev = list_first_entry(&dev_opp->dev_list, struct device_list_opp,
 				    node);
 
@@ -834,6 +837,150 @@ static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev)
 }
 
 /**
+ * dev_pm_opp_set_supported_hw() - Set supported platforms
+ * @dev: Device for which the regulator has to be set.
+ * @versions: Array of hierarchy of versions to match.
+ * @count: Number of elements in the array.
+ *
+ * This is required only for the V2 bindings, and it enables a platform to
+ * specify the hierarchy of versions it supports. OPP layer will then enable
+ * OPPs, which are available for those versions, based on its 'opp-supported-hw'
+ * property.
+ */
+int dev_pm_opp_set_supported_hw(struct device *dev, u32 *versions,
+				unsigned int count)
+{
+	struct device_opp *dev_opp;
+	int ret = 0;
+
+	if (!dev || !versions || !count) {
+		pr_err("%s: Invalid arguments, dev:0x%p, ver:0x%p, count:%u\n",
+		       __func__, dev, versions, count);
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
+	/* Do we already have a version hierarchy associated with dev_opp? */
+	if (dev_opp->supported_hw) {
+		dev_err(dev, "%s: Already have supported hardware list\n",
+			__func__);
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	dev_opp->supported_hw = kmemdup(versions, count * sizeof(*versions),
+					GFP_KERNEL);
+	if (!dev_opp->supported_hw) {
+		ret = -ENOMEM;
+		goto unlock;
+	}
+
+	dev_opp->supported_hw_count = count;
+
+unlock:
+	rcu_read_unlock();
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_set_supported_hw);
+
+/**
+ * dev_pm_opp_put_supported_hw() - Releases resources blocked for supported hw
+ * @dev: Device for which the regulator has to be set.
+ *
+ * This is required only for the V2 bindings, and is called for a matching
+ * dev_pm_opp_set_supported_hw(). Until this is called, the device_opp structure
+ * will not be freed.
+ */
+void dev_pm_opp_put_supported_hw(struct device *dev)
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
+	if (!dev_opp->supported_hw) {
+		dev_err(dev, "%s: Doesn't have supported hardware list\n",
+			__func__);
+		goto unlock;
+	}
+
+	kfree(dev_opp->supported_hw);
+	dev_opp->supported_hw = NULL;
+	dev_opp->supported_hw_count = 0;
+
+	/* Try freeing device_opp if this was the last blocking resource */
+	_remove_device_opp(dev_opp);
+
+unlock:
+	rcu_read_unlock();
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_put_supported_hw);
+
+static bool _opp_is_supported(struct device *dev, struct device_opp *dev_opp,
+			      struct device_node *np)
+{
+	unsigned int count;
+	u32 *versions;
+	bool supported = true;
+	int ret;
+
+	if (!dev_opp->supported_hw)
+		return true;
+
+	count = of_property_count_u32_elems(np, "opp-supported-hw");
+	if (count != dev_opp->supported_hw_count) {
+		dev_warn(dev, "%s: supported-hw count mismatch, plat:%u != DT:%u\n",
+			 __func__, dev_opp->supported_hw_count, count);
+		return false;
+	}
+
+	versions = kcalloc(count, sizeof(*versions), GFP_KERNEL);
+	if (!versions)
+		return false;
+
+	ret = of_property_read_u32_array(np, "opp-supported-hw", versions,
+					 count);
+	if (ret) {
+		dev_warn(dev, "%s: failed to read opp-supported-hw property: %d\n",
+			 __func__, ret);
+		supported = false;
+		goto free_versions;
+	}
+
+	while (count--) {
+		/* Both of these are bitwise masks of the versions */
+		if (!(versions[count] & dev_opp->supported_hw[count])) {
+			supported = false;
+			break;
+		}
+	}
+
+free_versions:
+	kfree(versions);
+
+	return supported;
+}
+
+/**
  * _opp_add_static_v2() - Allocate static OPPs (As per 'v2' DT bindings)
  * @dev:	device for which we do this operation
  * @np:		device node
@@ -879,6 +1026,12 @@ static int _opp_add_static_v2(struct device *dev, struct device_node *np)
 		goto free_opp;
 	}
 
+	/* Check if the OPP supports hardware's hierarchy of versions or not */
+	if (!_opp_is_supported(dev, dev_opp, np)) {
+		dev_dbg(dev, "OPP not supported by hardware: %llu\n", rate);
+		goto free_opp;
+	}
+
 	/*
 	 * Rate is defined as an unsigned long in clk API, and so casting
 	 * explicitly to its type. Must be fixed once rate is 64 bit
diff --git a/drivers/base/power/opp/opp.h b/drivers/base/power/opp/opp.h
index b8880c7f8be1..70f4564a6ab9 100644
--- a/drivers/base/power/opp/opp.h
+++ b/drivers/base/power/opp/opp.h
@@ -129,6 +129,8 @@ struct device_list_opp {
  * @clock_latency_ns_max: Max clock latency in nanoseconds.
  * @shared_opp: OPP is shared between multiple devices.
  * @suspend_opp: Pointer to OPP to be used during device suspend.
+ * @supported_hw: Array of version number to support.
+ * @supported_hw_count: Number of elements in supported_hw array.
  * @dentry:	debugfs dentry pointer of the real device directory (not links).
  * @dentry_name: Name of the real dentry.
  *
@@ -153,6 +155,9 @@ struct device_opp {
 	bool shared_opp;
 	struct dev_pm_opp *suspend_opp;
 
+	unsigned int *supported_hw;
+	unsigned int supported_hw_count;
+
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *dentry;
 	char dentry_name[NAME_MAX];
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 9a2e50337af9..d12471ed14a2 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -55,6 +55,9 @@ int dev_pm_opp_enable(struct device *dev, unsigned long freq);
 int dev_pm_opp_disable(struct device *dev, unsigned long freq);
 
 struct srcu_notifier_head *dev_pm_opp_get_notifier(struct device *dev);
+int dev_pm_opp_set_supported_hw(struct device *dev, u32 *versions,
+				unsigned int count);
+void dev_pm_opp_put_supported_hw(struct device *dev);
 #else
 static inline unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp)
 {
@@ -129,6 +132,15 @@ static inline struct srcu_notifier_head *dev_pm_opp_get_notifier(
 {
 	return ERR_PTR(-EINVAL);
 }
+
+static inline int dev_pm_opp_set_supported_hw(struct device *dev, u32 *versions,
+					      unsigned int count)
+{
+	return -EINVAL;
+}
+
+static inline void dev_pm_opp_put_supported_hw(struct device *dev) {}
+
 #endif		/* CONFIG_PM_OPP */
 
 #if defined(CONFIG_PM_OPP) && defined(CONFIG_OF)
-- 
2.6.2.198.g614a2ac

