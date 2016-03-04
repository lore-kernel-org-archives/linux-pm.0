From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/2] PM / clk: Add support for obtaining clocks from device-tree
Date: Fri, 4 Mar 2016 15:33:05 +0000
Message-ID: <1457105585-25157-2-git-send-email-jonathanh@nvidia.com>
References: <1457105585-25157-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1457105585-25157-1-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

The PM clocks framework requires clients to pass either a con-id or a
valid clk pointer in order to add a clock to a device. Add a new
function pm_clk_add_clks_of() to allows device clocks to be retrieved
from device-tree and populated for a given device. Note that there
should be no need to add a stub function for this new function when
CONFIG_OF is not selected because the OF functions used already have
stubs functions.

In order to handle errors encountered when adding clocks from
device-tree, add a function pm_clk_remove_clk() to remove any clocks
(using a pointer to the clk structure) that have been added
successfully before the error occurred.

Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/base/power/clock_ops.c | 85 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_clock.h       |  9 +++++
 2 files changed, 94 insertions(+)

diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
index 272a52ebafc0..5aa7365699c1 100644
--- a/drivers/base/power/clock_ops.c
+++ b/drivers/base/power/clock_ops.c
@@ -138,6 +138,58 @@ int pm_clk_add_clk(struct device *dev, struct clk *clk)
 }
 
 /**
+ * pm_clk_add_clks_of - Start using device clock(s) for power management.
+ * @dev: Device whose clock(s) is going to be used for power management.
+ *
+ * Add a series of clocks described in the 'clocks' device-tree node for
+ * a device to the list of clocks used for the power management of @dev.
+ */
+int pm_clk_add_clks_of(struct device *dev)
+{
+	struct clk **clks;
+	unsigned int i, count;
+	int ret;
+
+	if (!dev || !dev->of_node)
+		return -EINVAL;
+
+	count = of_count_phandle_with_args(dev->of_node, "clocks",
+					   "#clock-cells");
+	if (count == 0)
+		return -ENODEV;
+
+	clks = kcalloc(count, sizeof(*clks), GFP_KERNEL);
+	if (!clks)
+		return -ENOMEM;
+
+	for (i = 0; i < count; i++) {
+		clks[i] = of_clk_get(dev->of_node, i);
+		if (IS_ERR(clks[i])) {
+			ret = PTR_ERR(clks[i]);
+			goto error;
+		}
+
+		ret = pm_clk_add_clk(dev, clks[i]);
+		if (ret) {
+			clk_put(clks[i]);
+			goto error;
+		}
+	}
+
+	kfree(clks);
+
+	return 0;
+
+error:
+	while (i--)
+		pm_clk_remove_clk(dev, clks[i]);
+
+	kfree(clks);
+
+	return ret;
+}
+
+/**
  * __pm_clk_remove - Destroy PM clock entry.
  * @ce: PM clock entry to destroy.
  */
@@ -198,6 +250,39 @@ void pm_clk_remove(struct device *dev, const char *con_id)
 }
 
 /**
+ * pm_clk_remove_clk - Stop using a device clock for power management.
+ * @dev: Device whose clock should not be used for PM any more.
+ * @clk: Clock pointer
+ *
+ * Remove the clock pointed to by @clk from the list of clocks used for
+ * the power management of @dev.
+ */
+void pm_clk_remove_clk(struct device *dev, struct clk *clk)
+{
+	struct pm_subsys_data *psd = dev_to_psd(dev);
+	struct pm_clock_entry *ce;
+
+	if (!psd || !clk)
+		return;
+
+	spin_lock_irq(&psd->lock);
+
+	list_for_each_entry(ce, &psd->clock_list, node) {
+		if (clk == ce->clk)
+			goto remove;
+	}
+
+	spin_unlock_irq(&psd->lock);
+	return;
+
+ remove:
+	list_del(&ce->node);
+	spin_unlock_irq(&psd->lock);
+
+	__pm_clk_remove(ce);
+}
+
+/**
  * pm_clk_init - Initialize a device's list of power management clocks.
  * @dev: Device to initialize the list of PM clocks for.
  *
diff --git a/include/linux/pm_clock.h b/include/linux/pm_clock.h
index ffefbf2df1aa..6f609226bd85 100644
--- a/include/linux/pm_clock.h
+++ b/include/linux/pm_clock.h
@@ -42,7 +42,9 @@ extern int pm_clk_create(struct device *dev);
 extern void pm_clk_destroy(struct device *dev);
 extern int pm_clk_add(struct device *dev, const char *con_id);
 extern int pm_clk_add_clk(struct device *dev, struct clk *clk);
+extern int pm_clk_add_clks_of(struct device *dev);
 extern void pm_clk_remove(struct device *dev, const char *con_id);
+extern void pm_clk_remove_clk(struct device *dev, struct clk *clk);
 extern int pm_clk_suspend(struct device *dev);
 extern int pm_clk_resume(struct device *dev);
 #else
@@ -69,9 +71,16 @@ static inline int pm_clk_add_clk(struct device *dev, struct clk *clk)
 {
 	return -EINVAL;
 }
+static inline int pm_clk_add_clks_of(struct device *dev)
+{
+	return -EINVAL;
+}
 static inline void pm_clk_remove(struct device *dev, const char *con_id)
 {
 }
+static inline void pm_clk_remove_clk(struct device *dev, struct clk *clk)
+{
+}
 static inline int pm_clk_suspend(struct device *dev)
 {
 	return -EINVAL;
-- 
2.1.4
