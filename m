From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 6/6] Thermal: spear: Remove redundant platform_set_drvdata()
Date: Fri,  3 May 2013 15:27:13 +0530
Message-ID: <1367575034-18432-6-git-send-email-sachin.kamat@linaro.org>
References: <1367575034-18432-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:59205 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763036Ab3ECKKZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 3 May 2013 06:10:25 -0400
Received: by mail-pa0-f42.google.com with SMTP id bj3so848239pad.1
        for <linux-pm@vger.kernel.org>; Fri, 03 May 2013 03:10:24 -0700 (PDT)
In-Reply-To: <1367575034-18432-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: eduardo.valentin@ti.com, rui.zhang@intel.com, sachin.kamat@linaro.org, patches@linaro.org, Vincenzo Frascino <vincenzo.frascino@st.com>

Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
driver is bound) removes the need to set driver data field to
NULL.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Vincenzo Frascino <vincenzo.frascino@st.com>
---
 drivers/thermal/spear_thermal.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/thermal/spear_thermal.c b/drivers/thermal/spear_thermal.c
index 3c5ee56..1a14eaa 100644
--- a/drivers/thermal/spear_thermal.c
+++ b/drivers/thermal/spear_thermal.c
@@ -174,7 +174,6 @@ static int spear_thermal_exit(struct platform_device *pdev)
 	struct spear_thermal_dev *stdev = spear_thermal->devdata;
 
 	thermal_zone_device_unregister(spear_thermal);
-	platform_set_drvdata(pdev, NULL);
 
 	/* Disable SPEAr Thermal Sensor */
 	actual_mask = readl_relaxed(stdev->thermal_base);
-- 
1.7.9.5

