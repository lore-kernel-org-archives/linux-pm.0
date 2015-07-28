From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v7 05/13] clk: qcom: gdsc: Enable an RCG before turing on the gdsc
Date: Tue, 28 Jul 2015 15:03:58 +0530
Message-ID: <1438076046-4706-6-git-send-email-rnayak@codeaurora.org>
References: <1438076046-4706-1-git-send-email-rnayak@codeaurora.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:57416 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755260AbbG1JfR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jul 2015 05:35:17 -0400
In-Reply-To: <1438076046-4706-1-git-send-email-rnayak@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sboyd@codeaurora.org, mturquette@baylibre.com
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, georgi.djakov@linaro.org, svarbanov@mm-sol.com, srinivas.kandagatla@linaro.org, sviau@codeaurora.org, Rajendra Nayak <rnayak@codeaurora.org>

Some gdsc instances require a certain root clock (RCG) to be turned on
*before* the power domain itself can be turned on. Handle this as part
of the gdsc enable/disable callbacks.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 drivers/clk/qcom/gdsc.c | 20 +++++++++++++++++++-
 drivers/clk/qcom/gdsc.h |  5 +++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
index c7f109b..b802ecf 100644
--- a/drivers/clk/qcom/gdsc.c
+++ b/drivers/clk/qcom/gdsc.c
@@ -89,6 +89,9 @@ static int gdsc_enable(struct generic_pm_domain *domain)
 	struct gdsc *sc = domain_to_gdsc(domain);
 	int ret;
 
+	if (sc->root_clk)
+		clk_prepare_enable(sc->root_clk);
+
 	ret = gdsc_toggle_logic(sc, true);
 	if (ret)
 		return ret;
@@ -106,9 +109,15 @@ static int gdsc_enable(struct generic_pm_domain *domain)
 
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
@@ -133,6 +142,15 @@ static int gdsc_attach(struct generic_pm_domain *domain, struct device *dev)
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
index 68bcda3..cbd95e4 100644
--- a/drivers/clk/qcom/gdsc.h
+++ b/drivers/clk/qcom/gdsc.h
@@ -17,6 +17,7 @@
 #include <linux/err.h>
 #include <linux/pm_domain.h>
 
+struct clk;
 struct regmap;
 
 /**
@@ -24,12 +25,16 @@ struct regmap;
  * @pd: generic power domain
  * @regmap: regmap for MMIO accesses
  * @gdscr: gsdc control register
+ * @root_con_id: root clock to be enabled
+ * @root_clk: clk handle for the root clk
  * @con_ids: List of clocks to be controlled for the gdsc
  */
 struct gdsc {
 	struct generic_pm_domain	pd;
 	struct regmap			*regmap;
 	unsigned int			gdscr;
+	char				*root_con_id;
+	struct clk			*root_clk;
 	const char			*con_ids[];
 };
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

