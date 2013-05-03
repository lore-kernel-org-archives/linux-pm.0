From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 2/6] Thermal: dove_thermal: Remove redundant platform_set_drvdata()
Date: Fri,  3 May 2013 15:27:09 +0530
Message-ID: <1367575034-18432-2-git-send-email-sachin.kamat@linaro.org>
References: <1367575034-18432-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f45.google.com ([209.85.160.45]:48634 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760354Ab3ECKKM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 3 May 2013 06:10:12 -0400
Received: by mail-pb0-f45.google.com with SMTP id ro12so829546pbb.32
        for <linux-pm@vger.kernel.org>; Fri, 03 May 2013 03:10:12 -0700 (PDT)
In-Reply-To: <1367575034-18432-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: eduardo.valentin@ti.com, rui.zhang@intel.com, sachin.kamat@linaro.org, patches@linaro.org, Andrew Lunn <andrew@lunn.ch>

Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
driver is bound) removes the need to set driver data field to
NULL.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Andrew Lunn <andrew@lunn.ch>
---
 drivers/thermal/dove_thermal.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/thermal/dove_thermal.c b/drivers/thermal/dove_thermal.c
index 4b15a5f..900479e 100644
--- a/drivers/thermal/dove_thermal.c
+++ b/drivers/thermal/dove_thermal.c
@@ -182,7 +182,6 @@ static int dove_thermal_exit(struct platform_device *pdev)
 		platform_get_drvdata(pdev);
 
 	thermal_zone_device_unregister(dove_thermal);
-	platform_set_drvdata(pdev, NULL);
 
 	return 0;
 }
-- 
1.7.9.5

