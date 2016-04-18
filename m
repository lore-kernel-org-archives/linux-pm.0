From: Caesar Wang <wxt@rock-chips.com>
Subject: [PATCH 5/9] thermal: rockchip: Support RK3366 SoCs in the thermal driver
Date: Mon, 18 Apr 2016 11:35:57 +0800
Message-ID: <1460950562-20652-6-git-send-email-wxt@rock-chips.com>
References: <1460950562-20652-1-git-send-email-wxt@rock-chips.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36574 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752056AbcDRDhz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 17 Apr 2016 23:37:55 -0400
In-Reply-To: <1460950562-20652-1-git-send-email-wxt@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: edubezval@gmail.com
Cc: Heiko Stuebner <heiko@sntech.de>, dianders@chromium.org, briannorris@google.com, smbarber@google.com, linux-rockchip@lists.infradead.org, Elaine Zhang <zhangqing@rock-chips.com>, Caesar Wang <wxt@rock-chips.com>, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

From: Elaine Zhang <zhangqing@rock-chips.com>

The RK3366 SoCs have two Temperature Sensors, channel 0 is for CPU
channel 1 is for GPU.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

 drivers/thermal/rockchip_thermal.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index 3cb2e94..00c12c0 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -673,6 +673,30 @@ static const struct rockchip_tsadc_chip rk3288_tsadc_data = {
 	},
 };
 
+static const struct rockchip_tsadc_chip rk3366_tsadc_data = {
+	.chn_id[SENSOR_CPU] = 0, /* cpu sensor is channel 0 */
+	.chn_id[SENSOR_GPU] = 1, /* gpu sensor is channel 1 */
+	.chn_num = 2, /* two channels for tsadc */
+
+	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
+	.tshut_polarity = TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
+	.tshut_temp = 95000,
+
+	.initialize = rk_tsadcv3_initialize,
+	.irq_ack = rk_tsadcv3_irq_ack,
+	.control = rk_tsadcv3_control,
+	.get_temp = rk_tsadcv2_get_temp,
+	.set_tshut_temp = rk_tsadcv2_tshut_temp,
+	.set_tshut_mode = rk_tsadcv2_tshut_mode,
+
+	.table = {
+		.id = rk3228_code_table,
+		.length = ARRAY_SIZE(rk3228_code_table),
+		.data_mask = TSADCV3_DATA_MASK,
+		.mode = ADC_INCREMENT,
+	},
+};
+
 static const struct rockchip_tsadc_chip rk3368_tsadc_data = {
 	.chn_id[SENSOR_CPU] = 0, /* cpu sensor is channel 0 */
 	.chn_id[SENSOR_GPU] = 1, /* gpu sensor is channel 1 */
@@ -731,6 +755,10 @@ static const struct of_device_id of_rockchip_thermal_match[] = {
 		.data = (void *)&rk3288_tsadc_data,
 	},
 	{
+		.compatible = "rockchip,rk3366-tsadc",
+		.data = (void *)&rk3366_tsadc_data,
+	},
+	{
 		.compatible = "rockchip,rk3368-tsadc",
 		.data = (void *)&rk3368_tsadc_data,
 	},
-- 
1.9.1

