From: Caesar Wang <wxt@rock-chips.com>
Subject: [PATCH 5/5] thermal: rockchip: Support the RK3399 SoCs in thermal driver
Date: Wed, 25 Nov 2015 15:59:37 +0800
Message-ID: <1448438377-29203-6-git-send-email-wxt@rock-chips.com>
References: <1448438377-29203-1-git-send-email-wxt@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448438377-29203-1-git-send-email-wxt@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: linux-rockchip@lists.infradead.org, Heiko Stuebner <heiko@sntech.de>, Dan Carpenter <dan.carpenter@oracle.com>, Caesar Wang <wxt@rock-chips.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

The RK3399 SoCs have two Temperature Sensors, channel 0 is for CPU.
channel 1 is for GPU.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>

---

 drivers/thermal/rockchip_thermal.c | 66 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index c5079f9..f863956 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -291,6 +291,44 @@ static const struct tsadc_table v3_code_table[] = {
 	{TSADCV3_DATA_MASK, 125000},
 };
 
+static const struct tsadc_table v4_code_table[] = {
+	{TSADCV3_DATA_MASK, -40000},
+	{431, -40000},
+	{426, -35000},
+	{421, -30000},
+	{415, -25000},
+	{410, -20000},
+	{405, -15000},
+	{399, -10000},
+	{394, -5000},
+	{389, 0},
+	{383, 5000},
+	{378, 10000},
+	{373, 15000},
+	{367, 20000},
+	{362, 25000},
+	{357, 30000},
+	{351, 35000},
+	{346, 40000},
+	{340, 45000},
+	{335, 50000},
+	{330, 55000},
+	{324, 60000},
+	{319, 65000},
+	{313, 70000},
+	{308, 75000},
+	{302, 80000},
+	{297, 85000},
+	{291, 90000},
+	{286, 95000},
+	{281, 100000},
+	{275, 105000},
+	{270, 110000},
+	{264, 115000},
+	{259, 120000},
+	{253, 125000},
+};
+
 static u32 rk_tsadcv2_temp_to_code(struct chip_tsadc_table table,
 				   int temp)
 {
@@ -554,6 +592,30 @@ static const struct rockchip_tsadc_chip rk3368_tsadc_data = {
 	},
 };
 
+static const struct rockchip_tsadc_chip rk3399_tsadc_data = {
+	.chn_id[SENSOR_CPU] = 0, /* cpu sensor is channel 0 */
+	.chn_id[SENSOR_GPU] = 1, /* gpu sensor is channel 1 */
+	.chn_num = 2, /* two channels for tsadc */
+
+	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
+	.tshut_polarity = TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
+	.tshut_temp = 95000,
+
+	.initialize = rk_tsadcv2_initialize,
+	.irq_ack = rk_tsadcv2_irq_ack,
+	.control = rk_tsadcv2_control,
+	.get_temp = rk_tsadcv2_get_temp,
+	.set_tshut_temp = rk_tsadcv2_tshut_temp,
+	.set_tshut_mode = rk_tsadcv2_tshut_mode,
+
+	.table = {
+		.id = v4_code_table,
+		.length = ARRAY_SIZE(v4_code_table),
+		.data_mask = TSADCV3_DATA_MASK,
+		.mode = ADC_DECREMENT,
+	},
+};
+
 static const struct of_device_id of_rockchip_thermal_match[] = {
 	{
 		.compatible = "rockchip,rk3228-tsadc",
@@ -567,6 +629,10 @@ static const struct of_device_id of_rockchip_thermal_match[] = {
 		.compatible = "rockchip,rk3368-tsadc",
 		.data = (void *)&rk3368_tsadc_data,
 	},
+	{
+		.compatible = "rockchip,rk3399-tsadc",
+		.data = (void *)&rk3399_tsadc_data,
+	},
 	{ /* end */ },
 };
 MODULE_DEVICE_TABLE(of, of_rockchip_thermal_match);
-- 
1.9.1
