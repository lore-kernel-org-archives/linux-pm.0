From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 5/6] Thermal: rcar: Remove redundant platform_set_drvdata()
Date: Fri,  3 May 2013 15:27:12 +0530
Message-ID: <1367575034-18432-5-git-send-email-sachin.kamat@linaro.org>
References: <1367575034-18432-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:36891 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763033Ab3ECKKW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 3 May 2013 06:10:22 -0400
Received: by mail-pd0-f173.google.com with SMTP id v10so844377pde.32
        for <linux-pm@vger.kernel.org>; Fri, 03 May 2013 03:10:21 -0700 (PDT)
In-Reply-To: <1367575034-18432-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: eduardo.valentin@ti.com, rui.zhang@intel.com, sachin.kamat@linaro.org, patches@linaro.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
driver is bound) removes the need to set driver data field to
NULL.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/thermal/rcar_thermal.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index 8d7edd4..63c7c13 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -487,8 +487,6 @@ static int rcar_thermal_remove(struct platform_device *pdev)
 			rcar_thermal_irq_disable(priv);
 	}
 
-	platform_set_drvdata(pdev, NULL);
-
 	pm_runtime_put_sync(dev);
 	pm_runtime_disable(dev);
 
-- 
1.7.9.5

