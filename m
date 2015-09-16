From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v2 4/9] clk: qcom: create virtual child device for TSENS
Date: Wed, 16 Sep 2015 11:53:18 +0530
Message-ID: <1442384603-26053-5-git-send-email-rnayak@codeaurora.org>
References: <1442384603-26053-1-git-send-email-rnayak@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1442384603-26053-1-git-send-email-rnayak@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, rui.zhang@intel.com, edubezval@gmail.com
Cc: sboyd@codeaurora.org, srinivas.kandagatla@linaro.org, nrajan@codeaurora.org, lina.iyer@linaro.org, Rajendra Nayak <rnayak@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

8960 family of devices have TSENS as part of GCC in hardware.
Hence DT would represent a GCC node with GCC properties as well
as TSENS. Create a virtual platform child device here for TSENS
so the driver can probe it and use the parent (GCC) to extract DT
properties.

Suggested-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 drivers/clk/qcom/gcc-msm8960.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/gcc-msm8960.c b/drivers/clk/qcom/gcc-msm8960.c
index aa294b1..51db3a5 100644
--- a/drivers/clk/qcom/gcc-msm8960.c
+++ b/drivers/clk/qcom/gcc-msm8960.c
@@ -3506,6 +3506,8 @@ static int gcc_msm8960_probe(struct platform_device *pdev)
 	struct clk *clk;
 	struct device *dev = &pdev->dev;
 	const struct of_device_id *match;
+	struct platform_device *tsens;
+	int ret;
 
 	match = of_match_device(gcc_msm8960_match_table, &pdev->dev);
 	if (!match)
@@ -3520,7 +3522,26 @@ static int gcc_msm8960_probe(struct platform_device *pdev)
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
-	return qcom_cc_probe(pdev, match->data);
+	ret = qcom_cc_probe(pdev, match->data);
+	if (ret)
+		return ret;
+
+	tsens = platform_device_alloc("qcom-tsens", -1);
+	if (!tsens) {
+		ret = -ENOMEM;
+		goto err_alloc;
+	}
+
+	tsens->dev.parent = &pdev->dev;
+	ret = platform_device_add(tsens);
+	if (ret)
+		goto err_add;
+	return 0;
+err_add:
+	platform_device_put(tsens);
+err_alloc:
+	qcom_cc_remove(pdev);
+	return ret;
 }
 
 static int gcc_msm8960_remove(struct platform_device *pdev)
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
