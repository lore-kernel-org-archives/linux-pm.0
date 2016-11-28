From: Caesar Wang <wxt@rock-chips.com>
Subject: [PATCH v3 3/5] thermal: rockchip: fixes invalid temperature case
Date: Mon, 28 Nov 2016 19:12:02 +0800
Message-ID: <1480331524-18741-4-git-send-email-wxt@rock-chips.com>
References: <1480331524-18741-1-git-send-email-wxt@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1480331524-18741-1-git-send-email-wxt@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: heiko@sntech.de, smbarber@chromium.org, briannorris@chromium.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org, Caesar Wang <wxt@rock-chips.com>
List-Id: linux-pm@vger.kernel.org

The temp_to_code function will return 0 when we set the temperature to a
invalid value (e.g. 61C, 62C, 63C....), that's unpractical. This patch
will prevent this case happening. That will return the max analog value to
indicate the temperature is invalid or over table temperature range.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

Changes in v3:
- fix trivial thing for error message nd return value.

Changes in v2:
- As Brian commnets that restructure this to pass error codes back to the
  upper layers.
- Improve the commit message.

Changes in v1: None

 drivers/thermal/rockchip_thermal.c | 48 ++++++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 20 deletions(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index 766486f..ca1730e 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -120,10 +120,10 @@ struct rockchip_tsadc_chip {
 	/* Per-sensor methods */
 	int (*get_temp)(const struct chip_tsadc_table *table,
 			int chn, void __iomem *reg, int *temp);
-	void (*set_alarm_temp)(const struct chip_tsadc_table *table,
-			       int chn, void __iomem *reg, int temp);
-	void (*set_tshut_temp)(const struct chip_tsadc_table *table,
-			       int chn, void __iomem *reg, int temp);
+	int (*set_alarm_temp)(const struct chip_tsadc_table *table,
+			      int chn, void __iomem *reg, int temp);
+	int (*set_tshut_temp)(const struct chip_tsadc_table *table,
+			      int chn, void __iomem *reg, int temp);
 	void (*set_tshut_mode)(int chn, void __iomem *reg, enum tshut_mode m);
 
 	/* Per-table methods */
@@ -401,17 +401,15 @@ static u32 rk_tsadcv2_temp_to_code(const struct chip_tsadc_table *table,
 				   int temp)
 {
 	int high, low, mid;
-	u32 error = 0;
+	u32 error = table->data_mask;
 
 	low = 0;
 	high = table->length - 1;
 	mid = (high + low) / 2;
 
 	/* Return mask code data when the temp is over table range */
-	if (temp < table->id[low].temp || temp > table->id[high].temp) {
-		error = table->data_mask;
+	if (temp < table->id[low].temp || temp > table->id[high].temp)
 		goto exit;
-	}
 
 	while (low <= high) {
 		if (temp == table->id[mid].temp)
@@ -651,15 +649,15 @@ static int rk_tsadcv2_get_temp(const struct chip_tsadc_table *table,
 	return rk_tsadcv2_code_to_temp(table, val, temp);
 }
 
-static void rk_tsadcv2_alarm_temp(const struct chip_tsadc_table *table,
-				  int chn, void __iomem *regs, int temp)
+static int rk_tsadcv2_alarm_temp(const struct chip_tsadc_table *table,
+				 int chn, void __iomem *regs, int temp)
 {
 	u32 alarm_value, int_en;
 
 	/* Make sure the value is valid */
 	alarm_value = rk_tsadcv2_temp_to_code(table, temp);
 	if (alarm_value == table->data_mask)
-		return;
+		return -ERANGE;
 
 	writel_relaxed(alarm_value & table->data_mask,
 		       regs + TSADCV2_COMP_INT(chn));
@@ -667,23 +665,27 @@ static void rk_tsadcv2_alarm_temp(const struct chip_tsadc_table *table,
 	int_en = readl_relaxed(regs + TSADCV2_INT_EN);
 	int_en |= TSADCV2_INT_SRC_EN(chn);
 	writel_relaxed(int_en, regs + TSADCV2_INT_EN);
+
+	return 0;
 }
 
-static void rk_tsadcv2_tshut_temp(const struct chip_tsadc_table *table,
-				  int chn, void __iomem *regs, int temp)
+static int rk_tsadcv2_tshut_temp(const struct chip_tsadc_table *table,
+				 int chn, void __iomem *regs, int temp)
 {
 	u32 tshut_value, val;
 
 	/* Make sure the value is valid */
 	tshut_value = rk_tsadcv2_temp_to_code(table, temp);
 	if (tshut_value == table->data_mask)
-		return;
+		return -ERANGE;
 
 	writel_relaxed(tshut_value, regs + TSADCV2_COMP_SHUT(chn));
 
 	/* TSHUT will be valid */
 	val = readl_relaxed(regs + TSADCV2_AUTO_CON);
 	writel_relaxed(val | TSADCV2_AUTO_SRC_EN(chn), regs + TSADCV2_AUTO_CON);
+
+	return 0;
 }
 
 static void rk_tsadcv2_tshut_mode(int chn, void __iomem *regs,
@@ -886,10 +888,8 @@ static int rockchip_thermal_set_trips(void *_sensor, int low, int high)
 	dev_dbg(&thermal->pdev->dev, "%s: sensor %d: low: %d, high %d\n",
 		__func__, sensor->id, low, high);
 
-	tsadc->set_alarm_temp(&tsadc->table,
-			      sensor->id, thermal->regs, high);
-
-	return 0;
+	return tsadc->set_alarm_temp(&tsadc->table,
+				     sensor->id, thermal->regs, high);
 }
 
 static int rockchip_thermal_get_temp(void *_sensor, int *out_temp)
@@ -985,8 +985,12 @@ rockchip_thermal_register_sensor(struct platform_device *pdev,
 	int error;
 
 	tsadc->set_tshut_mode(id, thermal->regs, thermal->tshut_mode);
-	tsadc->set_tshut_temp(&tsadc->table, id, thermal->regs,
+
+	error = tsadc->set_tshut_temp(&tsadc->table, id, thermal->regs,
 			      thermal->tshut_temp);
+	if (error)
+		dev_err(&pdev->dev, "%s: invalid tshut=%d, error=%d\n",
+			__func__, thermal->tshut_temp, error);
 
 	sensor->thermal = thermal;
 	sensor->id = id;
@@ -1199,9 +1203,13 @@ static int __maybe_unused rockchip_thermal_resume(struct device *dev)
 
 		thermal->chip->set_tshut_mode(id, thermal->regs,
 					      thermal->tshut_mode);
-		thermal->chip->set_tshut_temp(&thermal->chip->table,
+
+		error = thermal->chip->set_tshut_temp(&thermal->chip->table,
 					      id, thermal->regs,
 					      thermal->tshut_temp);
+		if (error)
+			dev_err(&pdev->dev, "%s: invalid tshut=%d, error=%d\n",
+				__func__, thermal->tshut_temp, error);
 	}
 
 	thermal->chip->control(thermal->regs, true);
-- 
2.7.4
