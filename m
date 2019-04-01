From: Elaine Zhang <zhangqing-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v1 3/3] thermal: rockchip: Support the PX30 SoC in thermal
 driver
Date: Mon,  1 Apr 2019 14:43:05 +0800
Message-ID: <1554100985-11385-4-git-send-email-zhangqing@rock-chips.com>
References: <1554100985-11385-1-git-send-email-zhangqing@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1554100985-11385-1-git-send-email-zhangqing-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Elaine Zhang <zhangqing-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, xxx-TNX95d0MmH7DzftRWevZcw@public.gmane.org, daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, xf-TNX95d0MmH7DzftRWevZcw@public.gmane.org, edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

PX30 SOC has two Temperature Sensors for CPU and GPU.

Signed-off-by: Elaine Zhang <zhangqing-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
---
 drivers/thermal/rockchip_thermal.c | 39 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index faa6c7792155..d5c161e63361 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -225,11 +225,15 @@ struct rockchip_thermal_data {
 #define GRF_TSADC_TESTBIT_L			0x0e648
 #define GRF_TSADC_TESTBIT_H			0x0e64c
 
+#define PX30_GRF_SOC_CON2			0x0408
+
 #define GRF_SARADC_TESTBIT_ON			(0x10001 << 2)
 #define GRF_TSADC_TESTBIT_H_ON			(0x10001 << 2)
 #define GRF_TSADC_VCM_EN_L			(0x10001 << 7)
 #define GRF_TSADC_VCM_EN_H			(0x10001 << 7)
 
+#define GRF_CON_TSADC_CH_INV			(0x10001 << 1)
+
 /**
  * struct tsadc_table - code to temperature conversion table
  * @code: the value of adc channel
@@ -692,6 +696,14 @@ static void rk_tsadcv3_initialize(struct regmap *grf, void __iomem *regs,
 			       regs + TSADCV2_AUTO_CON);
 }
 
+static void rk_tsadcv4_initialize(struct regmap *grf, void __iomem *regs,
+				  enum tshut_polarity tshut_polarity)
+{
+	rk_tsadcv2_initialize(grf, regs, tshut_polarity);
+	if (!IS_ERR(grf))
+		regmap_write(grf, PX30_GRF_SOC_CON2, GRF_CON_TSADC_CH_INV);
+}
+
 static void rk_tsadcv2_irq_ack(void __iomem *regs)
 {
 	u32 val;
@@ -821,6 +833,30 @@ static void rk_tsadcv2_tshut_mode(int chn, void __iomem *regs,
 	writel_relaxed(val, regs + TSADCV2_INT_EN);
 }
 
+static const struct rockchip_tsadc_chip px30_tsadc_data = {
+	.chn_id[SENSOR_CPU] = 0, /* cpu sensor is channel 0 */
+	.chn_id[SENSOR_GPU] = 1, /* gpu sensor is channel 1 */
+	.chn_num = 2, /* 2 channels for tsadc */
+
+	.tshut_mode = TSHUT_MODE_CRU, /* default TSHUT via CRU */
+	.tshut_temp = 95000,
+
+	.initialize = rk_tsadcv4_initialize,
+	.irq_ack = rk_tsadcv3_irq_ack,
+	.control = rk_tsadcv3_control,
+	.get_temp = rk_tsadcv2_get_temp,
+	.set_alarm_temp = rk_tsadcv2_alarm_temp,
+	.set_tshut_temp = rk_tsadcv2_tshut_temp,
+	.set_tshut_mode = rk_tsadcv2_tshut_mode,
+
+	.table = {
+		.id = rk3328_code_table,
+		.length = ARRAY_SIZE(rk3328_code_table),
+		.data_mask = TSADCV2_DATA_MASK,
+		.mode = ADC_INCREMENT,
+	},
+};
+
 static const struct rockchip_tsadc_chip rv1108_tsadc_data = {
 	.chn_id[SENSOR_CPU] = 0, /* cpu sensor is channel 0 */
 	.chn_num = 1, /* one channel for tsadc */
@@ -993,6 +1029,9 @@ static void rk_tsadcv2_tshut_mode(int chn, void __iomem *regs,
 };
 
 static const struct of_device_id of_rockchip_thermal_match[] = {
+	{	.compatible = "rockchip,px30-tsadc",
+		.data = (void *)&px30_tsadc_data,
+	},
 	{
 		.compatible = "rockchip,rv1108-tsadc",
 		.data = (void *)&rv1108_tsadc_data,
-- 
1.9.1
