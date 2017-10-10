From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 16/25] thermal/drivers/qcom-spmi: Use devm_iio_channel_get
Date: Tue, 10 Oct 2017 20:02:41 +0200
Message-ID: <1507658570-32675-16-git-send-email-daniel.lezcano@linaro.org>
References: <79a5f10c-0fb7-3e4f-caac-c1625904b137@linaro.org>
 <1507658570-32675-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1507658570-32675-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com, rui.zhang@intel.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kevin.wangtao@linaro.org
List-Id: linux-pm@vger.kernel.org

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
