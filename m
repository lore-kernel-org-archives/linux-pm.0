From: Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH] clk: qcom: Make oxili GDSC parent of oxili_cx GDSC
Date: Wed, 23 Sep 2015 12:09:22 -0700
Message-ID: <1443035362-10914-1-git-send-email-sboyd@codeaurora.org>
Return-path: <linux-clk-owner@vger.kernel.org>
Sender: linux-clk-owner@vger.kernel.org
To: Mike Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

The oxili_cx GDSC is inside the power domain of the oxili GDSC.
Add the dependency so that the CX domain can properly power up.

Reported-by: Rob Clark <robdclark@gmail.com>
Cc: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clk/qcom/mmcc-msm8974.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/mmcc-msm8974.c b/drivers/clk/qcom/mmcc-msm8974.c
index fe8320dc41db..3613db0a73e3 100644
--- a/drivers/clk/qcom/mmcc-msm8974.c
+++ b/drivers/clk/qcom/mmcc-msm8974.c
@@ -2615,6 +2615,7 @@ MODULE_DEVICE_TABLE(of, mmcc_msm8974_match_table);
 static int mmcc_msm8974_probe(struct platform_device *pdev)
 {
 	struct regmap *regmap;
+	int ret;
 
 	regmap = qcom_cc_map(pdev, &mmcc_msm8974_desc);
 	if (IS_ERR(regmap))
@@ -2623,7 +2624,14 @@ static int mmcc_msm8974_probe(struct platform_device *pdev)
 	clk_pll_configure_sr_hpm_lp(&mmpll1, regmap, &mmpll1_config, true);
 	clk_pll_configure_sr_hpm_lp(&mmpll3, regmap, &mmpll3_config, false);
 
-	return qcom_cc_really_probe(pdev, &mmcc_msm8974_desc, regmap);
+	ret = qcom_cc_really_probe(pdev, &mmcc_msm8974_desc, regmap);
+	if (ret)
+		return ret;
+
+	ret = pm_genpd_add_subdomain(&oxili_gdsc.pd, &oxilicx_gdsc.pd);
+	if (ret)
+		qcom_cc_remove(pdev);
+	return ret;
 }
 
 static int mmcc_msm8974_remove(struct platform_device *pdev)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

