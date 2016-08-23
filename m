From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] thermal: qoriq: Remove unnecessary platform_set_drvdata()
Date: Tue, 23 Aug 2016 15:01:28 +0000
Message-ID: <1471964488-28313-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34118 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751722AbcHWPBz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Aug 2016 11:01:55 -0400
Received: by mail-pf0-f195.google.com with SMTP id g202so8441036pfb.1
        for <linux-pm@vger.kernel.org>; Tue, 23 Aug 2016 08:01:54 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linux-pm@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

The driver core clears the driver data to NULL after device_release
or on probe failure. Thus, it is not needed to manually clear the
device driver data to NULL.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/thermal/qoriq_thermal.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 644ba52..d01eca0 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -217,15 +217,13 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 	data->sensor_id = qoriq_tmu_get_sensor_id();
 	if (data->sensor_id < 0) {
 		dev_err(&pdev->dev, "Failed to get sensor id\n");
-		ret = -ENODEV;
-		goto err_iomap;
+		return -ENODEV;
 	}
 
 	data->regs = of_iomap(np, 0);
 	if (!data->regs) {
 		dev_err(&pdev->dev, "Failed to get memory region\n");
-		ret = -ENODEV;
-		goto err_iomap;
+		return -ENODEV;
 	}
 
 	qoriq_tmu_init_device(data);	/* TMU initialization */
@@ -254,9 +252,6 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 err_tmu:
 	iounmap(data->regs);
 
-err_iomap:
-	platform_set_drvdata(pdev, NULL);
-
 	return ret;
 }
 
@@ -270,7 +265,6 @@ static int qoriq_tmu_remove(struct platform_device *pdev)
 	tmu_write(data, TMR_DISABLE, &data->regs->tmr);
 
 	iounmap(data->regs);
-	platform_set_drvdata(pdev, NULL);
 
 	return 0;
 }



