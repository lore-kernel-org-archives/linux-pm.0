From: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v3 04/10] thermal: rockchip: improve the conversion function
Date: Sun,  8 Nov 2015 17:26:02 +0800
Message-ID: <1446974768-25795-5-git-send-email-wxt@rock-chips.com>
References: <1446974768-25795-1-git-send-email-wxt@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1446974768-25795-1-git-send-email-wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

We should make the conversion table in as a parameter since the different
SoCs have the different conversionion table.

Signed-off-by: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>

---

Changes in v3:
- As Eduardo comments, let's change data_mask type with 'u32' instead of
  'unsigned long'.
Series-changes: 2
- make the conversion table in as a parameter both code_to_temp
  and temp_to_code function.
Series-changes: 1
- As Dmitry comment, make the conversion table in as a parameterm.

Changes in v2: None
Changes in v1: None

 drivers/thermal/rockchip_thermal.c | 82 +++++++++++++++++++++++++-------------
 1 file changed, 55 insertions(+), 27 deletions(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index bdf7063..3116d07 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -58,6 +58,16 @@ enum sensor_id {
  */
 #define SOC_MAX_SENSORS	2
 
+struct chip_tsadc_table {
+	const struct tsadc_table *id;
+
+	/* the array table size*/
+	unsigned int length;
+
+	/* that analogic mask data */
+	u32 data_mask;
+};
+
 struct rockchip_tsadc_chip {
 	/* The sensor id of chip correspond to the ADC channel */
 	int chn_id[SOC_MAX_SENSORS];
@@ -74,9 +84,14 @@ struct rockchip_tsadc_chip {
 	void (*control)(void __iomem *reg, bool on);
 
 	/* Per-sensor methods */
-	int (*get_temp)(int chn, void __iomem *reg, int *temp);
-	void (*set_tshut_temp)(int chn, void __iomem *reg, long temp);
+	int (*get_temp)(struct chip_tsadc_table table,
+			int chn, void __iomem *reg, int *temp);
+	void (*set_tshut_temp)(struct chip_tsadc_table table,
+			       int chn, void __iomem *reg, long temp);
 	void (*set_tshut_mode)(int chn, void __iomem *reg, enum tshut_mode m);
+
+	/* Per-table methods */
+	struct chip_tsadc_table table;
 };
 
 struct rockchip_thermal_sensor {
@@ -172,21 +187,22 @@ static const struct tsadc_table v2_code_table[] = {
 	{3421, 125000},
 };
 
-static u32 rk_tsadcv2_temp_to_code(long temp)
+static u32 rk_tsadcv2_temp_to_code(struct chip_tsadc_table table,
+				   long temp)
 {
 	int high, low, mid;
 
 	low = 0;
-	high = ARRAY_SIZE(v2_code_table) - 1;
+	high = table.length - 1;
 	mid = (high + low) / 2;
 
-	if (temp < v2_code_table[low].temp || temp > v2_code_table[high].temp)
+	if (temp < table.id[low].temp || temp > table.id[high].temp)
 		return 0;
 
 	while (low <= high) {
-		if (temp == v2_code_table[mid].temp)
-			return v2_code_table[mid].code;
-		else if (temp < v2_code_table[mid].temp)
+		if (temp == table.id[mid].temp)
+			return table.id[mid].code;
+		else if (temp < table.id[mid].temp)
 			high = mid - 1;
 		else
 			low = mid + 1;
@@ -196,25 +212,26 @@ static u32 rk_tsadcv2_temp_to_code(long temp)
 	return 0;
 }
 
-static int rk_tsadcv2_code_to_temp(u32 code, int *temp)
+static int rk_tsadcv2_code_to_temp(struct chip_tsadc_table table, u32 code,
+				   int *temp)
 {
 	unsigned int low = 1;
-	unsigned int high = ARRAY_SIZE(v2_code_table) - 1;
+	unsigned int high = table.length - 1;
 	unsigned int mid = (low + high) / 2;
 	unsigned int num;
 	unsigned long denom;
 
-	BUILD_BUG_ON(ARRAY_SIZE(v2_code_table) < 2);
+	WARN_ON(table.length < 2);
 
-	code &= TSADCV2_DATA_MASK;
-	if (code < v2_code_table[high].code)
+	code &= table.data_mask;
+	if (code < table.id[high].code)
 		return -EAGAIN;		/* Incorrect reading */
 
 	while (low <= high) {
-		if (code >= v2_code_table[mid].code &&
-		    code < v2_code_table[mid - 1].code)
+		if (code >= table.id[mid].code &&
+		    code < table.id[mid - 1].code)
 			break;
-		else if (code < v2_code_table[mid].code)
+		else if (code < table.id[mid].code)
 			low = mid + 1;
 		else
 			high = mid - 1;
@@ -227,10 +244,10 @@ static int rk_tsadcv2_code_to_temp(u32 code, int *temp)
 	 * temperature between 2 table entries is linear and interpolate
 	 * to produce less granular result.
 	 */
-	num = v2_code_table[mid].temp - v2_code_table[mid - 1].temp;
-	num *= v2_code_table[mid - 1].code - code;
-	denom = v2_code_table[mid - 1].code - v2_code_table[mid].code;
-	*temp = v2_code_table[mid - 1].temp + (num / denom);
+	num = table.id[mid].temp - v2_code_table[mid - 1].temp;
+	num *= table.id[mid - 1].code - code;
+	denom = table.id[mid - 1].code - table.id[mid].code;
+	*temp = table.id[mid - 1].temp + (num / denom);
 
 	return 0;
 }
@@ -290,20 +307,22 @@ static void rk_tsadcv2_control(void __iomem *regs, bool enable)
 	writel_relaxed(val, regs + TSADCV2_AUTO_CON);
 }
 
-static int rk_tsadcv2_get_temp(int chn, void __iomem *regs, int *temp)
+static int rk_tsadcv2_get_temp(struct chip_tsadc_table table,
+			       int chn, void __iomem *regs, int *temp)
 {
 	u32 val;
 
 	val = readl_relaxed(regs + TSADCV2_DATA(chn));
 
-	return rk_tsadcv2_code_to_temp(val, temp);
+	return rk_tsadcv2_code_to_temp(table, val, temp);
 }
 
-static void rk_tsadcv2_tshut_temp(int chn, void __iomem *regs, long temp)
+static void rk_tsadcv2_tshut_temp(struct chip_tsadc_table table,
+				  int chn, void __iomem *regs, long temp)
 {
 	u32 tshut_value, val;
 
-	tshut_value = rk_tsadcv2_temp_to_code(temp);
+	tshut_value = rk_tsadcv2_temp_to_code(table, temp);
 	writel_relaxed(tshut_value, regs + TSADCV2_COMP_SHUT(chn));
 
 	/* TSHUT will be valid */
@@ -343,6 +362,12 @@ static const struct rockchip_tsadc_chip rk3288_tsadc_data = {
 	.get_temp = rk_tsadcv2_get_temp,
 	.set_tshut_temp = rk_tsadcv2_tshut_temp,
 	.set_tshut_mode = rk_tsadcv2_tshut_mode,
+
+	.table = {
+		.id = v2_code_table,
+		.length = ARRAY_SIZE(v2_code_table),
+		.data_mask = TSADCV2_DATA_MASK,
+	},
 };
 
 static const struct of_device_id of_rockchip_thermal_match[] = {
@@ -385,7 +410,8 @@ static int rockchip_thermal_get_temp(void *_sensor, int *out_temp)
 	const struct rockchip_tsadc_chip *tsadc = sensor->thermal->chip;
 	int retval;
 
-	retval = tsadc->get_temp(sensor->id, thermal->regs, out_temp);
+	retval = tsadc->get_temp(tsadc->table,
+				 sensor->id, thermal->regs, out_temp);
 	dev_dbg(&thermal->pdev->dev, "sensor %d - temp: %d, retval: %d\n",
 		sensor->id, *out_temp, retval);
 
@@ -463,7 +489,8 @@ rockchip_thermal_register_sensor(struct platform_device *pdev,
 	int error;
 
 	tsadc->set_tshut_mode(id, thermal->regs, thermal->tshut_mode);
-	tsadc->set_tshut_temp(id, thermal->regs, thermal->tshut_temp);
+	tsadc->set_tshut_temp(tsadc->table, id, thermal->regs,
+			      thermal->tshut_temp);
 
 	sensor->thermal = thermal;
 	sensor->id = id;
@@ -681,7 +708,8 @@ static int __maybe_unused rockchip_thermal_resume(struct device *dev)
 
 		thermal->chip->set_tshut_mode(id, thermal->regs,
 					      thermal->tshut_mode);
-		thermal->chip->set_tshut_temp(id, thermal->regs,
+		thermal->chip->set_tshut_temp(thermal->chip->table,
+					      id, thermal->regs,
 					      thermal->tshut_temp);
 	}
 
-- 
1.9.1
