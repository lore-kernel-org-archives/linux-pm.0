From: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 3/3] thermal: rockchip: don't pass table structs by value
Date: Fri, 18 Nov 2016 15:52:57 -0800
Message-ID: <1479513177-81504-3-git-send-email-briannorris@chromium.org>
References: <1479513177-81504-1-git-send-email-briannorris@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1479513177-81504-1-git-send-email-briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Barber <smbarber-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

This driver passes struct chip_tsadc_table by value throughout; this is
inefficient, and AFAICT, there is no reason for it. Let's pass pointers
instead.

Signed-off-by: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
---
 drivers/thermal/rockchip_thermal.c | 80 +++++++++++++++++++-------------------
 1 file changed, 40 insertions(+), 40 deletions(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index 35554d146b9d..30fb95a0dff0 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -118,11 +118,11 @@ struct rockchip_tsadc_chip {
 	void (*control)(void __iomem *reg, bool on);
 
 	/* Per-sensor methods */
-	int (*get_temp)(struct chip_tsadc_table table,
+	int (*get_temp)(const struct chip_tsadc_table *table,
 			int chn, void __iomem *reg, int *temp);
-	void (*set_alarm_temp)(struct chip_tsadc_table table,
+	void (*set_alarm_temp)(const struct chip_tsadc_table *table,
 			       int chn, void __iomem *reg, int temp);
-	void (*set_tshut_temp)(struct chip_tsadc_table table,
+	void (*set_tshut_temp)(const struct chip_tsadc_table *table,
 			       int chn, void __iomem *reg, int temp);
 	void (*set_tshut_mode)(int chn, void __iomem *reg, enum tshut_mode m);
 
@@ -397,26 +397,26 @@ static const struct tsadc_table rk3399_code_table[] = {
 	{TSADCV3_DATA_MASK, 125000},
 };
 
-static u32 rk_tsadcv2_temp_to_code(struct chip_tsadc_table table,
+static u32 rk_tsadcv2_temp_to_code(const struct chip_tsadc_table *table,
 				   int temp)
 {
 	int high, low, mid;
 	u32 error = 0;
 
 	low = 0;
-	high = table.length - 1;
+	high = table->length - 1;
 	mid = (high + low) / 2;
 
 	/* Return mask code data when the temp is over table range */
-	if (temp < table.id[low].temp || temp > table.id[high].temp) {
-		error = table.data_mask;
+	if (temp < table->id[low].temp || temp > table->id[high].temp) {
+		error = table->data_mask;
 		goto exit;
 	}
 
 	while (low <= high) {
-		if (temp == table.id[mid].temp)
-			return table.id[mid].code;
-		else if (temp < table.id[mid].temp)
+		if (temp == table->id[mid].temp)
+			return table->id[mid].code;
+		else if (temp < table->id[mid].temp)
 			high = mid - 1;
 		else
 			low = mid + 1;
@@ -429,28 +429,28 @@ static u32 rk_tsadcv2_temp_to_code(struct chip_tsadc_table table,
 	return error;
 }
 
-static int rk_tsadcv2_code_to_temp(struct chip_tsadc_table table, u32 code,
-				   int *temp)
+static int rk_tsadcv2_code_to_temp(const struct chip_tsadc_table *table,
+				   u32 code, int *temp)
 {
 	unsigned int low = 1;
-	unsigned int high = table.length - 1;
+	unsigned int high = table->length - 1;
 	unsigned int mid = (low + high) / 2;
 	unsigned int num;
 	unsigned long denom;
 
-	WARN_ON(table.length < 2);
+	WARN_ON(table->length < 2);
 
-	switch (table.mode) {
+	switch (table->mode) {
 	case ADC_DECREMENT:
-		code &= table.data_mask;
-		if (code < table.id[high].code)
+		code &= table->data_mask;
+		if (code < table->id[high].code)
 			return -EAGAIN;		/* Incorrect reading */
 
 		while (low <= high) {
-			if (code >= table.id[mid].code &&
-			    code < table.id[mid - 1].code)
+			if (code >= table->id[mid].code &&
+			    code < table->id[mid - 1].code)
 				break;
-			else if (code < table.id[mid].code)
+			else if (code < table->id[mid].code)
 				low = mid + 1;
 			else
 				high = mid - 1;
@@ -459,15 +459,15 @@ static int rk_tsadcv2_code_to_temp(struct chip_tsadc_table table, u32 code,
 		}
 		break;
 	case ADC_INCREMENT:
-		code &= table.data_mask;
-		if (code < table.id[low].code)
+		code &= table->data_mask;
+		if (code < table->id[low].code)
 			return -EAGAIN;		/* Incorrect reading */
 
 		while (low <= high) {
-			if (code <= table.id[mid].code &&
-			    code > table.id[mid - 1].code)
+			if (code <= table->id[mid].code &&
+			    code > table->id[mid - 1].code)
 				break;
-			else if (code > table.id[mid].code)
+			else if (code > table->id[mid].code)
 				low = mid + 1;
 			else
 				high = mid - 1;
@@ -477,7 +477,7 @@ static int rk_tsadcv2_code_to_temp(struct chip_tsadc_table table, u32 code,
 		break;
 	default:
 		pr_err("%s: invalid conversion table, mode=%d\n",
-			__func__, table.mode);
+			__func__, table->mode);
 		return -EINVAL;
 	}
 
@@ -487,10 +487,10 @@ static int rk_tsadcv2_code_to_temp(struct chip_tsadc_table table, u32 code,
 	 * temperature between 2 table entries is linear and interpolate
 	 * to produce less granular result.
 	 */
-	num = table.id[mid].temp - table.id[mid - 1].temp;
-	num *= abs(table.id[mid - 1].code - code);
-	denom = abs(table.id[mid - 1].code - table.id[mid].code);
-	*temp = table.id[mid - 1].temp + (num / denom);
+	num = table->id[mid].temp - table->id[mid - 1].temp;
+	num *= abs(table->id[mid - 1].code - code);
+	denom = abs(table->id[mid - 1].code - table->id[mid].code);
+	*temp = table->id[mid - 1].temp + (num / denom);
 
 	return 0;
 }
@@ -646,7 +646,7 @@ static void rk_tsadcv3_control(void __iomem *regs, bool enable)
 	writel_relaxed(val, regs + TSADCV2_AUTO_CON);
 }
 
-static int rk_tsadcv2_get_temp(struct chip_tsadc_table table,
+static int rk_tsadcv2_get_temp(const struct chip_tsadc_table *table,
 			       int chn, void __iomem *regs, int *temp)
 {
 	u32 val;
@@ -656,17 +656,17 @@ static int rk_tsadcv2_get_temp(struct chip_tsadc_table table,
 	return rk_tsadcv2_code_to_temp(table, val, temp);
 }
 
-static void rk_tsadcv2_alarm_temp(struct chip_tsadc_table table,
+static void rk_tsadcv2_alarm_temp(const struct chip_tsadc_table *table,
 				  int chn, void __iomem *regs, int temp)
 {
 	u32 alarm_value, int_en;
 
 	/* Make sure the value is valid */
 	alarm_value = rk_tsadcv2_temp_to_code(table, temp);
-	if (alarm_value == table.data_mask)
+	if (alarm_value == table->data_mask)
 		return;
 
-	writel_relaxed(alarm_value & table.data_mask,
+	writel_relaxed(alarm_value & table->data_mask,
 		       regs + TSADCV2_COMP_INT(chn));
 
 	int_en = readl_relaxed(regs + TSADCV2_INT_EN);
@@ -674,14 +674,14 @@ static void rk_tsadcv2_alarm_temp(struct chip_tsadc_table table,
 	writel_relaxed(int_en, regs + TSADCV2_INT_EN);
 }
 
-static void rk_tsadcv2_tshut_temp(struct chip_tsadc_table table,
+static void rk_tsadcv2_tshut_temp(const struct chip_tsadc_table *table,
 				  int chn, void __iomem *regs, int temp)
 {
 	u32 tshut_value, val;
 
 	/* Make sure the value is valid */
 	tshut_value = rk_tsadcv2_temp_to_code(table, temp);
-	if (tshut_value == table.data_mask)
+	if (tshut_value == table->data_mask)
 		return;
 
 	writel_relaxed(tshut_value, regs + TSADCV2_COMP_SHUT(chn));
@@ -891,7 +891,7 @@ static int rockchip_thermal_set_trips(void *_sensor, int low, int high)
 	dev_dbg(&thermal->pdev->dev, "%s: sensor %d: low: %d, high %d\n",
 		__func__, sensor->id, low, high);
 
-	tsadc->set_alarm_temp(tsadc->table,
+	tsadc->set_alarm_temp(&tsadc->table,
 			      sensor->id, thermal->regs, high);
 
 	return 0;
@@ -904,7 +904,7 @@ static int rockchip_thermal_get_temp(void *_sensor, int *out_temp)
 	const struct rockchip_tsadc_chip *tsadc = sensor->thermal->chip;
 	int retval;
 
-	retval = tsadc->get_temp(tsadc->table,
+	retval = tsadc->get_temp(&tsadc->table,
 				 sensor->id, thermal->regs, out_temp);
 	dev_dbg(&thermal->pdev->dev, "sensor %d - temp: %d, retval: %d\n",
 		sensor->id, *out_temp, retval);
@@ -988,7 +988,7 @@ rockchip_thermal_register_sensor(struct platform_device *pdev,
 	int error;
 
 	tsadc->set_tshut_mode(id, thermal->regs, thermal->tshut_mode);
-	tsadc->set_tshut_temp(tsadc->table, id, thermal->regs,
+	tsadc->set_tshut_temp(&tsadc->table, id, thermal->regs,
 			      thermal->tshut_temp);
 
 	sensor->thermal = thermal;
@@ -1202,7 +1202,7 @@ static int __maybe_unused rockchip_thermal_resume(struct device *dev)
 
 		thermal->chip->set_tshut_mode(id, thermal->regs,
 					      thermal->tshut_mode);
-		thermal->chip->set_tshut_temp(thermal->chip->table,
+		thermal->chip->set_tshut_temp(&thermal->chip->table,
 					      id, thermal->regs,
 					      thermal->tshut_temp);
 	}
-- 
2.8.0.rc3.226.g39d4020
