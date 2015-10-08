From: Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH] clk: qcom: Drop calls to qcom_cc_remove()
Date: Thu,  8 Oct 2015 00:17:58 -0700
Message-ID: <1444288678-24594-1-git-send-email-sboyd@codeaurora.org>
References: <20151008070345.GF26883@codeaurora.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:48581 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752902AbbJHHSC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 8 Oct 2015 03:18:02 -0400
In-Reply-To: <20151008070345.GF26883@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, rui.zhang@intel.com, edubezval@gmail.com, srinivas.kandagatla@linaro.org, nrajan@codeaurora.org, lina.iyer@linaro.org, punit.agrawal@arm.com

Now that qcom_cc_remove() is a nop, drop calls to
qcom_cc_remove() and any empty driver remove functions.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---

And here's the driver part. I left 8960_remove in place to make your patch
easier to apply. Time to sleep.

 drivers/clk/qcom/common.c       | 5 -----
 drivers/clk/qcom/common.h       | 2 --
 drivers/clk/qcom/gcc-apq8084.c  | 7 -------
 drivers/clk/qcom/gcc-ipq806x.c  | 7 -------
 drivers/clk/qcom/gcc-msm8660.c  | 7 -------
 drivers/clk/qcom/gcc-msm8916.c  | 7 -------
 drivers/clk/qcom/gcc-msm8960.c  | 1 -
 drivers/clk/qcom/gcc-msm8974.c  | 7 -------
 drivers/clk/qcom/lcc-ipq806x.c  | 7 -------
 drivers/clk/qcom/lcc-msm8960.c  | 7 -------
 drivers/clk/qcom/mmcc-apq8084.c | 7 -------
 drivers/clk/qcom/mmcc-msm8960.c | 7 -------
 drivers/clk/qcom/mmcc-msm8974.c | 6 +-----
 13 files changed, 1 insertion(+), 76 deletions(-)

diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
index 327d2e5d9f1c..8fa477293ae0 100644
--- a/drivers/clk/qcom/common.c
+++ b/drivers/clk/qcom/common.c
@@ -168,9 +168,4 @@ int qcom_cc_probe(struct platform_device *pdev, const struct qcom_cc_desc *desc)
 }
 EXPORT_SYMBOL_GPL(qcom_cc_probe);
 
-void qcom_cc_remove(struct platform_device *pdev)
-{
-}
-EXPORT_SYMBOL_GPL(qcom_cc_remove);
-
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/clk/qcom/common.h b/drivers/clk/qcom/common.h
index 2892b71fbd71..7c1fba3ebc03 100644
--- a/drivers/clk/qcom/common.h
+++ b/drivers/clk/qcom/common.h
@@ -45,6 +45,4 @@ extern int qcom_cc_really_probe(struct platform_device *pdev,
 extern int qcom_cc_probe(struct platform_device *pdev,
 			 const struct qcom_cc_desc *desc);
 
-extern void qcom_cc_remove(struct platform_device *pdev);
-
 #endif
diff --git a/drivers/clk/qcom/gcc-apq8084.c b/drivers/clk/qcom/gcc-apq8084.c
index b88c40115263..1567c3a79534 100644
--- a/drivers/clk/qcom/gcc-apq8084.c
+++ b/drivers/clk/qcom/gcc-apq8084.c
@@ -3623,15 +3623,8 @@ static int gcc_apq8084_probe(struct platform_device *pdev)
 	return qcom_cc_probe(pdev, &gcc_apq8084_desc);
 }
 
-static int gcc_apq8084_remove(struct platform_device *pdev)
-{
-	qcom_cc_remove(pdev);
-	return 0;
-}
-
 static struct platform_driver gcc_apq8084_driver = {
 	.probe		= gcc_apq8084_probe,
-	.remove		= gcc_apq8084_remove,
 	.driver		= {
 		.name	= "gcc-apq8084",
 		.of_match_table = gcc_apq8084_match_table,
diff --git a/drivers/clk/qcom/gcc-ipq806x.c b/drivers/clk/qcom/gcc-ipq806x.c
index 40e480220cd3..16fc64c082a5 100644
--- a/drivers/clk/qcom/gcc-ipq806x.c
+++ b/drivers/clk/qcom/gcc-ipq806x.c
@@ -3058,15 +3058,8 @@ static int gcc_ipq806x_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int gcc_ipq806x_remove(struct platform_device *pdev)
-{
-	qcom_cc_remove(pdev);
-	return 0;
-}
-
 static struct platform_driver gcc_ipq806x_driver = {
 	.probe		= gcc_ipq806x_probe,
-	.remove		= gcc_ipq806x_remove,
 	.driver		= {
 		.name	= "gcc-ipq806x",
 		.of_match_table = gcc_ipq806x_match_table,
diff --git a/drivers/clk/qcom/gcc-msm8660.c b/drivers/clk/qcom/gcc-msm8660.c
index b02826ed770a..f110bb5a1df3 100644
--- a/drivers/clk/qcom/gcc-msm8660.c
+++ b/drivers/clk/qcom/gcc-msm8660.c
@@ -2735,15 +2735,8 @@ static int gcc_msm8660_probe(struct platform_device *pdev)
 	return qcom_cc_probe(pdev, &gcc_msm8660_desc);
 }
 
-static int gcc_msm8660_remove(struct platform_device *pdev)
-{
-	qcom_cc_remove(pdev);
-	return 0;
-}
-
 static struct platform_driver gcc_msm8660_driver = {
 	.probe		= gcc_msm8660_probe,
-	.remove		= gcc_msm8660_remove,
 	.driver		= {
 		.name	= "gcc-msm8660",
 		.of_match_table = gcc_msm8660_match_table,
diff --git a/drivers/clk/qcom/gcc-msm8916.c b/drivers/clk/qcom/gcc-msm8916.c
index f7aff814368a..d0a0313d6bef 100644
--- a/drivers/clk/qcom/gcc-msm8916.c
+++ b/drivers/clk/qcom/gcc-msm8916.c
@@ -3372,15 +3372,8 @@ static int gcc_msm8916_probe(struct platform_device *pdev)
 	return qcom_cc_probe(pdev, &gcc_msm8916_desc);
 }
 
-static int gcc_msm8916_remove(struct platform_device *pdev)
-{
-	qcom_cc_remove(pdev);
-	return 0;
-}
-
 static struct platform_driver gcc_msm8916_driver = {
 	.probe		= gcc_msm8916_probe,
-	.remove		= gcc_msm8916_remove,
 	.driver		= {
 		.name	= "gcc-msm8916",
 		.of_match_table = gcc_msm8916_match_table,
diff --git a/drivers/clk/qcom/gcc-msm8960.c b/drivers/clk/qcom/gcc-msm8960.c
index aa294b1bad34..b52153903893 100644
--- a/drivers/clk/qcom/gcc-msm8960.c
+++ b/drivers/clk/qcom/gcc-msm8960.c
@@ -3525,7 +3525,6 @@ static int gcc_msm8960_probe(struct platform_device *pdev)
 
 static int gcc_msm8960_remove(struct platform_device *pdev)
 {
-	qcom_cc_remove(pdev);
 	return 0;
 }
 
diff --git a/drivers/clk/qcom/gcc-msm8974.c b/drivers/clk/qcom/gcc-msm8974.c
index ebad55c74917..28abb8f8f293 100644
--- a/drivers/clk/qcom/gcc-msm8974.c
+++ b/drivers/clk/qcom/gcc-msm8974.c
@@ -2744,15 +2744,8 @@ static int gcc_msm8974_probe(struct platform_device *pdev)
 	return qcom_cc_probe(pdev, &gcc_msm8974_desc);
 }
 
-static int gcc_msm8974_remove(struct platform_device *pdev)
-{
-	qcom_cc_remove(pdev);
-	return 0;
-}
-
 static struct platform_driver gcc_msm8974_driver = {
 	.probe		= gcc_msm8974_probe,
-	.remove		= gcc_msm8974_remove,
 	.driver		= {
 		.name	= "gcc-msm8974",
 		.of_match_table = gcc_msm8974_match_table,
diff --git a/drivers/clk/qcom/lcc-ipq806x.c b/drivers/clk/qcom/lcc-ipq806x.c
index 93ad42b14366..db3998e5e2d8 100644
--- a/drivers/clk/qcom/lcc-ipq806x.c
+++ b/drivers/clk/qcom/lcc-ipq806x.c
@@ -452,15 +452,8 @@ static int lcc_ipq806x_probe(struct platform_device *pdev)
 	return qcom_cc_really_probe(pdev, &lcc_ipq806x_desc, regmap);
 }
 
-static int lcc_ipq806x_remove(struct platform_device *pdev)
-{
-	qcom_cc_remove(pdev);
-	return 0;
-}
-
 static struct platform_driver lcc_ipq806x_driver = {
 	.probe		= lcc_ipq806x_probe,
-	.remove		= lcc_ipq806x_remove,
 	.driver		= {
 		.name	= "lcc-ipq806x",
 		.of_match_table = lcc_ipq806x_match_table,
diff --git a/drivers/clk/qcom/lcc-msm8960.c b/drivers/clk/qcom/lcc-msm8960.c
index ecb96c284675..4fcf9d1d233c 100644
--- a/drivers/clk/qcom/lcc-msm8960.c
+++ b/drivers/clk/qcom/lcc-msm8960.c
@@ -565,15 +565,8 @@ static int lcc_msm8960_probe(struct platform_device *pdev)
 	return qcom_cc_really_probe(pdev, &lcc_msm8960_desc, regmap);
 }
 
-static int lcc_msm8960_remove(struct platform_device *pdev)
-{
-	qcom_cc_remove(pdev);
-	return 0;
-}
-
 static struct platform_driver lcc_msm8960_driver = {
 	.probe		= lcc_msm8960_probe,
-	.remove		= lcc_msm8960_remove,
 	.driver		= {
 		.name	= "lcc-msm8960",
 		.of_match_table = lcc_msm8960_match_table,
diff --git a/drivers/clk/qcom/mmcc-apq8084.c b/drivers/clk/qcom/mmcc-apq8084.c
index aa3809d9cec5..30777f9f1a43 100644
--- a/drivers/clk/qcom/mmcc-apq8084.c
+++ b/drivers/clk/qcom/mmcc-apq8084.c
@@ -3402,15 +3402,8 @@ static int mmcc_apq8084_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int mmcc_apq8084_remove(struct platform_device *pdev)
-{
-	qcom_cc_remove(pdev);
-	return 0;
-}
-
 static struct platform_driver mmcc_apq8084_driver = {
 	.probe		= mmcc_apq8084_probe,
-	.remove		= mmcc_apq8084_remove,
 	.driver		= {
 		.name	= "mmcc-apq8084",
 		.of_match_table = mmcc_apq8084_match_table,
diff --git a/drivers/clk/qcom/mmcc-msm8960.c b/drivers/clk/qcom/mmcc-msm8960.c
index bad02aebf959..fa55e27dd905 100644
--- a/drivers/clk/qcom/mmcc-msm8960.c
+++ b/drivers/clk/qcom/mmcc-msm8960.c
@@ -2686,15 +2686,8 @@ static int mmcc_msm8960_probe(struct platform_device *pdev)
 	return qcom_cc_really_probe(pdev, match->data, regmap);
 }
 
-static int mmcc_msm8960_remove(struct platform_device *pdev)
-{
-	qcom_cc_remove(pdev);
-	return 0;
-}
-
 static struct platform_driver mmcc_msm8960_driver = {
 	.probe		= mmcc_msm8960_probe,
-	.remove		= mmcc_msm8960_remove,
 	.driver		= {
 		.name	= "mmcc-msm8960",
 		.of_match_table = mmcc_msm8960_match_table,
diff --git a/drivers/clk/qcom/mmcc-msm8974.c b/drivers/clk/qcom/mmcc-msm8974.c
index cf2a7c9c95e6..9d790bcadf25 100644
--- a/drivers/clk/qcom/mmcc-msm8974.c
+++ b/drivers/clk/qcom/mmcc-msm8974.c
@@ -2628,16 +2628,12 @@ static int mmcc_msm8974_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = pm_genpd_add_subdomain(&oxili_gdsc.pd, &oxilicx_gdsc.pd);
-	if (ret)
-		qcom_cc_remove(pdev);
-	return ret;
+	return pm_genpd_add_subdomain(&oxili_gdsc.pd, &oxilicx_gdsc.pd);
 }
 
 static int mmcc_msm8974_remove(struct platform_device *pdev)
 {
 	pm_genpd_remove_subdomain(&oxili_gdsc.pd, &oxilicx_gdsc.pd);
-	qcom_cc_remove(pdev);
 	return 0;
 }
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

