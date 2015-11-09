From: Caesar Wang <wxt@rock-chips.com>
Subject: [PATCH v4 07/10] thermal: rockchip: Support the RK3368 SoCs in thermal driver
Date: Mon,  9 Nov 2015 12:48:59 +0800
Message-ID: <1447044542-30859-8-git-send-email-wxt@rock-chips.com>
References: <1447044542-30859-1-git-send-email-wxt@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447044542-30859-1-git-send-email-wxt@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Heiko Stuebner <heiko@sntech.de>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-rockchip@lists.infradead.org, lkp@intel.com, Caesar Wang <wxt@rock-chips.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

The RK3368 SoCs support to 2 channel TS-ADC, the temperature criteria
of each channel can be configurable.

The system has two Temperature Sensors, channel 0 is for CPU,
and channel 1 is for GPU.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>

---

Changes in v4:
- :%s/sort_flag/mode.
- rename the 'drivers' to 'driver' in subject.

Changes in v3:
- :%s/flag/sort_flag
- fix the rk3368 sort_flag as increment mode.

Changes in v2:
- remove some unused, completed on other patchs.

Changes in v1: None

 drivers/thermal/rockchip_thermal.c | 72 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index 73d47f8..e845841 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -1,6 +1,9 @@
 /*
  * Copyright (c) 2014, Fuzhou Rockchip Electronics Co., Ltd
  *
+ * Copyright (c) 2015, Fuzhou Rockchip Electronics Co., Ltd
+ * Caesar Wang <wxt@rock-chips.com>
+ *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
  * version 2, as published by the Free Software Foundation.
@@ -153,6 +156,8 @@ struct rockchip_thermal_data {
 #define TSADCV2_INT_PD_CLEAR_MASK		~BIT(8)
 
 #define TSADCV2_DATA_MASK			0xfff
+#define TSADCV3_DATA_MASK			0x3ff
+
 #define TSADCV2_HIGHT_INT_DEBOUNCE_COUNT	4
 #define TSADCV2_HIGHT_TSHUT_DEBOUNCE_COUNT	4
 #define TSADCV2_AUTO_PERIOD_TIME		250 /* msec */
@@ -201,6 +206,45 @@ static const struct tsadc_table v2_code_table[] = {
 	{3421, 125000},
 };
 
+static const struct tsadc_table v3_code_table[] = {
+	{0, -40000},
+	{106, -40000},
+	{108, -35000},
+	{110, -30000},
+	{112, -25000},
+	{114, -20000},
+	{116, -15000},
+	{118, -10000},
+	{120, -5000},
+	{122, 0},
+	{124, 5000},
+	{126, 10000},
+	{128, 15000},
+	{130, 20000},
+	{132, 25000},
+	{134, 30000},
+	{136, 35000},
+	{138, 40000},
+	{140, 45000},
+	{142, 50000},
+	{144, 55000},
+	{146, 60000},
+	{148, 65000},
+	{150, 70000},
+	{152, 75000},
+	{154, 80000},
+	{156, 85000},
+	{158, 90000},
+	{160, 95000},
+	{162, 100000},
+	{163, 105000},
+	{165, 110000},
+	{167, 115000},
+	{169, 120000},
+	{171, 125000},
+	{TSADCV3_DATA_MASK, 125000},
+};
+
 static u32 rk_tsadcv2_temp_to_code(struct chip_tsadc_table table,
 				   int temp)
 {
@@ -409,11 +453,39 @@ static const struct rockchip_tsadc_chip rk3288_tsadc_data = {
 	},
 };
 
+static const struct rockchip_tsadc_chip rk3368_tsadc_data = {
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
+		.id = v3_code_table,
+		.length = ARRAY_SIZE(v3_code_table),
+		.data_mask = TSADCV3_DATA_MASK,
+		.mode = ADC_INCREMENT,
+	},
+};
+
 static const struct of_device_id of_rockchip_thermal_match[] = {
 	{
 		.compatible = "rockchip,rk3288-tsadc",
 		.data = (void *)&rk3288_tsadc_data,
 	},
+	{
+		.compatible = "rockchip,rk3368-tsadc",
+		.data = (void *)&rk3368_tsadc_data,
+	},
 	{ /* end */ },
 };
 MODULE_DEVICE_TABLE(of, of_rockchip_thermal_match);
-- 
1.9.1
