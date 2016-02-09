From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 06/16] PM / OPP: Manage device clk
Date: Tue,  9 Feb 2016 10:30:38 +0530
Message-ID: <a6c611233688c6be68a085c3203b42604ee5d704.1454992186.git.viresh.kumar@linaro.org>
References: <cover.1454992186.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1454992186.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1454992186.git.viresh.kumar@linaro.org>
References: <cover.1454992186.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, nm@ti.com, Viresh Kumar <viresh.kumar@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Viresh Kumar <vireshk@kernel.org>
List-Id: linux-pm@vger.kernel.org

OPP core has got almost everything now to manage device's OPP
transitions, the only thing left is device's clk. Get that as well.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/base/power/opp/core.c | 15 +++++++++++++++
 drivers/base/power/opp/opp.h  |  3 +++
 2 files changed, 18 insertions(+)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index 4fafa733a1c7..7d7749ce1ce4 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -13,6 +13,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/clk.h>
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <linux/slab.h>
@@ -583,6 +584,7 @@ static struct device_opp *_add_device_opp(struct device *dev)
 	struct device_opp *dev_opp;
 	struct device_list_opp *list_dev;
 	struct device_node *np;
+	int ret;
 
 	/* Check for existing list for 'dev' first */
 	dev_opp = _find_device_opp(dev);
@@ -620,6 +622,15 @@ static struct device_opp *_add_device_opp(struct device *dev)
 		of_node_put(np);
 	}
 
+	/* Find clk for the device */
+	dev_opp->clk = clk_get(dev, NULL);
+	if (IS_ERR(dev_opp->clk)) {
+		ret = PTR_ERR(dev_opp->clk);
+		if (ret != -EPROBE_DEFER)
+			dev_dbg(dev, "%s: Couldn't find clock: %d\n", __func__,
+				ret);
+	}
+
 	srcu_init_notifier_head(&dev_opp->srcu_head);
 	INIT_LIST_HEAD(&dev_opp->opp_list);
 
@@ -661,6 +672,10 @@ static void _remove_device_opp(struct device_opp *dev_opp)
 	if (!IS_ERR_OR_NULL(dev_opp->regulator))
 		return;
 
+	/* Release clk */
+	if (!IS_ERR(dev_opp->clk))
+		clk_put(dev_opp->clk);
+
 	list_dev = list_first_entry(&dev_opp->dev_list, struct device_list_opp,
 				    node);
 
diff --git a/drivers/base/power/opp/opp.h b/drivers/base/power/opp/opp.h
index fe44beb404ba..4f1bdfc7da03 100644
--- a/drivers/base/power/opp/opp.h
+++ b/drivers/base/power/opp/opp.h
@@ -22,6 +22,7 @@
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
 
+struct clk;
 struct regulator;
 
 /* Lock to allow exclusive modification to the device and opp lists */
@@ -134,6 +135,7 @@ struct device_list_opp {
  * @supported_hw: Array of version number to support.
  * @supported_hw_count: Number of elements in supported_hw array.
  * @prop_name: A name to postfix to many DT properties, while parsing them.
+ * @clk: Device's clock handle
  * @regulator: Supply regulator
  * @dentry:	debugfs dentry pointer of the real device directory (not links).
  * @dentry_name: Name of the real dentry.
@@ -168,6 +170,7 @@ struct device_opp {
 	unsigned int *supported_hw;
 	unsigned int supported_hw_count;
 	const char *prop_name;
+	struct clk *clk;
 	struct regulator *regulator;
 
 #ifdef CONFIG_DEBUG_FS
-- 
2.7.1.370.gb2aa7f8
