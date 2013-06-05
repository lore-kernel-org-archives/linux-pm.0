From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 2/3] PM / devfreq: Remove redundant platform_set_drvdata() in exynos5_bus.c
Date: Wed,  5 Jun 2013 11:43:00 +0530
Message-ID: <1370412781-20683-2-git-send-email-sachin.kamat@linaro.org>
References: <1370412781-20683-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f49.google.com ([209.85.160.49]:58014 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268Ab3FEG1W (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 5 Jun 2013 02:27:22 -0400
Received: by mail-pb0-f49.google.com with SMTP id jt11so1333041pbb.36
        for <linux-pm@vger.kernel.org>; Tue, 04 Jun 2013 23:27:21 -0700 (PDT)
In-Reply-To: <1370412781-20683-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, a.kesavan@samsung.com, sachin.kamat@linaro.org, patches@linaro.org

Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
driver is bound) removes the need to set driver data field to
NULL.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/devfreq/exynos/exynos5_bus.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/devfreq/exynos/exynos5_bus.c b/drivers/devfreq/exynos/exynos5_bus.c
index cd1e630..9a82419 100644
--- a/drivers/devfreq/exynos/exynos5_bus.c
+++ b/drivers/devfreq/exynos/exynos5_bus.c
@@ -419,7 +419,6 @@ static int exynos5_busfreq_int_probe(struct platform_device *pdev)
 
 err_devfreq_add:
 	devfreq_remove_device(data->devfreq);
-	platform_set_drvdata(pdev, NULL);
 err_opp_add:
 	clk_put(data->int_clk);
 err_clock:
@@ -437,7 +436,6 @@ static int exynos5_busfreq_int_remove(struct platform_device *pdev)
 	devfreq_remove_device(data->devfreq);
 	regulator_put(data->vdd_int);
 	clk_put(data->int_clk);
-	platform_set_drvdata(pdev, NULL);
 
 	return 0;
 }
-- 
1.7.9.5

