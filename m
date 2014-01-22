From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] PM / devfreq: Disable Exynos4 driver build on multiplatform
Date: Wed, 22 Jan 2014 14:18:32 +0530
Message-ID: <1390380512-7490-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:48864 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751397AbaAVIxA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 Jan 2014 03:53:00 -0500
Received: by mail-pa0-f52.google.com with SMTP id bj1so98361pad.25
        for <linux-pm@vger.kernel.org>; Wed, 22 Jan 2014 00:53:00 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: myungjoo.ham@samsung.com, sachin.kamat@linaro.org, patches@linaro.org, kyungmin.park@samsung.com

Exynos4 devfreq driver uses mach/map.h which is not available on
multiplatform. Hence disable build on multiplatform for now.
Without this patch we get the following build errors:
drivers/devfreq/exynos/exynos4_bus.h:15:22: fatal error: mach/map.h: No such file or directory

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/devfreq/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
index 31f3adba4cf3..7d2f43550700 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -67,7 +67,7 @@ comment "DEVFREQ Drivers"
 
 config ARM_EXYNOS4_BUS_DEVFREQ
 	bool "ARM Exynos4210/4212/4412 Memory Bus DEVFREQ Driver"
-	depends on CPU_EXYNOS4210 || SOC_EXYNOS4212 || SOC_EXYNOS4412
+	depends on (CPU_EXYNOS4210 || SOC_EXYNOS4212 || SOC_EXYNOS4412) && !ARCH_MULTIPLATFORM
 	select ARCH_HAS_OPP
 	select DEVFREQ_GOV_SIMPLE_ONDEMAND
 	help
-- 
1.7.9.5

