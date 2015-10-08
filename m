From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v3 4/9] clk: qcom: create virtual child device for TSENS
Date: Thu,  8 Oct 2015 10:31:03 +0530
Message-ID: <1444280468-17159-5-git-send-email-rnayak@codeaurora.org>
References: <1444280468-17159-1-git-send-email-rnayak@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1444280468-17159-1-git-send-email-rnayak@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, rui.zhang@intel.com, edubezval@gmail.com
Cc: sboyd@codeaurora.org, srinivas.kandagatla@linaro.org, nrajan@codeaurora.org, lina.iyer@linaro.org, punit.agrawal@arm.com, Rajendra Nayak <rnayak@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

8960 family of devices have TSENS as part of GCC in hardware.
Hence DT would represent a GCC node with GCC properties as well
as TSENS. Create a virtual platform child device here for TSENS
so the driver can probe it and use the parent (GCC) to extract DT
properties.

Suggested-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 drivers/clk/qcom/gcc-msm8960.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/gcc-msm8960.c b/drivers/clk/qcom/gcc-msm8960.c
index aa294b1..86d85e5 100644
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
@@ -3520,11 +3522,26 @@ static int gcc_msm8960_probe(struct platform_device *pdev)
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
-	return qcom_cc_probe(pdev, match->data);
+	ret = qcom_cc_probe(pdev, match->data);
+	if (ret)
+		return ret;
+
+	tsens = platform_device_register_data(&pdev->dev, "qcom-tsens", -1,
+					      NULL, 0);
+	if (IS_ERR(tsens)) {
+		qcom_cc_remove(pdev);
+		return PTR_ERR(tsens);
+	}
+	platform_set_drvdata(pdev, tsens);
+
+	return 0;
 }
 
 static int gcc_msm8960_remove(struct platform_device *pdev)
 {
+	struct platform_device *tsens = platform_get_drvdata(pdev);
+
+	platform_device_unregister(tsens);
 	qcom_cc_remove(pdev);
 	return 0;
 }
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
