From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v7 02/13] clk: qcom: gdsc: Prepare common clk probe to register gdscs
Date: Tue, 28 Jul 2015 15:03:55 +0530
Message-ID: <1438076046-4706-3-git-send-email-rnayak@codeaurora.org>
References: <1438076046-4706-1-git-send-email-rnayak@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1438076046-4706-1-git-send-email-rnayak@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: sboyd@codeaurora.org, mturquette@baylibre.com
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, georgi.djakov@linaro.org, svarbanov@mm-sol.com, srinivas.kandagatla@linaro.org, sviau@codeaurora.org, Rajendra Nayak <rnayak@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

The common clk probe registers a clk provider and a reset controller.
Update it to register a genpd provider using the gdsc data provided
by each platform.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 drivers/clk/qcom/common.c | 15 ++++++++++++++-
 drivers/clk/qcom/common.h |  2 ++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
index f7101e3..a319aa8 100644
--- a/drivers/clk/qcom/common.c
+++ b/drivers/clk/qcom/common.c
@@ -21,6 +21,7 @@
 #include "clk-rcg.h"
 #include "clk-regmap.h"
 #include "reset.h"
+#include "gdsc.h"
 
 struct qcom_cc {
 	struct qcom_reset_controller reset;
@@ -120,8 +121,19 @@ int qcom_cc_really_probe(struct platform_device *pdev,
 
 	ret = reset_controller_register(&reset->rcdev);
 	if (ret)
-		of_clk_del_provider(dev->of_node);
+		goto err_reset;
 
+	if (desc->gdscs && desc->num_gdscs) {
+		ret = gdsc_register(dev, desc->gdscs, desc->num_gdscs, regmap);
+		if (ret)
+			goto err_pd;
+	}
+
+	return 0;
+err_pd:
+	reset_controller_unregister(&reset->rcdev);
+err_reset:
+	of_clk_del_provider(dev->of_node);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(qcom_cc_really_probe);
@@ -140,6 +152,7 @@ EXPORT_SYMBOL_GPL(qcom_cc_probe);
 
 void qcom_cc_remove(struct platform_device *pdev)
 {
+	gdsc_unregister(&pdev->dev);
 	of_clk_del_provider(pdev->dev.of_node);
 	reset_controller_unregister(platform_get_drvdata(pdev));
 }
diff --git a/drivers/clk/qcom/common.h b/drivers/clk/qcom/common.h
index 7a0e737..2892b71f 100644
--- a/drivers/clk/qcom/common.h
+++ b/drivers/clk/qcom/common.h
@@ -28,6 +28,8 @@ struct qcom_cc_desc {
 	size_t num_clks;
 	const struct qcom_reset_map *resets;
 	size_t num_resets;
+	struct gdsc **gdscs;
+	size_t num_gdscs;
 };
 
 extern const struct freq_tbl *qcom_find_freq(const struct freq_tbl *f,
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
