From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [NOT-FOR-MERGE V8 6/6] remoteproc: qcom: q6v5: Vote for proxy powerdomain performance state
Date: Wed, 21 Jun 2017 12:40:53 +0530
Message-ID: <3bc9ead29ae0171d2f099c2c060645597107c990.1498026827.git.viresh.kumar@linaro.org>
References: <cover.1498026827.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f44.google.com ([74.125.83.44]:34902 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752555AbdFUHLW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Jun 2017 03:11:22 -0400
Received: by mail-pg0-f44.google.com with SMTP id 132so39875696pgb.2
        for <linux-pm@vger.kernel.org>; Wed, 21 Jun 2017 00:11:22 -0700 (PDT)
In-Reply-To: <cover.1498026827.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1498026827.git.viresh.kumar@linaro.org>
References: <cover.1498026827.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org, Kevin Hilman <khilman@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, robh+dt@kernel.org, lina.iyer@linaro.org, rnayak@codeaurora.org, sudeep.holla@arm.com, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>

From: Rajendra Nayak <rnayak@codeaurora.org>

THIS IS TEST CODE, SHOULDN'T BE MERGED.

This patch just demonstrates the usage of pm_genpd_update_performance_state()
api in cases where users need to set performance state of a powerdomain without
having to do it via the OPP framework.

q6v5 remoteproc driver needs to proxy vote for performance states of multiple
powerdomains (but we currently only demonstate how it can be done for
one powerdomain, as there is no way to associate multiple powerdomains
to a device at this time) while it loads the firmware, and then releases
the vote, once the firmware is up and can vote for itself.

This is not a functional patch since rpmpd driver only supports msm8996
and there is no msm8996 support in the q6v5 remoteproc driver at this
point in mainline.

This patch is not tested as well.

NOT-signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
NOT-signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/remoteproc/qcom_q6v5_pil.c | 20 +++++++++++++-------
 drivers/soc/qcom/rpmpd.c           |  5 +++++
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_pil.c b/drivers/remoteproc/qcom_q6v5_pil.c
index 8fd697a3cf8f..47c9dad98ee8 100644
--- a/drivers/remoteproc/qcom_q6v5_pil.c
+++ b/drivers/remoteproc/qcom_q6v5_pil.c
@@ -18,6 +18,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
+#include <linux/pm_domain.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/mfd/syscon.h>
@@ -152,6 +153,8 @@ struct q6v5 {
 	void *mpss_region;
 	size_t mpss_size;
 
+	bool has_perf_state;
+
 	struct qcom_rproc_subdev smd_subdev;
 };
 
@@ -603,11 +606,12 @@ static int q6v5_start(struct rproc *rproc)
 	struct q6v5 *qproc = (struct q6v5 *)rproc->priv;
 	int ret;
 
-	ret = q6v5_regulator_enable(qproc, qproc->proxy_regs,
-				    qproc->proxy_reg_count);
-	if (ret) {
-		dev_err(qproc->dev, "failed to enable proxy supplies\n");
-		return ret;
+	if (qproc->has_perf_state) {
+		ret = pm_genpd_update_performance_state(qproc->dev, INT_MAX);
+		if (ret) {
+			dev_err(qproc->dev, "Failed to set performance state.\n");
+			return ret;
+		}
 	}
 
 	ret = q6v5_clk_enable(qproc->dev, qproc->proxy_clks,
@@ -671,8 +675,8 @@ static int q6v5_start(struct rproc *rproc)
 
 	q6v5_clk_disable(qproc->dev, qproc->proxy_clks,
 			 qproc->proxy_clk_count);
-	q6v5_regulator_disable(qproc, qproc->proxy_regs,
-			       qproc->proxy_reg_count);
+	if (qproc->has_perf_state)
+		pm_genpd_update_performance_state(qproc->dev, 0);
 
 	return 0;
 
@@ -1043,6 +1047,8 @@ static int q6v5_probe(struct platform_device *pdev)
 	if (ret)
 		goto free_rproc;
 
+	qproc->has_perf_state = pm_genpd_has_performance_state(&qproc->dev);
+
 	return 0;
 
 free_rproc:
diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/soc/qcom/rpmpd.c
index 7ef81429c5c5..b1af1442ebe9 100644
--- a/drivers/soc/qcom/rpmpd.c
+++ b/drivers/soc/qcom/rpmpd.c
@@ -145,6 +145,7 @@ enum msm8996_devices {
 	UFS,
 	PCIE,
 	USB3,
+	Q6V5_PIL,
 };
 
 static struct rpmpd_freq_map msm8996_rpmpd_freq_map[] = {
@@ -171,6 +172,10 @@ static struct rpmpd_freq_map msm8996_rpmpd_freq_map[] = {
 		.freq[LOW] = 120000000,
 		.freq[NOMINAL] = 150000000,
 	},
+	[Q6V5_PIL] = {
+		.pd = &msm8996_vddcx,
+		.freq[HIGH] = INT_MAX,
+	},
 };
 
 static const struct of_device_id rpmpd_performance_table[] = {
-- 
2.13.0.71.gd7076ec9c9cb
