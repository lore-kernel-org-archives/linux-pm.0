From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 4/6] Thermal: kirkwood: Remove redundant platform_set_drvdata()
Date: Fri,  3 May 2013 15:27:11 +0530
Message-ID: <1367575034-18432-4-git-send-email-sachin.kamat@linaro.org>
References: <1367575034-18432-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:46863 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763031Ab3ECKKT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 3 May 2013 06:10:19 -0400
Received: by mail-pd0-f178.google.com with SMTP id w11so831488pde.23
        for <linux-pm@vger.kernel.org>; Fri, 03 May 2013 03:10:18 -0700 (PDT)
In-Reply-To: <1367575034-18432-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: eduardo.valentin@ti.com, rui.zhang@intel.com, sachin.kamat@linaro.org, patches@linaro.org, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>

Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
driver is bound) removes the need to set driver data field to
NULL.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
---
 drivers/thermal/kirkwood_thermal.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/thermal/kirkwood_thermal.c b/drivers/thermal/kirkwood_thermal.c
index dfeceaf..b57a45d 100644
--- a/drivers/thermal/kirkwood_thermal.c
+++ b/drivers/thermal/kirkwood_thermal.c
@@ -108,7 +108,6 @@ static int kirkwood_thermal_exit(struct platform_device *pdev)
 		platform_get_drvdata(pdev);
 
 	thermal_zone_device_unregister(kirkwood_thermal);
-	platform_set_drvdata(pdev, NULL);
 
 	return 0;
 }
-- 
1.7.9.5

