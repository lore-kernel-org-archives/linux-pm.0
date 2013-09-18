From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] cpufreq: exynos5440: Fix potential NULL pointer dereference
Date: Wed, 18 Sep 2013 10:44:53 +0530
Message-ID: <1379481293-9003-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:60913 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751652Ab3IRFdO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Sep 2013 01:33:14 -0400
Received: by mail-pd0-f175.google.com with SMTP id q10so6539269pdj.20
        for <linux-pm@vger.kernel.org>; Tue, 17 Sep 2013 22:33:13 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: cpufreq@vger.kernel.org
Cc: linux-pm@vger.kernel.org, rjw@sisk.pl, viresh.kumar@linaro.org, sachin.kamat@linaro.org, amit.daniel@samsung.com, patches@linaro.org

If 'dvfs_info' is NULL (due to devm_kzalloc failure) the failure
error message would try to dereference it. Use 'pdev' instead.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/cpufreq/exynos5440-cpufreq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/exynos5440-cpufreq.c b/drivers/cpufreq/exynos5440-cpufreq.c
index d514c15..be5380e 100644
--- a/drivers/cpufreq/exynos5440-cpufreq.c
+++ b/drivers/cpufreq/exynos5440-cpufreq.c
@@ -457,7 +457,7 @@ err_free_table:
 	opp_free_cpufreq_table(dvfs_info->dev, &dvfs_info->freq_table);
 err_put_node:
 	of_node_put(np);
-	dev_err(dvfs_info->dev, "%s: failed initialization\n", __func__);
+	dev_err(&pdev->dev, "%s: failed initialization\n", __func__);
 	return ret;
 }
 
-- 
1.7.9.5

