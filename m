From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 3/6] Thermal: exynos: Remove redundant platform_set_drvdata()
Date: Fri,  3 May 2013 15:27:10 +0530
Message-ID: <1367575034-18432-3-git-send-email-sachin.kamat@linaro.org>
References: <1367575034-18432-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-da0-f41.google.com ([209.85.210.41]:34697 "EHLO
	mail-da0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761852Ab3ECKKP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 3 May 2013 06:10:15 -0400
Received: by mail-da0-f41.google.com with SMTP id y19so748590dan.14
        for <linux-pm@vger.kernel.org>; Fri, 03 May 2013 03:10:15 -0700 (PDT)
In-Reply-To: <1367575034-18432-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: eduardo.valentin@ti.com, rui.zhang@intel.com, sachin.kamat@linaro.org, patches@linaro.org

Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
driver is bound) removes the need to set driver data field to
NULL.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/thermal/exynos_thermal.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/thermal/exynos_thermal.c b/drivers/thermal/exynos_thermal.c
index d20ce9e..992ae6e 100644
--- a/drivers/thermal/exynos_thermal.c
+++ b/drivers/thermal/exynos_thermal.c
@@ -1001,7 +1001,6 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 
 	return 0;
 err_clk:
-	platform_set_drvdata(pdev, NULL);
 	clk_unprepare(data->clk);
 	return ret;
 }
@@ -1016,8 +1015,6 @@ static int exynos_tmu_remove(struct platform_device *pdev)
 
 	clk_unprepare(data->clk);
 
-	platform_set_drvdata(pdev, NULL);
-
 	return 0;
 }
 
-- 
1.7.9.5

