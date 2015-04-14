From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v5 10/11] clk: qcom: gdsc: Enable an RCG before turning on the gdsc
Date: Tue, 14 Apr 2015 18:42:16 +0530
Message-ID: <1429017137-20218-11-git-send-email-rnayak@codeaurora.org>
References: <1429017137-20218-1-git-send-email-rnayak@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1429017137-20218-1-git-send-email-rnayak@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: sboyd@codeaurora.org, mturquette@linaro.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, georgi.djakov@linaro.org, svarbanov@mm-sol.com, srinivas.kandagatla@linaro.org, sviau@codeaurora.org, Rajendra Nayak <rnayak@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

Some gdsc instances require a certain root clock (RCG) to be turned on *before*
the power domain itself can be turned on. Handle this as part of the gdsc
enable/disable callbacks.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 drivers/clk/qcom/gdsc.c | 20 +++++++++++++++++++-
 drivers/clk/qcom/gdsc.h |  3 +++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
index ab55310..480ebf6 100644
--- a/drivers/clk/qcom/gdsc.c
+++ b/drivers/clk/qcom/gdsc.c
@@ -83,6 +83,9 @@ static int gdsc_enable(struct generic_pm_domain *domain)
 	struct gdsc *sc = domain_to_gdsc(domain);
 	int ret;
 
+	if (sc->root_clk)
+		clk_prepare_enable(sc->root_clk);
+
 	ret = gdsc_toggle_logic(sc, true);
 	if (ret)
 		return ret;
@@ -100,9 +103,15 @@ static int gdsc_enable(struct generic_pm_domain *domain)
 
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
@@ -127,6 +136,15 @@ static int gdsc_attach(struct generic_pm_domain *domain, struct device *dev)
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
index 734f341..1ad9d53 100644
--- a/drivers/clk/qcom/gdsc.h
+++ b/drivers/clk/qcom/gdsc.h
@@ -14,6 +14,7 @@
 #ifndef __QCOM_GDSC_H__
 #define __QCOM_GDSC_H__
 
+#include <linux/clk.h>
 #include <linux/pm_domain.h>
 #include <linux/regmap.h>
 
@@ -28,6 +29,8 @@ struct gdsc {
 	struct generic_pm_domain	pd;
 	struct regmap			*regmap;
 	unsigned int			gdscr;
+	char				*root_con_id;
+	struct clk			*root_clk;
 	char				*con_ids[];
 };
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
