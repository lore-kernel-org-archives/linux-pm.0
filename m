From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH V4] PM / clk: Add support for obtaining clocks from device-tree
Date: Tue, 15 Mar 2016 11:33:40 +0000
Message-ID: <1458041620-27066-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

The PM clocks framework requires clients to pass either a con-id or a
valid clk pointer in order to add a clock to a device. Add a new
function of_pm_clk_add_clks() to allows device clocks to be retrieved
from device-tree and populated for a given device. Note that it is
not necessary to make the compilation of this new function dependent
upon CONFIG_OF because there are stubs functions for the device-tree
APIs used.

In order to handle errors encountered when adding clocks from
device-tree, add a function pm_clk_remove_clk() to remove any clocks
(using a pointer to the clk structure) that have been added
successfully before the error occurred.

Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---

Changes v3-v4:
- Droppped filter function because it is unclear if this will be used
  at this time. It can always be added later if needed.
- Change of_pm_clk_add_clks() to return the number of clocks added on
  success. Please note that this function will still return an error
  if the 'clocks' device-node is missing for a device or has no clocks.
  Although we discussed that may be we should simply return '0' for this
  case, after more thought, for drivers that always have clocks to add
  it means that they need to check if the return code is less than or
  equal to '0' and if equal to '0' then they cannot simply return the
  error code. Therefore, I wonder if users that may have optional clocks
  should check to see if the 'clocks' node is present before calling?

Changes v2-v3:
- Constified the of_phandle_args parameter
- Added data parameter to filter function

Changes v1-v2:
- Added support for optional filter function as suggested by Geert U.

 drivers/base/power/clock_ops.c | 89 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_clock.h       |  9 +++++
 2 files changed, 98 insertions(+)

diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
index 272a52ebafc0..0e64a1b5e62a 100644
--- a/drivers/base/power/clock_ops.c
+++ b/drivers/base/power/clock_ops.c
@@ -137,6 +137,62 @@ int pm_clk_add_clk(struct device *dev, struct clk *clk)
 	return __pm_clk_add(dev, NULL, clk);
 }
 
+
+/**
+ * of_pm_clk_add_clks - Start using device clock(s) for power management.
+ * @dev: Device whose clock(s) is going to be used for power management.
+ *
+ * Add a series of clocks described in the 'clocks' device-tree node for
+ * a device to the list of clocks used for the power management of @dev.
+ * On success, returns the number of clocks added. Returns a negative
+ * error code if there are no clocks in the device node for the device
+ * or if adding a clock fails.
+ */
+int of_pm_clk_add_clks(struct device *dev)
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
+	return i;
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
 /**
  * __pm_clk_remove - Destroy PM clock entry.
  * @ce: PM clock entry to destroy.
@@ -198,6 +254,39 @@ void pm_clk_remove(struct device *dev, const char *con_id)
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
index 25266c600021..308d6044f153 100644
--- a/include/linux/pm_clock.h
+++ b/include/linux/pm_clock.h
@@ -42,7 +42,9 @@ extern int pm_clk_create(struct device *dev);
 extern void pm_clk_destroy(struct device *dev);
 extern int pm_clk_add(struct device *dev, const char *con_id);
 extern int pm_clk_add_clk(struct device *dev, struct clk *clk);
+extern int of_pm_clk_add_clks(struct device *dev);
 extern void pm_clk_remove(struct device *dev, const char *con_id);
+extern void pm_clk_remove_clk(struct device *dev, struct clk *clk);
 extern int pm_clk_suspend(struct device *dev);
 extern int pm_clk_resume(struct device *dev);
 #else
@@ -69,11 +71,18 @@ static inline int pm_clk_add_clk(struct device *dev, struct clk *clk)
 {
 	return -EINVAL;
 }
+static inline int of_pm_clk_add_clks(struct device *dev)
+{
+	return -EINVAL;
+}
 static inline void pm_clk_remove(struct device *dev, const char *con_id)
 {
 }
 #define pm_clk_suspend	NULL
 #define pm_clk_resume	NULL
+static inline void pm_clk_remove_clk(struct device *dev, struct clk *clk)
+{
+}
 #endif
 
 #ifdef CONFIG_HAVE_CLK
-- 
2.1.4
