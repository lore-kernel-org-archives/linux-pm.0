From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 7/8] exynos5440: free OPP table created during ->init()
Date: Tue, 25 Nov 2014 16:04:22 +0530
Message-ID: <9b6cc4ddc2010abcac88c3995ce9ee29869cc195.1416910766.git.viresh.kumar@linaro.org>
References: <cover.1416910766.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:63876 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752414AbaKYKgC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 25 Nov 2014 05:36:02 -0500
Received: by mail-pd0-f170.google.com with SMTP id fp1so321738pdb.29
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2014 02:36:01 -0800 (PST)
In-Reply-To: <cover.1416910766.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1416910766.git.viresh.kumar@linaro.org>
References: <cover.1416910766.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, stefan.wahren@i2se.com, nm@ti.com, linux-arm-kernel@lists.infradead.org, sudeep.holla@arm.com, Viresh Kumar <viresh.kumar@linaro.org>

OPP layer now supports freeing of OPPs and we should free them once they aren't
useful anymore.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/exynos5440-cpufreq.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/exynos5440-cpufreq.c b/drivers/cpufreq/exynos5440-cpufreq.c
index f33f25b..27a57ed 100644
--- a/drivers/cpufreq/exynos5440-cpufreq.c
+++ b/drivers/cpufreq/exynos5440-cpufreq.c
@@ -371,7 +371,7 @@ static int exynos_cpufreq_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(dvfs_info->dev,
 			"failed to init cpufreq table: %d\n", ret);
-		goto err_put_node;
+		goto err_free_opp;
 	}
 	dvfs_info->freq_count = dev_pm_opp_get_opp_count(dvfs_info->dev);
 	exynos_sort_descend_freq_table();
@@ -423,6 +423,8 @@ static int exynos_cpufreq_probe(struct platform_device *pdev)
 
 err_free_table:
 	dev_pm_opp_free_cpufreq_table(dvfs_info->dev, &dvfs_info->freq_table);
+err_free_opp:
+	of_free_opp_table(dvfs_info->dev);
 err_put_node:
 	of_node_put(np);
 	dev_err(&pdev->dev, "%s: failed initialization\n", __func__);
@@ -433,6 +435,7 @@ static int exynos_cpufreq_remove(struct platform_device *pdev)
 {
 	cpufreq_unregister_driver(&exynos_driver);
 	dev_pm_opp_free_cpufreq_table(dvfs_info->dev, &dvfs_info->freq_table);
+	of_free_opp_table(dvfs_info->dev);
 	return 0;
 }
 
-- 
2.0.3.693.g996b0fd

