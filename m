From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/6] Thermal: armada_thermal: Remove redundant platform_set_drvdata()
Date: Fri,  3 May 2013 15:27:08 +0530
Message-ID: <1367575034-18432-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:52232 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760354Ab3ECKKK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 3 May 2013 06:10:10 -0400
Received: by mail-pa0-f54.google.com with SMTP id kx1so850550pab.41
        for <linux-pm@vger.kernel.org>; Fri, 03 May 2013 03:10:09 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: eduardo.valentin@ti.com, rui.zhang@intel.com, sachin.kamat@linaro.org, patches@linaro.org, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
driver is bound) removes the need to set driver data field to
NULL.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/thermal/armada_thermal.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index 5b4d75f..0d02d4e 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -210,7 +210,6 @@ static int armada_thermal_exit(struct platform_device *pdev)
 		platform_get_drvdata(pdev);
 
 	thermal_zone_device_unregister(armada_thermal);
-	platform_set_drvdata(pdev, NULL);
 
 	return 0;
 }
-- 
1.7.9.5

