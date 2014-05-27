From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V4 8/8] cpufreq: exynos5440: don't initialize opp table
Date: Tue, 27 May 2014 17:20:57 +0530
Message-ID: <dc7793cebdf57d7b1201255a4594ae7316772327.1401191054.git.viresh.kumar@linaro.org>
References: <cover.1401191054.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:61050 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752491AbaE0Lxg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 27 May 2014 07:53:36 -0400
Received: by mail-pa0-f54.google.com with SMTP id bj1so9098001pad.27
        for <linux-pm@vger.kernel.org>; Tue, 27 May 2014 04:53:35 -0700 (PDT)
In-Reply-To: <cover.1401191054.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1401191054.git.viresh.kumar@linaro.org>
References: <cover.1401191054.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, arvind.chauhan@arm.com, inderpal.s@samsung.com, nm@ti.com, chander.kashyap@linaro.org, pavel@ucw.cz, len.brown@intel.com, sudeep.holla@arm.com, Viresh Kumar <viresh.kumar@linaro.org>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>

CPU OPP tables are already initialized by CPU core and we don't need to
reinitialize them from exynos5440's driver.

Cc: Amit Daniel Kachhap <amit.daniel@samsung.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/exynos5440-cpufreq.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/cpufreq/exynos5440-cpufreq.c b/drivers/cpufreq/exynos5440-cpufreq.c
index f33f25b..72a4206 100644
--- a/drivers/cpufreq/exynos5440-cpufreq.c
+++ b/drivers/cpufreq/exynos5440-cpufreq.c
@@ -360,12 +360,6 @@ static int exynos_cpufreq_probe(struct platform_device *pdev)
 		goto err_put_node;
 	}
 
-	ret = of_init_opp_table(dvfs_info->dev);
-	if (ret) {
-		dev_err(dvfs_info->dev, "failed to init OPP table: %d\n", ret);
-		goto err_put_node;
-	}
-
 	ret = dev_pm_opp_init_cpufreq_table(dvfs_info->dev,
 					    &dvfs_info->freq_table);
 	if (ret) {
-- 
2.0.0.rc2

