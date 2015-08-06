From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v8 11/13] clk: qcom: gdsc: Use PM clocks to control gdsc clocks
Date: Thu,  6 Aug 2015 16:07:52 +0530
Message-ID: <1438857474-20262-12-git-send-email-rnayak@codeaurora.org>
References: <1438857474-20262-1-git-send-email-rnayak@codeaurora.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:38932 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932261AbbHFKkI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 6 Aug 2015 06:40:08 -0400
In-Reply-To: <1438857474-20262-1-git-send-email-rnayak@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sboyd@codeaurora.org, mturquette@baylibre.com
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, georgi.djakov@linaro.org, svarbanov@mm-sol.com, srinivas.kandagatla@linaro.org, sviau@codeaurora.org, Rajendra Nayak <rnayak@codeaurora.org>

The devices within a gdsc power domain, quite often have additional
clocks to be turned on/off along with the power domain itself.
Once the drivers for these devices are converted to use runtime PM,
it would be possible to remove all clock handling from the drivers if
the gdsc driver can handle it.
Use PM clocks to add support for this. A list of clock ids specified
per gdsc would be the clocks turned on/off on every device start/stop
callbacks.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 drivers/clk/qcom/gdsc.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/qcom/gdsc.h |  7 ++++++
 2 files changed, 65 insertions(+)

diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
index da9fad8..ec1dfb5 100644
--- a/drivers/clk/qcom/gdsc.c
+++ b/drivers/clk/qcom/gdsc.c
@@ -12,10 +12,12 @@
  */
 
 #include <linux/bitops.h>
+#include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
+#include <linux/pm_clock.h>
 #include <linux/pm_domain.h>
 #include <linux/regmap.h>
 #include <linux/reset-controller.h>
@@ -161,6 +163,59 @@ static int gdsc_disable(struct generic_pm_domain *domain)
 	return gdsc_toggle_logic(sc, false);
 }
 
+static inline bool match(unsigned int id, unsigned int *ids, unsigned int count)
+{
+	int i;
+
+	for (i = 0; i < count; i++)
+		if (id == ids[i])
+			return true;
+	return false;
+}
+
+static int gdsc_attach(struct generic_pm_domain *domain, struct device *dev)
+{
+	int ret, i = 0, j = 0;
+	struct gdsc *sc = domain_to_gdsc(domain);
+	struct of_phandle_args clkspec;
+	struct device_node *np = dev->of_node;
+
+	if (!sc->clock_count)
+		return 0;
+
+	ret = pm_clk_create(dev);
+	if (ret) {
+		dev_dbg(dev, "pm_clk_create failed %d\n", ret);
+		return ret;
+	}
+
+	sc->clks = devm_kcalloc(dev, sc->clock_count, sizeof(sc->clks),
+				       GFP_KERNEL);
+	if (!sc->clks)
+		return -ENOMEM;
+
+	while (!of_parse_phandle_with_args(np, "clocks", "#clock-cells", i,
+					   &clkspec)) {
+		if (match(clkspec.args[0], sc->clocks, sc->clock_count)) {
+			sc->clks[j] = of_clk_get_from_provider(&clkspec);
+			pm_clk_add_clk(dev, sc->clks[j]);
+			j++;
+		}
+		i++;
+	}
+	return 0;
+};
+
+static void gdsc_detach(struct generic_pm_domain *domain, struct device *dev)
+{
+	struct gdsc *sc = domain_to_gdsc(domain);
+
+	if (!sc->clock_count)
+		return;
+
+	pm_clk_destroy(dev);
+};
+
 static int gdsc_init(struct gdsc *sc)
 {
 	u32 mask, val;
@@ -196,6 +251,9 @@ static int gdsc_init(struct gdsc *sc)
 
 	sc->pd.power_off = gdsc_disable;
 	sc->pd.power_on = gdsc_enable;
+	sc->pd.attach_dev = gdsc_attach;
+	sc->pd.detach_dev = gdsc_detach;
+	sc->pd.flags = GENPD_FLAG_PM_CLK;
 	pm_genpd_init(&sc->pd, NULL, !on);
 
 	return 0;
diff --git a/drivers/clk/qcom/gdsc.h b/drivers/clk/qcom/gdsc.h
index 5ded268..2fdb332 100644
--- a/drivers/clk/qcom/gdsc.h
+++ b/drivers/clk/qcom/gdsc.h
@@ -17,6 +17,7 @@
 #include <linux/err.h>
 #include <linux/pm_domain.h>
 
+struct clk;
 struct regmap;
 struct reset_controller_dev;
 
@@ -38,6 +39,9 @@ struct reset_controller_dev;
  * @resets: ids of resets associated with this gdsc
  * @reset_count: number of @resets
  * @rcdev: reset controller
+ * @clocks: ids of clocks associated with the gdsc
+ * @clock_count: number of @clocks
+ * @clks: clock pointers to gdsc clocks
  */
 struct gdsc {
 	struct generic_pm_domain	pd;
@@ -49,6 +53,9 @@ struct gdsc {
 	struct reset_controller_dev	*rcdev;
 	unsigned int			*resets;
 	unsigned int			reset_count;
+	unsigned int			*clocks;
+	unsigned int			clock_count;
+	struct clk			**clks;
 };
 
 #ifdef CONFIG_QCOM_GDSC
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

