From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 18/18] thermal/drivers/qcom-spmi: Use devm_iio_channel_get
Date: Thu, 19 Oct 2017 19:06:00 +0200
Message-ID: <1508432760-17847-18-git-send-email-daniel.lezcano@linaro.org>
References: <6ac48f08-7fe6-92e9-0801-6ed3bcd05ff1@linaro.org>
 <1508432760-17847-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:49638 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755136AbdJSRI4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Oct 2017 13:08:56 -0400
Received: by mail-wr0-f193.google.com with SMTP id g90so9036813wrd.6
        for <linux-pm@vger.kernel.org>; Thu, 19 Oct 2017 10:08:56 -0700 (PDT)
In-Reply-To: <1508432760-17847-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: edubezval@gmail.com, rui.zhang@intel.com
Cc: linux-pm@vger.kernel.org, leo.yan@linaro.org, linux-kernel@vger.kernel.org

The iio_channel_get() function has now its devm_ version.

Use it and remove all the rollback code for iio_channel_release() as well
as the .remove ops.

[Compiled tested only]

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/qcom-spmi-temp-alarm.c | 43 +++++++++++-----------------------
 1 file changed, 14 insertions(+), 29 deletions(-)

diff --git a/drivers/thermal/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom-spmi-temp-alarm.c
index f502419..95f987d 100644
--- a/drivers/thermal/qcom-spmi-temp-alarm.c
+++ b/drivers/thermal/qcom-spmi-temp-alarm.c
@@ -125,7 +125,7 @@ static int qpnp_tm_get_temp(void *data, int *temp)
 	if (!temp)
 		return -EINVAL;
 
-	if (IS_ERR(chip->adc)) {
+	if (!chip->adc) {
 		ret = qpnp_tm_update_temp_no_adc(chip);
 		if (ret < 0)
 			return ret;
@@ -224,67 +224,53 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 		return irq;
 
 	/* ADC based measurements are optional */
-	chip->adc = iio_channel_get(&pdev->dev, "thermal");
-	if (PTR_ERR(chip->adc) == -EPROBE_DEFER)
-		return PTR_ERR(chip->adc);
+	chip->adc = devm_iio_channel_get(&pdev->dev, "thermal");
+	if (IS_ERR(chip->adc)) {
+		ret = PTR_ERR(chip->adc);
+		chip->adc = NULL;
+		if (ret == -EPROBE_DEFER)
+			return ret;
+	}
 
 	chip->base = res;
 
 	ret = qpnp_tm_read(chip, QPNP_TM_REG_TYPE, &type);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "could not read type\n");
-		goto fail;
+		return ret;
 	}
 
 	ret = qpnp_tm_read(chip, QPNP_TM_REG_SUBTYPE, &subtype);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "could not read subtype\n");
-		goto fail;
+		return ret;
 	}
 
 	if (type != QPNP_TM_TYPE || subtype != QPNP_TM_SUBTYPE) {
 		dev_err(&pdev->dev, "invalid type 0x%02x or subtype 0x%02x\n",
 			type, subtype);
-		ret = -ENODEV;
-		goto fail;
+		return -ENODEV;
 	}
 
 	ret = qpnp_tm_init(chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "init failed\n");
-		goto fail;
+		return ret;
 	}
 
 	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL, qpnp_tm_isr,
 					IRQF_ONESHOT, node->name, chip);
 	if (ret < 0)
-		goto fail;
+		return ret;
 
 	chip->tz_dev = devm_thermal_zone_of_sensor_register(&pdev->dev, 0, chip,
 							&qpnp_tm_sensor_ops);
 	if (IS_ERR(chip->tz_dev)) {
 		dev_err(&pdev->dev, "failed to register sensor\n");
-		ret = PTR_ERR(chip->tz_dev);
-		goto fail;
+		return PTR_ERR(chip->tz_dev);
 	}
 
 	return 0;
-
-fail:
-	if (!IS_ERR(chip->adc))
-		iio_channel_release(chip->adc);
-
-	return ret;
-}
-
-static int qpnp_tm_remove(struct platform_device *pdev)
-{
-	struct qpnp_tm_chip *chip = dev_get_drvdata(&pdev->dev);
-
-	if (!IS_ERR(chip->adc))
-		iio_channel_release(chip->adc);
-
-	return 0;
 }
 
 static const struct of_device_id qpnp_tm_match_table[] = {
@@ -299,7 +285,6 @@ static struct platform_driver qpnp_tm_driver = {
 		.of_match_table = qpnp_tm_match_table,
 	},
 	.probe  = qpnp_tm_probe,
-	.remove = qpnp_tm_remove,
 };
 module_platform_driver(qpnp_tm_driver);
 
-- 
2.7.4
