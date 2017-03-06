From: =?UTF-8?q?Niklas=20S=C3=B6derlund?=
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH 7/7] thermal: rcar_gen3_thermal: add suspend and resume support
Date: Mon,  6 Mar 2017 21:04:01 +0100
Message-ID: <20170306200401.29923-8-niklas.soderlund+renesas@ragnatech.se>
References: <20170306200401.29923-1-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170306200401.29923-1-niklas.soderlund+renesas@ragnatech.se>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
List-Id: linux-pm@vger.kernel.org

To restore operation it's easiest to reinitialise all TSC. In order to
do this the current trip window needs to be stored in the TSC structure
so that it can be restored upon resume.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/thermal/rcar_gen3_thermal.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index 9168ac538f3b8cf5..84642871a628cb2a 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -84,6 +84,8 @@ struct rcar_gen3_thermal_tsc {
 	void __iomem *base;
 	struct thermal_zone_device *zone;
 	struct equation_coefs coef;
+	int low;
+	int high;
 };
 
 struct rcar_gen3_thermal_priv {
@@ -220,6 +222,9 @@ static int rcar_gen3_thermal_set_trips(void *devdata, int low, int high)
 	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQTEMP2,
 				rcar_gen3_thermal_mcelsius_to_temp(tsc, high));
 
+	tsc->low = low;
+	tsc->high = high;
+
 	dev_dbg(tsc->dev, "TSC%d: low: %d high: %d\n", tsc->num, low, high);
 
 	return 0;
@@ -460,9 +465,39 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static int __maybe_unused rcar_gen3_thermal_suspend(struct device *dev)
+{
+	struct rcar_gen3_thermal_priv *priv = dev_get_drvdata(dev);
+
+	rcar_thermal_irq_disable(priv);
+
+	return 0;
+}
+
+static int __maybe_unused rcar_gen3_thermal_resume(struct device *dev)
+{
+	struct rcar_gen3_thermal_priv *priv = dev_get_drvdata(dev);
+	int i;
+
+	for (i = 0; i < TSC_MAX_NUM; i++) {
+		struct rcar_gen3_thermal_tsc *tsc = priv->tscs[i];
+
+		priv->data->thermal_init(tsc);
+		rcar_gen3_thermal_set_trips(tsc, tsc->low, tsc->high);
+	}
+
+	rcar_thermal_irq_enable(priv);
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
