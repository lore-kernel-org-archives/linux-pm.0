From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] thermal: exynos: Use of_match_ptr() macro
Date: Wed, 12 Dec 2012 15:54:24 +0530
Message-ID: <1355307864-22194-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:48159 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751343Ab2LLKbg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 12 Dec 2012 05:31:36 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so442245pbc.19
        for <linux-pm@vger.kernel.org>; Wed, 12 Dec 2012 02:31:35 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rui.zhang@intel.com, sachin.kamat@linaro.org, patches@linaro.org

This eliminates having an #ifdef returning NULL for the case
when OF is disabled.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/thermal/exynos_thermal.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/exynos_thermal.c b/drivers/thermal/exynos_thermal.c
index 7772d16..3f6a54a 100644
--- a/drivers/thermal/exynos_thermal.c
+++ b/drivers/thermal/exynos_thermal.c
@@ -800,8 +800,6 @@ static const struct of_device_id exynos_tmu_match[] = {
 	{},
 };
 MODULE_DEVICE_TABLE(of, exynos_tmu_match);
-#else
-#define  exynos_tmu_match NULL
 #endif
 
 static struct platform_device_id exynos_tmu_driver_ids[] = {
@@ -982,7 +980,7 @@ static struct platform_driver exynos_tmu_driver = {
 		.name   = "exynos-tmu",
 		.owner  = THIS_MODULE,
 		.pm     = EXYNOS_TMU_PM,
-		.of_match_table = exynos_tmu_match,
+		.of_match_table = of_match_ptr(exynos_tmu_match),
 	},
 	.probe = exynos_tmu_probe,
 	.remove	= __devexit_p(exynos_tmu_remove),
-- 
1.7.4.1

