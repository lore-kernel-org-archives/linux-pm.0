From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v7 03/13] clk: qcom: gdsc: Use PM clocks to control gdsc clocks
Date: Tue, 28 Jul 2015 15:03:56 +0530
Message-ID: <1438076046-4706-4-git-send-email-rnayak@codeaurora.org>
References: <1438076046-4706-1-git-send-email-rnayak@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1438076046-4706-1-git-send-email-rnayak@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: sboyd@codeaurora.org, mturquette@baylibre.com
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, georgi.djakov@linaro.org, svarbanov@mm-sol.com, srinivas.kandagatla@linaro.org, sviau@codeaurora.org, Rajendra Nayak <rnayak@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

The devices within a gdsc power domain, quite often have additional
clocks to be turned on/off along with the power domain itself.
Once the drivers for these devices are converted to use runtime PM,
it would be possible to remove all clock handling from the drivers if
the gdsc driver can handle it.
Use PM clocks to add support for this. A list of con_ids[] specified
per gdsc would be the clocks turned on/off on every device start/stop
callbacks.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 drivers/clk/qcom/gdsc.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/qcom/gdsc.h |  2 ++
 2 files changed, 44 insertions(+)

diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
index 3b11f4d..68b810a 100644
--- a/drivers/clk/qcom/gdsc.c
+++ b/drivers/clk/qcom/gdsc.c
@@ -16,6 +16,7 @@
 #include <linux/err.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
+#include <linux/pm_clock.h>
 #include <linux/pm_domain.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
@@ -108,6 +109,44 @@ static int gdsc_disable(struct generic_pm_domain *domain)
 	return gdsc_toggle_logic(sc, false);
 }
 
+static int gdsc_attach(struct generic_pm_domain *domain, struct device *dev)
+{
+	int ret;
+	struct gdsc *sc = domain_to_gdsc(domain);
+	const char **con_id;
+
+	if (!sc->con_ids[0])
+		return 0;
+
+	ret = pm_clk_create(dev);
+	if (ret) {
+		dev_dbg(dev, "pm_clk_create failed %d\n", ret);
+		return ret;
+	}
+
+	for (con_id = sc->con_ids; *con_id; con_id++) {
+		ret = pm_clk_add(dev, *con_id);
+		if (ret) {
+			dev_dbg(dev, "pm_clk_add failed %d\n", ret);
+			goto fail;
+		}
+	}
+	return 0;
+fail:
+	pm_clk_destroy(dev);
+	return ret;
+};
+
+static void gdsc_detach(struct generic_pm_domain *domain, struct device *dev)
+{
+	struct gdsc *sc = domain_to_gdsc(domain);
+
+	if (!sc->con_ids[0])
+		return;
+
+	pm_clk_destroy(dev);
+};
+
 static int gdsc_init(struct gdsc *sc)
 {
 	u32 mask, val;
@@ -131,6 +170,9 @@ static int gdsc_init(struct gdsc *sc)
 
 	sc->pd.power_off = gdsc_disable;
 	sc->pd.power_on = gdsc_enable;
+	sc->pd.attach_dev = gdsc_attach;
+	sc->pd.detach_dev = gdsc_detach;
+	sc->pd.flags = GENPD_FLAG_PM_CLK;
 	pm_genpd_init(&sc->pd, NULL, !on);
 
 	return 0;
diff --git a/drivers/clk/qcom/gdsc.h b/drivers/clk/qcom/gdsc.h
index f578a0c..68bcda3 100644
--- a/drivers/clk/qcom/gdsc.h
+++ b/drivers/clk/qcom/gdsc.h
@@ -24,11 +24,13 @@ struct regmap;
  * @pd: generic power domain
  * @regmap: regmap for MMIO accesses
  * @gdscr: gsdc control register
+ * @con_ids: List of clocks to be controlled for the gdsc
  */
 struct gdsc {
 	struct generic_pm_domain	pd;
 	struct regmap			*regmap;
 	unsigned int			gdscr;
+	const char			*con_ids[];
 };
 
 #ifdef CONFIG_QCOM_GDSC
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
