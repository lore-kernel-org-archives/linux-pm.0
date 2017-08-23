From: Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH 3/7] PM / OPP: rename opp_table->clk to opp_table->cur_clk
Date: Thu, 24 Aug 2017 00:10:06 +0800
Message-ID: <1503504610-12880-4-git-send-email-aisheng.dong@nxp.com>
References: <1503504610-12880-1-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1503504610-12880-1-git-send-email-aisheng.dong@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, sboyd@codeaurora.org, vireshk@kernel.org, nm@ti.com, rjw@rjwysocki.net, shawnguo@kernel.org, Anson.Huang@nxp.com, ping.bai@nxp.com, Dong Aisheng <aisheng.dong@nxp.com>
List-Id: linux-pm@vger.kernel.org

Since we now support per OPP clocks, we rename opp_table->clk to
opp_table->cur_clk to make it less confusing as the opp_table->clk
will become only represent the current clock of the current OPP
on which the device is running.

Cc: Viresh Kumar <vireshk@kernel.org>
Cc: Nishanth Menon <nm@ti.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/base/power/opp/core.c | 30 +++++++++++++++---------------
 drivers/base/power/opp/opp.h  |  4 ++--
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index 37cf970..2579401 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -527,9 +527,9 @@ _generic_set_opp_clk_only(const struct opp_table *opp_table, struct device *dev,
 	int ret;
 
 	if (opp_table->set_clk)
-		return opp_table->set_clk(dev, opp_table->clk, old_freq, freq);
+		return opp_table->set_clk(dev, opp_table->cur_clk, old_freq, freq);
 
-	ret = clk_set_rate(opp_table->clk, freq);
+	ret = clk_set_rate(opp_table->cur_clk, freq);
 	if (ret) {
 		dev_err(dev, "%s: failed to set clock rate: %d\n", __func__,
 			ret);
@@ -615,7 +615,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 		return PTR_ERR(opp_table);
 	}
 
-	clk = opp_table->clk;
+	clk = opp_table->cur_clk;
 	if (IS_ERR(clk)) {
 		dev_err(dev, "%s: No clock available for the device\n",
 			__func__);
@@ -750,9 +750,9 @@ static struct opp_table *_allocate_opp_table(struct device *dev)
 	_of_init_opp_table(opp_table, dev);
 
 	/* Find clk for the device */
-	opp_table->clk = clk_get(dev, NULL);
-	if (IS_ERR(opp_table->clk)) {
-		ret = PTR_ERR(opp_table->clk);
+	opp_table->cur_clk = clk_get(dev, NULL);
+	if (IS_ERR(opp_table->cur_clk)) {
+		ret = PTR_ERR(opp_table->cur_clk);
 		if (ret != -EPROBE_DEFER)
 			dev_dbg(dev, "%s: Couldn't find clock: %d\n", __func__,
 				ret);
@@ -799,8 +799,8 @@ static void _opp_table_kref_release(struct kref *kref)
 	struct opp_device *opp_dev;
 
 	/* Release clk */
-	if (!IS_ERR(opp_table->clk))
-		clk_put(opp_table->clk);
+	if (!IS_ERR(opp_table->cur_clk))
+		clk_put(opp_table->cur_clk);
 
 	opp_dev = list_first_entry(&opp_table->dev_list, struct opp_device,
 				   node);
@@ -1393,13 +1393,13 @@ struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char *name)
 	}
 
 	/* Already have default clk set, free it */
-	if (!IS_ERR(opp_table->clk))
-		clk_put(opp_table->clk);
+	if (!IS_ERR(opp_table->cur_clk))
+		clk_put(opp_table->cur_clk);
 
 	/* Find clk for the device */
-	opp_table->clk = clk_get(dev, name);
-	if (IS_ERR(opp_table->clk)) {
-		ret = PTR_ERR(opp_table->clk);
+	opp_table->cur_clk = clk_get(dev, name);
+	if (IS_ERR(opp_table->cur_clk)) {
+		ret = PTR_ERR(opp_table->cur_clk);
 		if (ret != -EPROBE_DEFER) {
 			dev_err(dev, "%s: Couldn't find clock: %d\n", __func__,
 				ret);
@@ -1425,8 +1425,8 @@ void dev_pm_opp_put_clkname(struct opp_table *opp_table)
 	/* Make sure there are no concurrent readers while updating opp_table */
 	WARN_ON(!list_empty(&opp_table->opp_list));
 
-	clk_put(opp_table->clk);
-	opp_table->clk = ERR_PTR(-EINVAL);
+	clk_put(opp_table->cur_clk);
+	opp_table->cur_clk = ERR_PTR(-EINVAL);
 
 	dev_pm_opp_put_opp_table(opp_table);
 }
diff --git a/drivers/base/power/opp/opp.h b/drivers/base/power/opp/opp.h
index c85405e..30a637c 100644
--- a/drivers/base/power/opp/opp.h
+++ b/drivers/base/power/opp/opp.h
@@ -132,7 +132,7 @@ enum opp_table_access {
  * @supported_hw: Array of version number to support.
  * @supported_hw_count: Number of elements in supported_hw array.
  * @prop_name: A name to postfix to many DT properties, while parsing them.
- * @clk: Device's clock handle
+ * @cur_clk: Current device's clock handle
  * @regulators: Supply regulators
  * @regulator_count: Number of power supply regulators
  * @set_opp: Platform specific set_opp callback
@@ -169,7 +169,7 @@ struct opp_table {
 	unsigned int *supported_hw;
 	unsigned int supported_hw_count;
 	const char *prop_name;
-	struct clk *clk;
+	struct clk *cur_clk;
 	struct regulator **regulators;
 	unsigned int regulator_count;
 
-- 
2.7.4
