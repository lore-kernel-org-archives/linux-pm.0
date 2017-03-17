From: =?UTF-8?q?Niklas=20S=C3=B6derlund?=
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH v2 7/7] thermal: rcar_gen3_thermal: add suspend and resume support
Date: Fri, 17 Mar 2017 16:53:00 +0100
Message-ID: <20170317155300.21566-8-niklas.soderlund+renesas@ragnatech.se>
References: <20170317155300.21566-1-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp-4.sys.kth.se ([130.237.48.193]:56339 "EHLO
        smtp-4.sys.kth.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751065AbdCQQCG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Mar 2017 12:02:06 -0400
In-Reply-To: <20170317155300.21566-1-niklas.soderlund+renesas@ragnatech.se>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>

To restore operation it's easiest to reinitialise all TSCs. In order to
do this the current trip window needs to be stored in the TSC structure
so that it can be restored upon resume.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/thermal/rcar_gen3_thermal.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index 438fb9988eabb91b..b5e3d7b41629803c 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -82,6 +82,8 @@ struct rcar_gen3_thermal_tsc {
 	void __iomem *base;
 	struct thermal_zone_device *zone;
 	struct equation_coefs coef;
+	int low;
+	int high;
 };
 
 struct rcar_gen3_thermal_priv {
@@ -217,6 +219,9 @@ static int rcar_gen3_thermal_set_trips(void *devdata, int low, int high)
 	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQTEMP2,
 				rcar_gen3_thermal_mcelsius_to_temp(tsc, high));
 
+	tsc->low = low;
+	tsc->high = high;
+
 	return 0;
 }
 
@@ -450,9 +455,39 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static int __maybe_unused rcar_gen3_thermal_suspend(struct device *dev)
+{
+	struct rcar_gen3_thermal_priv *priv = dev_get_drvdata(dev);
+
+	rcar_thermal_irq_set(priv, 0);
+
+	return 0;
+}
+
+static int __maybe_unused rcar_gen3_thermal_resume(struct device *dev)
+{
+	struct rcar_gen3_thermal_priv *priv = dev_get_drvdata(dev);
+	unsigned int i;
+
+	for (i = 0; i < priv->num_tscs; i++) {
+		struct rcar_gen3_thermal_tsc *tsc = priv->tscs[i];
+
+		priv->data->thermal_init(tsc);
+		rcar_gen3_thermal_set_trips(tsc, tsc->low, tsc->high);
+	}
+
+	rcar_thermal_irq_set(priv, 1);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(rcar_gen3_thermal_pm_ops, rcar_gen3_thermal_suspend,
+			 rcar_gen3_thermal_resume);
+
 static struct platform_driver rcar_gen3_thermal_driver = {
 	.driver	= {
 		.name	= "rcar_gen3_thermal",
+		.pm = &rcar_gen3_thermal_pm_ops,
 		.of_match_table = rcar_gen3_thermal_dt_ids,
 	},
 	.probe		= rcar_gen3_thermal_probe,
-- 
2.12.0
