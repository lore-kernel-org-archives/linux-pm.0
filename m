From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 12/16] power: supply: axp288_fuel_gauge: Get iio-channels once during boot
Date: Tue, 26 Dec 2017 13:59:10 +0100
Message-ID: <20171226125914.10235-12-hdegoede@redhat.com>
References: <20171226125914.10235-1-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46390 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750705AbdLZM7a (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 26 Dec 2017 07:59:30 -0500
In-Reply-To: <20171226125914.10235-1-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org

Get iio-channels once during boot, delaying the probe if the axp288_adc
drivers has not loaded yet, instead of getting them on demand each time
we need them.

This fixes the following errors in dmesg:

axp288_fuel_gauge axp288_fuel_gauge: ADC charge current read failed:-19

Which were caused by the ondemand iio-channel read code not finding the
channel when the axp288_adc driver had not loaded yet.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/axp288_fuel_gauge.c | 110 +++++++++++++++++++------------
 1 file changed, 67 insertions(+), 43 deletions(-)

diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/supply/axp288_fuel_gauge.c
index a8dcabc32721..eb60f75f00d7 100644
--- a/drivers/power/supply/axp288_fuel_gauge.c
+++ b/drivers/power/supply/axp288_fuel_gauge.c
@@ -1,6 +1,7 @@
 /*
  * axp288_fuel_gauge.c - Xpower AXP288 PMIC Fuel Gauge Driver
  *
+ * Copyright (C) 2016-2017 Hans de Goede <hdegoede@redhat.com>
  * Copyright (C) 2014 Intel Corporation
  *
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -100,11 +101,22 @@ enum {
 	WL1_IRQ,
 };
 
+enum {
+	BAT_TEMP = 0,
+	PMIC_TEMP,
+	SYSTEM_TEMP,
+	BAT_CHRG_CURR,
+	BAT_D_CURR,
+	BAT_VOLT,
+	IIO_CHANNEL_NUM
+};
+
 struct axp288_fg_info {
 	struct platform_device *pdev;
 	struct regmap *regmap;
 	struct regmap_irq_chip_data *regmap_irqc;
 	int irq[AXP288_FG_INTR_NUM];
+	struct iio_channel *iio_channel[IIO_CHANNEL_NUM];
 	struct power_supply *bat;
 	struct mutex lock;
 	int status;
@@ -199,33 +211,6 @@ static int fuel_gauge_read_12bit_word(struct axp288_fg_info *info, int reg)
 	return (buf[0] << 4) | ((buf[1] >> 4) & 0x0f);
 }
 
-static int pmic_read_adc_val(const char *name, int *raw_val,
-		struct axp288_fg_info *info)
-{
-	int ret, val = 0;
-	struct iio_channel *indio_chan;
-
-	indio_chan = iio_channel_get(NULL, name);
-	if (IS_ERR_OR_NULL(indio_chan)) {
-		ret = PTR_ERR(indio_chan);
-		goto exit;
-	}
-	ret = iio_read_channel_raw(indio_chan, &val);
-	if (ret < 0) {
-		dev_err(&info->pdev->dev,
-			"IIO channel read error: %x, %x\n", ret, val);
-		goto err_exit;
-	}
-
-	dev_dbg(&info->pdev->dev, "adc raw val=%x\n", val);
-	*raw_val = val;
-
-err_exit:
-	iio_channel_release(indio_chan);
-exit:
-	return ret;
-}
-
 #ifdef CONFIG_DEBUG_FS
 static int fuel_gauge_debug_show(struct seq_file *s, void *data)
 {
@@ -296,22 +281,22 @@ static int fuel_gauge_debug_show(struct seq_file *s, void *data)
 		AXP288_FG_TUNE5,
 		fuel_gauge_reg_readb(info, AXP288_FG_TUNE5));
 
-	ret = pmic_read_adc_val("axp288-batt-temp", &raw_val, info);
+	ret = iio_read_channel_raw(info->iio_channel[BAT_TEMP], &raw_val);
 	if (ret >= 0)
 		seq_printf(s, "axp288-batttemp : %d\n", raw_val);
-	ret = pmic_read_adc_val("axp288-pmic-temp", &raw_val, info);
+	ret = iio_read_channel_raw(info->iio_channel[PMIC_TEMP], &raw_val);
 	if (ret >= 0)
 		seq_printf(s, "axp288-pmictemp : %d\n", raw_val);
-	ret = pmic_read_adc_val("axp288-system-temp", &raw_val, info);
+	ret = iio_read_channel_raw(info->iio_channel[SYSTEM_TEMP], &raw_val);
 	if (ret >= 0)
 		seq_printf(s, "axp288-systtemp : %d\n", raw_val);
-	ret = pmic_read_adc_val("axp288-chrg-curr", &raw_val, info);
+	ret = iio_read_channel_raw(info->iio_channel[BAT_CHRG_CURR], &raw_val);
 	if (ret >= 0)
 		seq_printf(s, "axp288-chrgcurr : %d\n", raw_val);
-	ret = pmic_read_adc_val("axp288-chrg-d-curr", &raw_val, info);
+	ret = iio_read_channel_raw(info->iio_channel[BAT_D_CURR], &raw_val);
 	if (ret >= 0)
 		seq_printf(s, "axp288-dchrgcur : %d\n", raw_val);
-	ret = pmic_read_adc_val("axp288-batt-volt", &raw_val, info);
+	ret = iio_read_channel_raw(info->iio_channel[BAT_VOLT], &raw_val);
 	if (ret >= 0)
 		seq_printf(s, "axp288-battvolt : %d\n", raw_val);
 
@@ -360,13 +345,13 @@ static void fuel_gauge_get_status(struct axp288_fg_info *info)
 			"PWR STAT read failed:%d\n", pwr_stat);
 		return;
 	}
-	ret = pmic_read_adc_val("axp288-chrg-curr", &charge, info);
+	ret = iio_read_channel_raw(info->iio_channel[BAT_CHRG_CURR], &charge);
 	if (ret < 0) {
 		dev_err(&info->pdev->dev,
 			"ADC charge current read failed:%d\n", ret);
 		return;
 	}
-	ret = pmic_read_adc_val("axp288-chrg-d-curr", &discharge, info);
+	ret = iio_read_channel_raw(info->iio_channel[BAT_D_CURR], &discharge);
 	if (ret < 0) {
 		dev_err(&info->pdev->dev,
 			"ADC discharge current read failed:%d\n", ret);
@@ -389,7 +374,7 @@ static int fuel_gauge_get_vbatt(struct axp288_fg_info *info, int *vbatt)
 {
 	int ret = 0, raw_val;
 
-	ret = pmic_read_adc_val("axp288-batt-volt", &raw_val, info);
+	ret = iio_read_channel_raw(info->iio_channel[BAT_VOLT], &raw_val);
 	if (ret < 0)
 		goto vbatt_read_fail;
 
@@ -403,10 +388,10 @@ static int fuel_gauge_get_current(struct axp288_fg_info *info, int *cur)
 	int ret, value = 0;
 	int charge, discharge;
 
-	ret = pmic_read_adc_val("axp288-chrg-curr", &charge, info);
+	ret = iio_read_channel_raw(info->iio_channel[BAT_CHRG_CURR], &charge);
 	if (ret < 0)
 		goto current_read_fail;
-	ret = pmic_read_adc_val("axp288-chrg-d-curr", &discharge, info);
+	ret = iio_read_channel_raw(info->iio_channel[BAT_D_CURR], &discharge);
 	if (ret < 0)
 		goto current_read_fail;
 
@@ -700,10 +685,18 @@ static void fuel_gauge_init_irq(struct axp288_fg_info *info)
 
 static int axp288_fuel_gauge_probe(struct platform_device *pdev)
 {
-	int ret = 0;
+	int i, ret = 0;
 	struct axp288_fg_info *info;
 	struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
 	struct power_supply_config psy_cfg = {};
+	static const char * const iio_chan_name[] = {
+		[BAT_TEMP] = "axp288-batt-temp",
+		[PMIC_TEMP] = "axp288-pmic-temp",
+		[SYSTEM_TEMP] = "axp288-system-temp",
+		[BAT_CHRG_CURR] = "axp288-chrg-curr",
+		[BAT_D_CURR] = "axp288-chrg-d-curr",
+		[BAT_VOLT] = "axp288-batt-volt",
+	};
 
 	info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
 	if (!info)
@@ -719,18 +712,39 @@ static int axp288_fuel_gauge_probe(struct platform_device *pdev)
 	mutex_init(&info->lock);
 	INIT_DELAYED_WORK(&info->status_monitor, fuel_gauge_status_monitor);
 
+	for (i = 0; i < IIO_CHANNEL_NUM; i++) {
+		/*
+		 * Note cannot use devm_iio_channel_get because x86 systems
+		 * lack the device<->channel maps which iio_channel_get will
+		 * try to use when passed a non NULL device pointer.
+		 */
+		info->iio_channel[i] =
+			iio_channel_get(NULL, iio_chan_name[i]);
+		if (IS_ERR(info->iio_channel[i])) {
+			ret = PTR_ERR(info->iio_channel[i]);
+			dev_dbg(&pdev->dev, "error getting iiochan %s: %d\n",
+				iio_chan_name[i], ret);
+			/* Wait for axp288_adc to load */
+			if (ret == -ENODEV)
+				ret = -EPROBE_DEFER;
+
+			goto out_free_iio_chan;
+		}
+	}
+
 	ret = fuel_gauge_reg_readb(info, AXP288_FG_DES_CAP1_REG);
 	if (ret < 0)
-		return ret;
+		goto out_free_iio_chan;
 
 	if (!(ret & FG_DES_CAP1_VALID)) {
 		dev_err(&pdev->dev, "axp288 not configured by firmware\n");
-		return -ENODEV;
+		ret = -ENODEV;
+		goto out_free_iio_chan;
 	}
 
 	ret = fuel_gauge_reg_readb(info, AXP20X_CHRG_CTRL1);
 	if (ret < 0)
-		return ret;
+		goto out_free_iio_chan;
 	switch ((ret & CHRG_CCCV_CV_MASK) >> CHRG_CCCV_CV_BIT_POS) {
 	case CHRG_CCCV_CV_4100MV:
 		info->max_volt = 4100;
@@ -751,7 +765,7 @@ static int axp288_fuel_gauge_probe(struct platform_device *pdev)
 	if (IS_ERR(info->bat)) {
 		ret = PTR_ERR(info->bat);
 		dev_err(&pdev->dev, "failed to register battery: %d\n", ret);
-		return ret;
+		goto out_free_iio_chan;
 	}
 
 	fuel_gauge_create_debugfs(info);
@@ -759,6 +773,13 @@ static int axp288_fuel_gauge_probe(struct platform_device *pdev)
 	schedule_delayed_work(&info->status_monitor, STATUS_MON_DELAY_JIFFIES);
 
 	return 0;
+
+out_free_iio_chan:
+	for (i = 0; i < IIO_CHANNEL_NUM; i++)
+		if (!IS_ERR_OR_NULL(info->iio_channel[i]))
+			iio_channel_release(info->iio_channel[i]);
+
+	return ret;
 }
 
 static const struct platform_device_id axp288_fg_id_table[] = {
@@ -780,6 +801,9 @@ static int axp288_fuel_gauge_remove(struct platform_device *pdev)
 		if (info->irq[i] >= 0)
 			free_irq(info->irq[i], info);
 
+	for (i = 0; i < IIO_CHANNEL_NUM; i++)
+		iio_channel_release(info->iio_channel[i]);
+
 	return 0;
 }
 
-- 
2.14.3
