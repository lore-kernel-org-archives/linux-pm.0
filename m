From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] thermal: imx: Handle return value of clk_prepare_enable
Date: Tue,  6 Jun 2017 15:12:37 +0530
Message-ID: <629c868baf666c464a0e39515a89eaf13a06c064.1496741979.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

clk_prepare_enable() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/thermal/imx_thermal.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index fb648a4..1aee321 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -648,8 +648,11 @@ static int imx_thermal_resume(struct device *dev)
 {
 	struct imx_thermal_data *data = dev_get_drvdata(dev);
 	struct regmap *map = data->tempmon;
+	int ret;
 
-	clk_prepare_enable(data->thermal_clk);
+	ret = clk_prepare_enable(data->thermal_clk);
+	if (ret)
+		return ret;
 	/* Enabled thermal sensor after resume */
 	regmap_write(map, TEMPSENSE0 + REG_CLR, TEMPSENSE0_POWER_DOWN);
 	regmap_write(map, TEMPSENSE0 + REG_SET, TEMPSENSE0_MEASURE_TEMP);
-- 
1.9.1
