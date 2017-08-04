From: Rocky Hao <rocky.hao@rock-chips.com>
Subject: [PATCH v2 2/5] thermal: rockchip: Support the RK3328 SOC in thermal driver
Date: Fri,  4 Aug 2017 16:06:13 +0800
Message-ID: <1501833976-1100-3-git-send-email-rocky.hao@rock-chips.com>
References: <1501833976-1100-1-git-send-email-rocky.hao@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1501833976-1100-1-git-send-email-rocky.hao@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com, heiko@sntech.de, robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com
Cc: shawn.lin@rock-chips.com, cl@rock-chips.com, william.wu@rock-chips.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, xxx@rock-chips.com, jay.xu@rock-chips.com, wxt@rock-chips.com, huangtao@rock-chips.com, rocky.hao@rock-chips.com
List-Id: linux-pm@vger.kernel.org

RK3328 SOC has one Temperature Sensor for CPU.

Signed-off-by: Rocky Hao <rocky.hao@rock-chips.com>
---
Change in v2:
- remove gerrit Change-Id

 drivers/thermal/rockchip_thermal.c | 65 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index 4c7796512453..206035139110 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -320,6 +320,44 @@ struct tsadc_table {
 	{0, 125000},
 };
 
+static const struct tsadc_table rk3328_code_table[] = {
+	{0, -40000},
+	{296, -40000},
+	{304, -35000},
+	{313, -30000},
+	{331, -20000},
+	{340, -15000},
+	{349, -10000},
+	{359, -5000},
+	{368, 0},
+	{378, 5000},
+	{388, 10000},
+	{398, 15000},
+	{408, 20000},
+	{418, 25000},
+	{429, 30000},
+	{440, 35000},
+	{451, 40000},
+	{462, 45000},
+	{473, 50000},
+	{485, 55000},
+	{496, 60000},
+	{508, 65000},
+	{521, 70000},
+	{533, 75000},
+	{546, 80000},
+	{559, 85000},
+	{572, 90000},
+	{586, 95000},
+	{600, 100000},
+	{614, 105000},
+	{629, 110000},
+	{644, 115000},
+	{659, 120000},
+	{675, 125000},
+	{TSADCV2_DATA_MASK, 125000},
+};
+
 static const struct tsadc_table rk3368_code_table[] = {
 	{0, -40000},
 	{106, -40000},
@@ -790,6 +828,29 @@ static void rk_tsadcv2_tshut_mode(int chn, void __iomem *regs,
 	},
 };
 
+static const struct rockchip_tsadc_chip rk3328_tsadc_data = {
+	.chn_id[SENSOR_CPU] = 0, /* cpu sensor is channel 0 */
+	.chn_num = 1, /* one channels for tsadc */
+
+	.tshut_mode = TSHUT_MODE_CRU, /* default TSHUT via CRU */
+	.tshut_temp = 95000,
+
+	.initialize = rk_tsadcv2_initialize,
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
 static const struct rockchip_tsadc_chip rk3366_tsadc_data = {
 	.chn_id[SENSOR_CPU] = 0, /* cpu sensor is channel 0 */
 	.chn_id[SENSOR_GPU] = 1, /* gpu sensor is channel 1 */
@@ -875,6 +936,10 @@ static void rk_tsadcv2_tshut_mode(int chn, void __iomem *regs,
 		.data = (void *)&rk3288_tsadc_data,
 	},
 	{
+		.compatible = "rockchip,rk3328-tsadc",
+		.data = (void *)&rk3328_tsadc_data,
+	},
+	{
 		.compatible = "rockchip,rk3366-tsadc",
 		.data = (void *)&rk3366_tsadc_data,
 	},
-- 
1.9.1
