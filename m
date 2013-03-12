From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/2] thermal: db8500: Fix missing mutex_unlock() in probe
 error paths
Date: Tue, 12 Mar 2013 23:43:29 +0800
Message-ID: <1363103009.3160.3.camel@phoenix>
References: <1363102940.3160.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:45864 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932148Ab3CLPnh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 Mar 2013 11:43:37 -0400
Received: by mail-ie0-f169.google.com with SMTP id 13so6674134iea.28
        for <linux-pm@vger.kernel.org>; Tue, 12 Mar 2013 08:43:37 -0700 (PDT)
In-Reply-To: <1363102940.3160.2.camel@phoenix>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Hongbo Zhang <hongbo.zhang@stericsson.com>, Viresh Kumar <viresh.kumar@linaro.org>, Francesco Lavra <francescolavra.fl@gmail.com>, linux-pm@vger.kernel.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/thermal/db8500_thermal.c |   17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/db8500_thermal.c b/drivers/thermal/db8500_thermal.c
index 6bdcec4..1e3b3bf 100644
--- a/drivers/thermal/db8500_thermal.c
+++ b/drivers/thermal/db8500_thermal.c
@@ -419,7 +419,8 @@ static int db8500_thermal_probe(struct platform_device *pdev)
 	low_irq = platform_get_irq_byname(pdev, "IRQ_HOTMON_LOW");
 	if (low_irq < 0) {
 		dev_err(&pdev->dev, "Get IRQ_HOTMON_LOW failed.\n");
-		return low_irq;
+		ret = low_irq;
+		goto out_unlock;
 	}
 
 	ret = devm_request_threaded_irq(&pdev->dev, low_irq, NULL,
@@ -427,13 +428,14 @@ static int db8500_thermal_probe(struct platform_device *pdev)
 		"dbx500_temp_low", pzone);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to allocate temp low irq.\n");
-		return ret;
+		goto out_unlock;
 	}
 
 	high_irq = platform_get_irq_byname(pdev, "IRQ_HOTMON_HIGH");
 	if (high_irq < 0) {
 		dev_err(&pdev->dev, "Get IRQ_HOTMON_HIGH failed.\n");
-		return high_irq;
+		ret = high_irq;
+		goto out_unlock;
 	}
 
 	ret = devm_request_threaded_irq(&pdev->dev, high_irq, NULL,
@@ -441,7 +443,7 @@ static int db8500_thermal_probe(struct platform_device *pdev)
 		"dbx500_temp_high", pzone);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to allocate temp high irq.\n");
-		return ret;
+		goto out_unlock;
 	}
 
 	pzone->therm_dev = thermal_zone_device_register("db8500_thermal_zone",
@@ -449,7 +451,8 @@ static int db8500_thermal_probe(struct platform_device *pdev)
 
 	if (IS_ERR(pzone->therm_dev)) {
 		dev_err(&pdev->dev, "Register thermal zone device failed.\n");
-		return PTR_ERR(pzone->therm_dev);
+		ret = PTR_ERR(pzone->therm_dev);
+		goto out_unlock;
 	}
 	dev_info(&pdev->dev, "Thermal zone device registered.\n");
 
@@ -461,9 +464,11 @@ static int db8500_thermal_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, pzone);
 	pzone->mode = THERMAL_DEVICE_ENABLED;
+
+out_unlock:
 	mutex_unlock(&pzone->th_lock);
 
-	return 0;
+	return ret;
 }
 
 static int db8500_thermal_remove(struct platform_device *pdev)
-- 
1.7.9.5



