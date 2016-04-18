From: Caesar Wang <wxt@rock-chips.com>
Subject: [PATCH 6/9] thermal: rockchip: add the notes for better reading
Date: Mon, 18 Apr 2016 11:35:58 +0800
Message-ID: <1460950562-20652-7-git-send-email-wxt@rock-chips.com>
References: <1460950562-20652-1-git-send-email-wxt@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460950562-20652-1-git-send-email-wxt@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com
Cc: Heiko Stuebner <heiko@sntech.de>, dianders@chromium.org, briannorris@google.com, smbarber@google.com, linux-rockchip@lists.infradead.org, Caesar Wang <wxt@rock-chips.com>, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

To update the notes for keeping in mind that quickly in case
someone re-read this driver in the future.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>
---

 drivers/thermal/rockchip_thermal.c | 74 +++++++++++++++++++++++++++-----------
 1 file changed, 53 insertions(+), 21 deletions(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index 00c12c0..86a1ab0 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -1,7 +1,5 @@
 /*
- * Copyright (c) 2014, Fuzhou Rockchip Electronics Co., Ltd
- *
- * Copyright (c) 2015, Fuzhou Rockchip Electronics Co., Ltd
+ * Copyright (c) 2014-2016, Fuzhou Rockchip Electronics Co., Ltd
  * Caesar Wang <wxt@rock-chips.com>
  *
  * This program is free software; you can redistribute it and/or modify it
@@ -75,7 +73,7 @@ enum adc_sort_mode {
 #define SOC_MAX_SENSORS	2
 
 /**
- * struct chip_tsadc_table: hold information about chip-specific differences
+ * struct chip_tsadc_table - hold information about chip-specific differences
  * @id: conversion table
  * @length: size of conversion table
  * @data_mask: mask to apply on data inputs
@@ -88,6 +86,20 @@ struct chip_tsadc_table {
 	enum adc_sort_mode mode;
 };
 
+/**
+ * struct rockchip_tsadc_chip - hold the private data of tsadc chip
+ * @chn_id[SOC_MAX_SENSORS]: the sensor id of chip correspond to the channel
+ * @chn_num: the channel number of tsadc chip
+ * @tshut_temp: the hardware-controlled shutdown temperature value
+ * @tshut_mode: the hardware-controlled shutdown mode (0:CRU 1:GPIO)
+ * @tshut_polarity: the hardware-controlled active polarity (0:LOW 1:HIGH)
+ * @initialize: SoC special initialize tsadc controller method
+ * @irq_ack: clear the interrupt
+ * @get_temp: get the temperature
+ * @set_tshut_temp: set the hardware-controlled shutdown temperature
+ * @set_tshut_mode: set the hardware-controlled shutdown mode
+ * @table: the chip-specific conversion table
+ */
 struct rockchip_tsadc_chip {
 	/* The sensor id of chip correspond to the ADC channel */
 	int chn_id[SOC_MAX_SENSORS];
@@ -115,12 +127,32 @@ struct rockchip_tsadc_chip {
 	struct chip_tsadc_table table;
 };
 
+/**
+ * struct rockchip_thermal_sensor - hold the information of thermal sensor
+ * @thermal:  pointer to the platform/configuration data
+ * @tzd: pointer to a thermal zone
+ * @id: identifier of the thermal sensor
+ */
 struct rockchip_thermal_sensor {
 	struct rockchip_thermal_data *thermal;
 	struct thermal_zone_device *tzd;
 	int id;
 };
 
+/**
+ * struct rockchip_thermal_data - hold the private data of thermal driver
+ * @chip: pointer to the platform/configuration data
+ * @pdev: platform device of thermal
+ * @reset: the reset controller of tsadc
+ * @sensors[SOC_MAX_SENSORS]: the thermal sensor
+ * @clk: the controller clock is divided by the exteral 24MHz
+ * @pclk: the advanced peripherals bus clock
+ * @grf: the general register file will be used to do static set by software
+ * @regs: the base address of tsadc controller
+ * @tshut_temp: the hardware-controlled shutdown temperature value
+ * @tshut_mode: the hardware-controlled shutdown mode (0:CRU 1:GPIO)
+ * @tshut_polarity: the hardware-controlled active polarity (0:LOW 1:HIGH)
+ */
 struct rockchip_thermal_data {
 	const struct rockchip_tsadc_chip *chip;
 	struct platform_device *pdev;
@@ -160,12 +192,7 @@ struct rockchip_thermal_data {
 #define TSADCV2_AUTO_EN				BIT(0)
 #define TSADCV2_AUTO_SRC_EN(chn)		BIT(4 + (chn))
 #define TSADCV2_AUTO_TSHUT_POLARITY_HIGH	BIT(8)
-/**
- * TSADCV1_AUTO_Q_SEL_EN:
- * whether select (1024 - tsadc_q) as output
- * 1'b0:use tsadc_q as output(temperature-code is rising sequence)
- * 1'b1:use(1024 - tsadc_q) as output (temperature-code is falling sequence)
- */
+
 #define TSADCV3_AUTO_Q_SEL_EN			BIT(1)
 
 #define TSADCV2_INT_SRC_EN(chn)			BIT(chn)
@@ -193,18 +220,21 @@ struct rockchip_thermal_data {
 #define GRF_SARADC_TESTBIT_ON			(0x10001 << 2)
 #define GRF_TSADC_TESTBIT_H_ON			(0x10001 << 2)
 
-struct tsadc_table {
-	u32 code;
-	int temp;
-};
-
 /**
+ * struct tsadc_table - code to temperature conversion table
+ * @code: the value of adc channel
+ * @temp: the temperature
  * Note:
- * Code to Temperature mapping of the Temperature sensor is a piece wise linear
+ * code to temperature mapping of the temperature sensor is a piece wise linear
  * curve.Any temperature, code faling between to 2 give temperatures can be
  * linearly interpolated.
- * Code to Temperature mapping should be updated based on sillcon results.
+ * Code to Temperature mapping should be updated based on manufacturer results.
  */
+struct tsadc_table {
+	u32 code;
+	int temp;
+};
+
 static const struct tsadc_table rk3228_code_table[] = {
 	{0, -40000},
 	{588, -40000},
@@ -490,6 +520,7 @@ static void rk_tsadcv2_initialize(struct regmap *grf, void __iomem *regs,
 
 /**
  * rk_tsadcv3_initialize - initialize TASDC Controller.
+ *
  * (1) The tsadc control power sequence.
  *
  * (2) Set TSADC_V2_AUTO_PERIOD:
@@ -568,10 +599,11 @@ static void rk_tsadcv2_control(void __iomem *regs, bool enable)
 }
 
 /**
- * @rk_tsadcv3_control:
- * TSADC controller works at auto mode, and some SoCs need set the tsadc_q_sel
- * bit on TSADCV2_AUTO_CON[1]. The (1024 - tsadc_q) as output adc value if
- * setting this bit to enable.
+ * rk_tsadcv3_control - the tsadc controller is enabled or disabled.
+ *
+ * NOTE: TSADC controller works at auto mode, and some SoCs need set the
+ * tsadc_q_sel bit on TSADCV2_AUTO_CON[1]. The (1024 - tsadc_q) as output
+ * adc value if setting this bit to enable.
  */
 static void rk_tsadcv3_control(void __iomem *regs, bool enable)
 {
-- 
1.9.1
