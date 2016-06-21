From: Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH] PM / clk: Add support for adding a specific clock from device-tree
Date: Tue, 21 Jun 2016 11:33:25 +0100
Message-ID: <1466505205-20115-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:9132 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751644AbcFUKf0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jun 2016 06:35:26 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>

Some drivers using the PM clocks framework need to add specific clocks
from device-tree using a name by calling the functions
of_clk_get_by_name() and then pm_clk_add_clk(). Rather than having
drivers call both functions, add a helper function of_pm_clk_add_clk()
that will call these functions so drivers can call a single function
to add a specific clock from device-tree.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---

Some examples of drivers that would be able to make use of this new
function are drivers/dma/tegra210-adma.c and
drivers/irqchip/irq-gic-pm.c.

 drivers/base/power/clock_ops.c | 32 ++++++++++++++++++++++++++++++++
 include/linux/pm_clock.h       |  1 +
 2 files changed, 33 insertions(+)

diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
index 761f5c21f9f0..8e2e4757adcb 100644
--- a/drivers/base/power/clock_ops.c
+++ b/drivers/base/power/clock_ops.c
@@ -141,6 +141,38 @@ EXPORT_SYMBOL_GPL(pm_clk_add_clk);
 
 
 /**
+ * of_pm_clk_add_clk - Start using a device clock for power management.
+ * @dev: Device whose clock is going to be used for power management.
+ * @name: Name of clock that is going to be used for power management.
+ *
+ * Add the clock described in the 'clocks' device-tree node that matches
+ * with the 'name' provided, to the list of clocks used for the power
+ * management of @dev. On success, returns 0. Returns a negative error
+ * code if the clock is not found or cannot be added.
+ */
+int of_pm_clk_add_clk(struct device *dev, const char *name)
+{
+	struct clk *clk;
+	int ret;
+
+	if (!dev || !dev->of_node || !name)
+		return -EINVAL;
+
+	clk = of_clk_get_by_name(dev->of_node, name);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	ret = pm_clk_add_clk(dev, clk);
+	if (ret) {
+		clk_put(clk);
+		return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(of_pm_clk_add_clk);
+
+/**
  * of_pm_clk_add_clks - Start using device clock(s) for power management.
  * @dev: Device whose clock(s) is going to be used for power management.
  *
diff --git a/include/linux/pm_clock.h b/include/linux/pm_clock.h
index 308d6044f153..09779b0ae720 100644
--- a/include/linux/pm_clock.h
+++ b/include/linux/pm_clock.h
@@ -42,6 +42,7 @@ extern int pm_clk_create(struct device *dev);
 extern void pm_clk_destroy(struct device *dev);
 extern int pm_clk_add(struct device *dev, const char *con_id);
 extern int pm_clk_add_clk(struct device *dev, struct clk *clk);
+extern int of_pm_clk_add_clk(struct device *dev, const char *name);
 extern int of_pm_clk_add_clks(struct device *dev);
 extern void pm_clk_remove(struct device *dev, const char *con_id);
 extern void pm_clk_remove_clk(struct device *dev, struct clk *clk);
-- 
2.1.4

