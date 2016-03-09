From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 08/13] thermal: convert qcom-spmi to use devm_thermal_zone_of_sensor_register
Date: Wed,  9 Mar 2016 13:35:30 -0800
Message-ID: <1457559336-17652-9-git-send-email-edubezval@gmail.com>
References: <1457559336-17652-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33581 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754026AbcCIVfu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Mar 2016 16:35:50 -0500
In-Reply-To: <1457559336-17652-1-git-send-email-edubezval@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org, Eduardo Valentin <edubezval@gmail.com>

This changes the driver to use the devm_ version
of thermal_zone_of_sensor_register and cleans
up the  local points and unregister calls.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/qcom-spmi-temp-alarm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/thermal/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom-spmi-temp-alarm.c
index b677aad..f8a3c60 100644
--- a/drivers/thermal/qcom-spmi-temp-alarm.c
+++ b/drivers/thermal/qcom-spmi-temp-alarm.c
@@ -260,7 +260,7 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto fail;
 
-	chip->tz_dev = thermal_zone_of_sensor_register(&pdev->dev, 0, chip,
+	chip->tz_dev = devm_thermal_zone_of_sensor_register(&pdev->dev, 0, chip,
 							&qpnp_tm_sensor_ops);
 	if (IS_ERR(chip->tz_dev)) {
 		dev_err(&pdev->dev, "failed to register sensor\n");
@@ -281,7 +281,6 @@ static int qpnp_tm_remove(struct platform_device *pdev)
 {
 	struct qpnp_tm_chip *chip = dev_get_drvdata(&pdev->dev);
 
-	thermal_zone_of_sensor_unregister(&pdev->dev, chip->tz_dev);
 	if (!IS_ERR(chip->adc))
 		iio_channel_release(chip->adc);
 
-- 
2.1.4

