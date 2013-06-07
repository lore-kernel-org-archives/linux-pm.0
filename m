From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] PM / devfreq: Remove duplicate header file inclusion in exynos5_bus.c
Date: Fri,  7 Jun 2013 14:25:49 +0530
Message-ID: <1370595349-6469-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:55451 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752633Ab3FGJKK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 7 Jun 2013 05:10:10 -0400
Received: by mail-pd0-f180.google.com with SMTP id 10so4557172pdi.11
        for <linux-pm@vger.kernel.org>; Fri, 07 Jun 2013 02:10:10 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, sachin.kamat@linaro.org, patches@linaro.org

linux/opp.h was included twice.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/devfreq/exynos/exynos5_bus.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/devfreq/exynos/exynos5_bus.c b/drivers/devfreq/exynos/exynos5_bus.c
index 102d1f0..04c164e 100644
--- a/drivers/devfreq/exynos/exynos5_bus.c
+++ b/drivers/devfreq/exynos/exynos5_bus.c
@@ -18,7 +18,6 @@
 #include <linux/opp.h>
 #include <linux/slab.h>
 #include <linux/suspend.h>
-#include <linux/opp.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/platform_device.h>
-- 
1.7.9.5

