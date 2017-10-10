From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 14/25] thermal/drivers/generic-iio-adc: Switch tz request to devm version
Date: Tue, 10 Oct 2017 20:02:39 +0200
Message-ID: <1507658570-32675-14-git-send-email-daniel.lezcano@linaro.org>
References: <79a5f10c-0fb7-3e4f-caac-c1625904b137@linaro.org>
 <1507658570-32675-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1507658570-32675-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com, rui.zhang@intel.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kevin.wangtao@linaro.org, Laxman Dewangan <ldewangan@nvidia.com>
List-Id: linux-pm@vger.kernel.org

Everything mentionned here:
 https://lkml.org/lkml/2016/4/20/850

This driver was added before the devm_iio_channel_get() function version was
merged. The sensor should be released before the iio channel, thus we had to
use the non-devm version of thermal_zone_of_sensor_register().

Now the devm_iio_channel_get() is available, do the corresponding change in
this driver and remove gadc_thermal_remove().

[Compiled tested only]

Acked-by: Laxman Dewangan <ldewangan@nvidia.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal-generic-adc.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/drivers/thermal/thermal-generic-adc.c b/drivers/thermal/thermal-generic-adc.c
index 73f55d6..46d3005 100644
--- a/drivers/thermal/thermal-generic-adc.c
+++ b/drivers/thermal/thermal-generic-adc.c
@@ -126,38 +126,23 @@ static int gadc_thermal_probe(struct platform_device *pdev)
 	gti->dev = &pdev->dev;
 	platform_set_drvdata(pdev, gti);
 
-	gti->channel = iio_channel_get(&pdev->dev, "sensor-channel");
+	gti->channel = devm_iio_channel_get(&pdev->dev, "sensor-channel");
 	if (IS_ERR(gti->channel)) {
 		ret = PTR_ERR(gti->channel);
 		dev_err(&pdev->dev, "IIO channel not found: %d\n", ret);
 		return ret;
 	}
 
-	gti->tz_dev = thermal_zone_of_sensor_register(&pdev->dev, 0,
-						      gti, &gadc_thermal_ops);
+	gti->tz_dev = devm_thermal_zone_of_sensor_register(&pdev->dev, 0, gti,
+							   &gadc_thermal_ops);
 	if (IS_ERR(gti->tz_dev)) {
 		ret = PTR_ERR(gti->tz_dev);
 		dev_err(&pdev->dev, "Thermal zone sensor register failed: %d\n",
 			ret);
-		goto sensor_fail;
+		return ret;
 	}
 
 	return 0;
-
-sensor_fail:
-	iio_channel_release(gti->channel);
-
-	return ret;
-}
-
-static int gadc_thermal_remove(struct platform_device *pdev)
-{
-	struct gadc_thermal_info *gti = platform_get_drvdata(pdev);
-
-	thermal_zone_of_sensor_unregister(&pdev->dev, gti->tz_dev);
-	iio_channel_release(gti->channel);
-
-	return 0;
 }
 
 static const struct of_device_id of_adc_thermal_match[] = {
@@ -172,7 +157,6 @@ static struct platform_driver gadc_thermal_driver = {
 		.of_match_table = of_adc_thermal_match,
 	},
 	.probe = gadc_thermal_probe,
-	.remove = gadc_thermal_remove,
 };
 
 module_platform_driver(gadc_thermal_driver);
-- 
2.7.4
