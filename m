From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v6 02/13] clk: qcom: gdsc: Prepare common clk probe to register gdscs
Date: Wed, 22 Jul 2015 12:40:58 +0530
Message-ID: <1437549069-29655-3-git-send-email-rnayak@codeaurora.org>
References: <1437549069-29655-1-git-send-email-rnayak@codeaurora.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:60295 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755889AbbGVHLg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 Jul 2015 03:11:36 -0400
In-Reply-To: <1437549069-29655-1-git-send-email-rnayak@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sboyd@codeaurora.org, mturquette@baylibre.com
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, georgi.djakov@linaro.org, svarbanov@mm-sol.com, srinivas.kandagatla@linaro.org, sviau@codeaurora.org, Rajendra Nayak <rnayak@codeaurora.org>

The common clk probe registers a clk provider and a reset controller.
Update it to register a genpd provider using the gdsc data provided
by each platform.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 drivers/clk/qcom/common.c | 16 +++++++++++++++-
 drivers/clk/qcom/common.h |  2 ++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
index f7101e3..2776679 100644
--- a/drivers/clk/qcom/common.c
+++ b/drivers/clk/qcom/common.c
@@ -21,6 +21,7 @@
 #include "clk-rcg.h"
 #include "clk-regmap.h"
 #include "reset.h"
+#include "gdsc.h"
 
 struct qcom_cc {
 	struct qcom_reset_controller reset;
@@ -120,8 +121,20 @@ int qcom_cc_really_probe(struct platform_device *pdev,
 
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
+	dev_err(dev, "Failed to register power domains\n");
+	reset_controller_unregister(&reset->rcdev);
+err_reset:
+	of_clk_del_provider(dev->of_node);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(qcom_cc_really_probe);
@@ -140,6 +153,7 @@ EXPORT_SYMBOL_GPL(qcom_cc_probe);
 
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

