From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/3] PM / OPP: Parse 'opp-supported-hw' binding
Date: Thu, 19 Nov 2015 07:30:23 +0530
Message-ID: <20151119020023.GL7336@ubuntu>
References: <cover.1447669859.git.viresh.kumar@linaro.org>
 <6d603a73028b40493b280ba7ac9c3fcb51bb2362.1447669859.git.viresh.kumar@linaro.org>
 <20151118225358.GJ32672@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151118225358.GJ32672@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, robh+dt@kernel.org, nm@ti.com, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dmitry Torokhov <dtor@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Shawn Guo <shawnguo@kernel.org>
List-Id: linux-pm@vger.kernel.org

On 18-11-15, 14:53, Stephen Boyd wrote:
> Why do we need to allocate an array to check the property a u32
> at a time? We should be able to call of_property_read_u32_index()
> in a loop and check that against the version array. No allocation
> needed.

-------------------------8<-------------------------

From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue, 15 Sep 2015 12:53:00 +0530
Subject: [PATCH] PM / OPP: Parse 'opp-supported-hw' binding

OPP bindings allow a platform to enable OPPs based on the version of the
hardware they are used for.

Add support to the OPP-core to parse these bindings, by introducing
dev_pm_opp_{set|put}_supported_hw() APIs.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp/core.c | 124 ++++++++++++++++++++++++++++++++++++++++++
 drivers/base/power/opp/opp.h  |   5 ++
 include/linux/pm_opp.h        |  13 +++++
 3 files changed, 142 insertions(+)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index 6aa172be6e8e..93f7b8c87a26 100644
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
 
@@ -834,6 +837,121 @@ static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev)
 }
 
 /**
+ * dev_pm_opp_set_supported_hw() - Set supported platforms
+ * @dev: Device for which supported-hw has to be set.
+ * @versions: Array of hierarchy of versions to match.
+ * @count: Number of elements in the array.
+ *
+ * This is required only for the V2 bindings, and it enables a platform to
+ * specify the hierarchy of versions it supports. OPP layer will then enable
+ * OPPs, which are available for those versions, based on its 'opp-supported-hw'
+ * property.
+ */
+int dev_pm_opp_set_supported_hw(struct device *dev, const u32 *versions,
+				unsigned int count)
+{
+	struct device_opp *dev_opp;
+	int ret = 0;
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
+		ret = -EBUSY;
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
+ * @dev: Device for which supported-hw has to be set.
+ *
+ * This is required only for the V2 bindings, and is called for a matching
+ * dev_pm_opp_set_supported_hw(). Until this is called, the device_opp structure
+ * will not be freed.
+ */
+void dev_pm_opp_put_supported_hw(struct device *dev)
+{
+	struct device_opp *dev_opp;
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
+	unsigned int count = dev_opp->supported_hw_count;
+	u32 version;
+	int ret;
+
+	if (!dev_opp->supported_hw)
+		return true;
+
+	while (count--) {
+		ret = of_property_read_u32_index(np, "opp-supported-hw", count,
+						 &version);
+		if (ret) {
+			dev_warn(dev, "%s: failed to read opp-supported-hw property at index %d: %d\n",
+					__func__, count, ret);
+			return false;
+		}
+
+		/* Both of these are bitwise masks of the versions */
+		if (!(version & dev_opp->supported_hw[count]))
+			return false;
+	}
+
+	return true;
+}
+
+/**
  * _opp_add_static_v2() - Allocate static OPPs (As per 'v2' DT bindings)
  * @dev:	device for which we do this operation
  * @np:		device node
@@ -879,6 +997,12 @@ static int _opp_add_static_v2(struct device *dev, struct device_node *np)
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
index 9a2e50337af9..3a85110242f0 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -55,6 +55,9 @@ int dev_pm_opp_enable(struct device *dev, unsigned long freq);
 int dev_pm_opp_disable(struct device *dev, unsigned long freq);
 
 struct srcu_notifier_head *dev_pm_opp_get_notifier(struct device *dev);
+int dev_pm_opp_set_supported_hw(struct device *dev, const u32 *versions,
+				unsigned int count);
+void dev_pm_opp_put_supported_hw(struct device *dev);
 #else
 static inline unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp)
 {
@@ -129,6 +132,16 @@ static inline struct srcu_notifier_head *dev_pm_opp_get_notifier(
 {
 	return ERR_PTR(-EINVAL);
 }
+
+static inline int dev_pm_opp_set_supported_hw(struct device *dev,
+					      const u32 *versions,
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
viresh
