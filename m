From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v6 05/13] clk: qcom: gdsc: Enable an RCG before turing on the gdsc
Date: Wed, 22 Jul 2015 12:41:01 +0530
Message-ID: <1437549069-29655-6-git-send-email-rnayak@codeaurora.org>
References: <1437549069-29655-1-git-send-email-rnayak@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1437549069-29655-1-git-send-email-rnayak@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: sboyd@codeaurora.org, mturquette@baylibre.com
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, georgi.djakov@linaro.org, svarbanov@mm-sol.com, srinivas.kandagatla@linaro.org, sviau@codeaurora.org, Rajendra Nayak <rnayak@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

Some gdsc instances require a certain root clock (RCG) to be turned on
*before* the power domain itself can be turned on. Handle this as part
of the gdsc enable/disable callbacks.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 drivers/clk/qcom/gdsc.c | 20 +++++++++++++++++++-
 drivers/clk/qcom/gdsc.h |  5 +++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
index 9ddd2f8..fc0aa7c 100644
--- a/drivers/clk/qcom/gdsc.c
+++ b/drivers/clk/qcom/gdsc.c
@@ -84,6 +84,9 @@ static int gdsc_enable(struct generic_pm_domain *domain)
 	struct gdsc *sc = domain_to_gdsc(domain);
 	int ret;
 
+	if (sc->root_clk)
+		clk_prepare_enable(sc->root_clk);
+
 	ret = gdsc_toggle_logic(sc, true);
 	if (ret)
 		return ret;
@@ -101,9 +104,15 @@ static int gdsc_enable(struct generic_pm_domain *domain)
 
 static int gdsc_disable(struct generic_pm_domain *domain)
 {
+	int ret;
 	struct gdsc *sc = domain_to_gdsc(domain);
 
-	return gdsc_toggle_logic(sc, false);
+	ret = gdsc_toggle_logic(sc, false);
+
+	if (sc->root_clk)
+		clk_disable_unprepare(sc->root_clk);
+
+	return ret;
 }
 
 static int gdsc_attach(struct generic_pm_domain *domain, struct device *dev)
@@ -125,6 +134,15 @@ static int gdsc_attach(struct generic_pm_domain *domain, struct device *dev)
 			goto fail;
 		}
 	}
+
+	if (sc->root_con_id) {
+		sc->root_clk = clk_get(dev, sc->root_con_id);
+		if (IS_ERR(sc->root_clk)) {
+			dev_err(dev, "failed to get root clock\n");
+			return PTR_ERR(sc->root_clk);
+		}
+	}
+
 	return 0;
 fail:
 	pm_clk_destroy(dev);
diff --git a/drivers/clk/qcom/gdsc.h b/drivers/clk/qcom/gdsc.h
index e26a496..a3abbea 100644
--- a/drivers/clk/qcom/gdsc.h
+++ b/drivers/clk/qcom/gdsc.h
@@ -14,6 +14,7 @@
 #ifndef __QCOM_GDSC_H__
 #define __QCOM_GDSC_H__
 
+#include <linux/clk.h>
 #include <linux/pm_domain.h>
 #include <linux/regmap.h>
 
@@ -22,11 +23,15 @@
  * @pd: generic power domain
  * @regmap: regmap for MMIO accesses
  * @gdscr: gsdc control register
+ * @root_con_id: root clock to be enabled
+ * @root_clk: clk handle for the root clk
  */
 struct gdsc {
 	struct generic_pm_domain	pd;
 	struct regmap			*regmap;
 	unsigned int			gdscr;
+	char				*root_con_id;
+	struct clk			*root_clk;
 };
 
 #ifdef CONFIG_QCOM_GDSC
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
