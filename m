From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 2/2] Thermal: exynos: Add compatible string for exynos4412
Date: Thu, 18 Apr 2013 17:07:59 +0530
Message-ID: <1366285079-10395-2-git-send-email-sachin.kamat@linaro.org>
References: <1366285079-10395-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-da0-f51.google.com ([209.85.210.51]:41934 "EHLO
	mail-da0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967170Ab3DRLuX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Apr 2013 07:50:23 -0400
Received: by mail-da0-f51.google.com with SMTP id g27so1324868dan.10
        for <linux-pm@vger.kernel.org>; Thu, 18 Apr 2013 04:50:22 -0700 (PDT)
In-Reply-To: <1366285079-10395-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rui.zhang@intel.com, eduardo.valentin@ti.com, sachin.kamat@linaro.org, kgene.kim@samsung.com, patches@linaro.org, Amit Daniel Kachhap <amit.daniel@samsung.com>

Added compatible string for Exynos4412 SoC.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Amit Daniel Kachhap <amit.daniel@samsung.com>
---
 drivers/thermal/exynos_thermal.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/thermal/exynos_thermal.c b/drivers/thermal/exynos_thermal.c
index 9df96e5..d20ce9e 100644
--- a/drivers/thermal/exynos_thermal.c
+++ b/drivers/thermal/exynos_thermal.c
@@ -855,6 +855,10 @@ static const struct of_device_id exynos_tmu_match[] = {
 		.data = (void *)EXYNOS4210_TMU_DRV_DATA,
 	},
 	{
+		.compatible = "samsung,exynos4412-tmu",
+		.data = (void *)EXYNOS_TMU_DRV_DATA,
+	},
+	{
 		.compatible = "samsung,exynos5250-tmu",
 		.data = (void *)EXYNOS_TMU_DRV_DATA,
 	},
-- 
1.7.9.5

