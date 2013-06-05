From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/3] PM / devfreq: Fix incorrect usage of IS_ERR_OR_NULL in exynos5_bus.c
Date: Wed,  5 Jun 2013 11:42:59 +0530
Message-ID: <1370412781-20683-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:43093 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268Ab3FEG1S (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 5 Jun 2013 02:27:18 -0400
Received: by mail-pd0-f173.google.com with SMTP id v10so1358303pde.18
        for <linux-pm@vger.kernel.org>; Tue, 04 Jun 2013 23:27:18 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, a.kesavan@samsung.com, sachin.kamat@linaro.org, patches@linaro.org

platform_device_register_simple does not return NULL.
Hence NULL check is not required.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/devfreq/exynos/exynos5_bus.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/exynos/exynos5_bus.c b/drivers/devfreq/exynos/exynos5_bus.c
index 574b16b..cd1e630 100644
--- a/drivers/devfreq/exynos/exynos5_bus.c
+++ b/drivers/devfreq/exynos/exynos5_bus.c
@@ -479,7 +479,7 @@ static int __init exynos5_busfreq_int_init(void)
 
 	exynos5_devfreq_pdev =
 		platform_device_register_simple("exynos5-bus-int", -1, NULL, 0);
-	if (IS_ERR_OR_NULL(exynos5_devfreq_pdev)) {
+	if (IS_ERR(exynos5_devfreq_pdev)) {
 		ret = PTR_ERR(exynos5_devfreq_pdev);
 		goto out1;
 	}
-- 
1.7.9.5

