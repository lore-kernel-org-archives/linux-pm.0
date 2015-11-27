From: Caesar Wang <wxt@rock-chips.com>
Subject: [PATCH v1 4/5] thermal: rockchip: Support the RK3228 SoCs in thermal driver
Date: Fri, 27 Nov 2015 10:52:25 +0800
Message-ID: <1448592746-2129-5-git-send-email-wxt@rock-chips.com>
References: <1448592746-2129-1-git-send-email-wxt@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448592746-2129-1-git-send-email-wxt@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: linux-rockchip@lists.infradead.org, Heiko Stuebner <heiko@sntech.de>, Dan Carpenter <dan.carpenter@oracle.com>, Caesar Wang <wxt@rock-chips.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

The RK3228 SoCs has one Temperature Sensor, channel 0 is for CPU.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

Changes in v1: None

 drivers/thermal/rockchip_thermal.c | 81 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index d00765f..37772dd 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -153,6 +153,7 @@ struct rockchip_thermal_data {
 #define TSADCV2_SHUT_2GPIO_SRC_EN(chn)		BIT(4 + (chn))
 #define TSADCV2_SHUT_2CRU_SRC_EN(chn)		BIT(8 + (chn))
 
+#define TSADCV1_INT_PD_CLEAR_MASK		~BIT(16)
 #define TSADCV2_INT_PD_CLEAR_MASK		~BIT(8)
 
 #define TSADCV2_DATA_MASK			0xfff
@@ -168,6 +169,51 @@ struct tsadc_table {
 	int temp;
 };
 
+/**
+ * Note:
+ * Code to Temperature mapping of the Temperature sensor is a piece wise linear
+ * curve.Any temperature, code faling between to 2 give temperatures can be
+ * linearly interpolated.
+ * Code to Temperature mapping should be updated based on sillcon results.
+ */
+static const struct tsadc_table v1_code_table[] = {
+	{TSADCV3_DATA_MASK, -40000},
+	{436, -40000},
+	{431, -35000},
+	{426, -30000},
+	{421, -25000},
+	{416, -20000},
+	{411, -15000},
+	{406, -10000},
+	{401, -5000},
+	{395, 0},
+	{390, 5000},
+	{385, 10000},
+	{380, 15000},
+	{375, 20000},
+	{370, 25000},
+	{364, 30000},
+	{359, 35000},
+	{354, 40000},
+	{349, 45000},
+	{343, 50000},
+	{338, 55000},
+	{333, 60000},
+	{328, 65000},
+	{322, 70000},
+	{317, 75000},
+	{312, 80000},
+	{307, 85000},
+	{301, 90000},
+	{296, 95000},
+	{291, 100000},
+	{286, 105000},
+	{280, 110000},
+	{275, 115000},
+	{270, 120000},
+	{264, 125000},
+};
+
 static const struct tsadc_table v2_code_table[] = {
 	{TSADCV2_DATA_MASK, -40000},
 	{3800, -40000},
@@ -368,6 +414,14 @@ static void rk_tsadcv2_initialize(void __iomem *regs,
 		       regs + TSADCV2_HIGHT_TSHUT_DEBOUNCE);
 }
 
+static void rk_tsadcv1_irq_ack(void __iomem *regs)
+{
+	u32 val;
+
+	val = readl_relaxed(regs + TSADCV2_INT_PD);
+	writel_relaxed(val & TSADCV1_INT_PD_CLEAR_MASK, regs + TSADCV2_INT_PD);
+}
+
 static void rk_tsadcv2_irq_ack(void __iomem *regs)
 {
 	u32 val;
@@ -429,6 +483,29 @@ static void rk_tsadcv2_tshut_mode(int chn, void __iomem *regs,
 	writel_relaxed(val, regs + TSADCV2_INT_EN);
 }
 
+static const struct rockchip_tsadc_chip rk3228_tsadc_data = {
+	.chn_id[SENSOR_CPU] = 0, /* cpu sensor is channel 0 */
+	.chn_num = 1, /* one channel for tsadc */
+
+	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
+	.tshut_polarity = TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
+	.tshut_temp = 95000,
+
+	.initialize = rk_tsadcv2_initialize,
+	.irq_ack = rk_tsadcv1_irq_ack,
+	.control = rk_tsadcv2_control,
+	.get_temp = rk_tsadcv2_get_temp,
+	.set_tshut_temp = rk_tsadcv2_tshut_temp,
+	.set_tshut_mode = rk_tsadcv2_tshut_mode,
+
+	.table = {
+		.id = v1_code_table,
+		.length = ARRAY_SIZE(v1_code_table),
+		.data_mask = TSADCV3_DATA_MASK,
+		.mode = ADC_DECREMENT,
+	},
+};
+
 static const struct rockchip_tsadc_chip rk3288_tsadc_data = {
 	.chn_id[SENSOR_CPU] = 1, /* cpu sensor is channel 1 */
 	.chn_id[SENSOR_GPU] = 2, /* gpu sensor is channel 2 */
@@ -479,6 +556,10 @@ static const struct rockchip_tsadc_chip rk3368_tsadc_data = {
 
 static const struct of_device_id of_rockchip_thermal_match[] = {
 	{
+		.compatible = "rockchip,rk3228-tsadc",
+		.data = (void *)&rk3228_tsadc_data,
+	},
+	{
 		.compatible = "rockchip,rk3288-tsadc",
 		.data = (void *)&rk3288_tsadc_data,
 	},
-- 
1.9.1
